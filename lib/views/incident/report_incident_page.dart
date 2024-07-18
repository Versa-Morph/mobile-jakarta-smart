import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_jakarta/components/custom_button.dart';
import 'package:smart_jakarta/views/incident/widgets/incident_textfield.dart';

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

  @override
  Widget build(BuildContext context) {
    _textIdController.text = widget.marker.infoWindow.snippet!.substring(0, 8);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Incident'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
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
                IncidentTextField(
                  enabled: true,
                  labelText: 'Description',
                  controller: _descriptionController,
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
                const SizedBox(height: 15),
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
                CustomButton(
                  text: 'Report Incident',
                  textColor: Colors.white,
                  bgColor: const Color(0xFFD99022),
                  onTap: () {},
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
