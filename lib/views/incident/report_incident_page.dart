import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_jakarta/components/custom_button.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/utility/validators.dart';
import 'package:smart_jakarta/views/incident/cubit/report_incident_cubit.dart';
import 'package:smart_jakarta/views/incident/widgets/incident_textfield.dart';

class ReportIncidentPageProvider extends StatelessWidget {
  const ReportIncidentPageProvider({super.key, required this.marker});
  final Marker marker;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportIncidentCubit(),
      child: ReportIncidentPage(
        marker: marker,
      ),
    );
  }
}

class ReportIncidentPage extends StatefulWidget {
  const ReportIncidentPage({super.key, required this.marker});
  final Marker marker;

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  XFile? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  final _textIdController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locationState = context.watch<LocationCubit>().state;
    if (locationState is LocationAcquired) {
      _latController.text = locationState.userLocation.latitude.toString();
      _lngController.text = locationState.userLocation.longitude.toString();
    }
    _textIdController.text = widget.marker.infoWindow.snippet!.substring(0, 8);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Incident'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: BlocListener<ReportIncidentCubit, ReportIncidentState>(
        listener: (context, state) {
          if (state is ReportSuccessState) {
            const snackBar = SnackBar(
              content: Text('Insiden Berhasil Dilaporkan'),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          } else if (state is ReportFailureState) {
            final snackBar = SnackBar(
              content: Text(state.errorMsg),
              duration: const Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  IncidentTextField(
                    enabled: false,
                    labelText: 'Report Id',
                    controller: _textIdController,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: IncidentTextField(
                          enabled: false,
                          labelText: 'Latitude',
                          controller: _latController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: IncidentTextField(
                          enabled: false,
                          labelText: 'Longitude',
                          controller: _lngController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  IncidentTextField(
                    enabled: true,
                    labelText: 'Description',
                    controller: _descriptionController,
                    validator: (value) => Validators.basicValidator(value),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _pickImageFromCamera();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD99022),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Take Photo',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  (_selectedImage != null)
                      ? const Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Incident Photo',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  Card(
                    child: _selectedImage != null
                        ? Image.file(File(_selectedImage!.path))
                        : const SizedBox(),
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<ReportIncidentCubit, ReportIncidentState>(
                    builder: (context, state) {
                      if (state is ReportLoadingState) {
                        return const CircularProgressIndicator();
                      } else {
                        return CustomButton(
                          text: 'Report Incident',
                          textColor: Colors.white,
                          bgColor: const Color(0xFFD99022),
                          onTap: () {
                            final isValid = _formKey.currentState?.validate();
                            final pluscode = _textIdController.text.trim();
                            final lat = _latController.text.trim();
                            final lng = _lngController.text.trim();
                            final desc = _descriptionController.text.trim();

                            if (isValid == true) {
                              context
                                  .read<ReportIncidentCubit>()
                                  .reportIncident(
                                    plusCode: pluscode,
                                    description: desc,
                                    incidentimage: _selectedImage!,
                                    latitude: double.parse(lat),
                                    longitude: double.parse(lng),
                                  );
                            }
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Go Back',
                    textColor: Colors.white,
                    bgColor: const Color(0xFFD99022),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    final selectedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _selectedImage = selectedImage;
    });
  }
}
