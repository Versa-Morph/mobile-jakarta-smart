import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_jakarta/components/custom_button.dart';
import 'package:smart_jakarta/services/user_data_service.dart';
import 'package:smart_jakarta/utility/validators.dart';
import 'package:smart_jakarta/views/home/profile/add_profile/widgets/custom_profile_textfield.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key});

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  XFile? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bloodTypeController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _nikController.dispose();
    _fullnameController.dispose();
    _nicknameController.dispose();
    _cityController.dispose();
    _ageController.dispose();
    _bloodTypeController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _addressController.dispose();
  }

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
        child: Form(
          key: _formKey,
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
                  textController: _phoneController,
                  hintText: 'Phone Number',
                  prefixImgPath: 'assets/icons/phone_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                /// Form NIK
                CustomProfileTextfield(
                  textController: _nikController,
                  hintText: 'nik',
                  prefixImgPath: 'assets/icons/profile_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                /// Form Fullname
                CustomProfileTextfield(
                  textController: _fullnameController,
                  hintText: 'Fullname',
                  prefixImgPath: 'assets/icons/profile_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                /// Form Nickname
                CustomProfileTextfield(
                  textController: _nicknameController,
                  hintText: 'Nickname',
                  prefixImgPath: 'assets/icons/profile_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                /// Form City
                CustomProfileTextfield(
                  textController: _cityController,
                  hintText: 'City',
                  prefixImgPath: 'assets/icons/city_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                /// Form Age
                CustomProfileTextfield(
                  textController: _ageController,
                  hintText: 'Age',
                  prefixImgPath: 'assets/icons/user_age_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                /// Form Bloodtype
                CustomProfileTextfield(
                  textController: _bloodTypeController,
                  hintText: 'Bloodtype',
                  prefixImgPath: 'assets/icons/blood_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                /// Form Height
                CustomProfileTextfield(
                  textController: _heightController,
                  hintText: 'Height',
                  prefixImgPath: 'assets/icons/heigth_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                /// Form Weight
                CustomProfileTextfield(
                  textController: _weightController,
                  hintText: 'Weight',
                  prefixImgPath: 'assets/icons/weigth_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                /// Form Address
                CustomProfileTextfield(
                  textController: _addressController,
                  hintText: 'Address',
                  prefixImgPath: 'assets/icons/address_icon.png',
                  validator: (value) => Validators.basicValidator(value),
                ),

                const SizedBox(height: 15),

                CustomButton(
                  text: 'Save',
                  textColor: Colors.white,
                  bgColor: const Color(0xFFD99022),
                  onTap: () {
                    UserDataService().storeUserBio(
                        '0899991111111',
                        '1231122334567',
                        _selectedImage!,
                        'diodio dio diodio',
                        'dio12345',
                        'jakarta selatan',
                        26,
                        'O',
                        170,
                        60,
                        'jl jakarta selatan 2 no5 jkt utara');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final selectedImage =
        await ImagePicker().pickImage(source: source, imageQuality: 50);

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
