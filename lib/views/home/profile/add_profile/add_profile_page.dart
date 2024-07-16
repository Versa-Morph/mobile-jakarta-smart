import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/views/home/profile/add_profile/cubit/add_profile_cubit.dart';
import 'package:smart_jakarta/views/home/profile/add_profile/view_states/create_profile_page.dart';
import 'package:smart_jakarta/views/home/profile/add_profile/view_states/update_profile_page.dart';

class AddProfilePageProvider extends StatelessWidget {
  const AddProfilePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProfileCubit()..fetchUserBio(),
      child: const AddProfilePage(),
    );
  }
}

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key});

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text('Your Profile'),
        centerTitle: true,
      ),
      body: BlocConsumer<AddProfileCubit, AddProfileState>(
        listener: (context, state) {
          if (state is AddProfileSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
            const snackBar = SnackBar(
              content: Text('Profile Successfully Saved'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is AddProfileError) {
            Navigator.pop(context);
            final snackBar = SnackBar(
              content: Text(state.errorMsg),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 140,
                left: 10,
                right: 10,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is AddProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CreateProfileState) {
            return const CreateProfilePage();
          } else if (state is UpdateProfileState) {
            return UpdateProfilePage(
              userBio: state.userBio,
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
