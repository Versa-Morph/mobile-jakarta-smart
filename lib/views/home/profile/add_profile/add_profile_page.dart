import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key});

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  XFile? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    _pickImageFromGallery();
                  },
                  child: CircleAvatar(
                    radius: 55,
                    foregroundImage: _selectedImage != null
                        ? FileImage(File(_selectedImage!.path))
                        : null,
                    backgroundImage: const AssetImage(
                      'assets/images/profile_img_placeholder.png',
                    ),
                    backgroundColor: Colors.black12,
                    child: _selectedImage != null
                        ? null
                        : const Icon(
                            Icons.camera_alt,
                            color: Colors.black38,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final selectedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _selectedImage = selectedImage;
    });
  }
}
