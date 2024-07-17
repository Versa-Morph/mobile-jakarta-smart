import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/components/custom_button.dart';
import 'package:smart_jakarta/utility/validators.dart';
import 'package:smart_jakarta/views/home/contact/cubit/contact_page_cubit.dart';
import 'package:smart_jakarta/views/home/contact/widgets/phone_textfield.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(27),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PhoneTextfield(
                textController: _phoneController,
                hintText: 'Phone Number',
                prefixImgPath: 'assets/icons/phone_icon.png',
                validator: (value) => Validators.basicValidator(value),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Add Contact',
                textColor: Colors.white,
                bgColor: const Color(0xFFD99022),
                onTap: () {
                  final isValid = _formKey.currentState?.validate();
                  final phoneNumber = _phoneController.text.trim();

                  if (isValid == true) {
                    context.read<ContactPageCubit>().addContact(phoneNumber);
                  }
                },
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Go Back',
                textColor: Colors.white,
                bgColor: const Color(0xFFD99022),
                onTap: () {
                  context.read<ContactPageCubit>().fetchUserContact();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
