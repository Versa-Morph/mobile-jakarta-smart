import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_jakarta/models/agency.dart';
import 'package:smart_jakarta/services/agency_services.dart';

part 'landing_page_state.dart';

class LandingPageCubit extends Cubit<LandingPageState> {
  LandingPageCubit() : super(LandingPageLoadingState());

  Future<void> fetchAgencyData() async {
    try {
      final agencyList = await AgencyServices().fetchAgencyData();

      if (agencyList != null) {
        emit(LandingPageLoadedState(agencyList));
      } else {
        emit(const LandingPageErrorState('Agency Failed to Load'));
      }
    } catch (e) {
      emit(LandingPageErrorState(e.toString()));
    }
  }
}
