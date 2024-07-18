import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_jakarta/services/incident_services.dart';

part 'report_incident_state.dart';

class ReportIncidentCubit extends Cubit<ReportIncidentState> {
  ReportIncidentCubit() : super(ReportIncidentInitial());

  Future<void> reportIncident({
    required String plusCode,
    required String description,
    required XFile? incidentimage,
    required double latitude,
    required double longitude,
  }) async {
    emit(ReportLoadingState());
    try {
      if (incidentimage != null) {
        final result = await IncidentServices().reportIncident(
          plusCode: plusCode,
          description: description,
          incidentimage: incidentimage,
          latitude: latitude,
          longitude: longitude,
        );

        if (result == true) {
          emit(ReportSuccessState());
        } else {
          emit(const ReportFailureState('Error Reporting'));
        }
      } else {
        emit(const ReportFailureState('Image Cannot Empty'));
      }
    } catch (e) {
      emit(ReportFailureState(e.toString()));
    }
  }
}
