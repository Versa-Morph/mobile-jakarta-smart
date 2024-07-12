import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_jakarta/views/home/profile/add_profile/widgets/custom_profile_textfield.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text('Your Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          child: Column(
            children: [
              /// Profile picture section
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showAlertDialog(context);
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
              ),

              const SizedBox(height: 40),

              /// Form Phonenumber
              CustomProfileTextfield(
                hintText: 'Phone Number',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),

              /// Form NIK
              CustomProfileTextfield(
                hintText: 'nik',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),

              /// Form Fullname
              CustomProfileTextfield(
                hintText: 'Fullname',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),

              /// Form Nickname
              CustomProfileTextfield(
                hintText: 'Nickname',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),

              /// Form City
              CustomProfileTextfield(
                hintText: 'City',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),

              /// Form Age
              CustomProfileTextfield(
                hintText: 'Age',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),

              /// Form Bloodtype
              CustomProfileTextfield(
                hintText: 'Bloodtype',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),

              /// Form Height
              CustomProfileTextfield(
                hintText: 'Height',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),

              /// Form Weight
              CustomProfileTextfield(
                hintText: 'Weight',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),

              /// Form Address
              CustomProfileTextfield(
                hintText: 'Address',
                prefixImgPath: 'assets/icons/profile_icon.png',
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final selectedImage = await ImagePicker().pickImage(source: source);

    setState(() {
      _selectedImage = selectedImage;
    });
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text('Add Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Camera'),
                leading: const Icon(Icons.camera_alt_rounded),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Gallery'),
                leading: const Icon(Icons.image),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
