import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
          appBarTitle: 'Contact',
          userPictPath: 'assets/images/user_img_placeholder.png'),
      body: Center(
        child: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () async {
                SharedPreferences localStorage =
                    await SharedPreferences.getInstance();
                final token = localStorage.getString('token');

                if (state is LocationAcquired) {
                  print(state.placemarks);
                }
                // final test = jsonDecode(token!);
                // final asd = test['expires_in'];

                // context.read<AuthenticationCubit>().logout();
                // Navigator.pushNamedAndRemoveUntil(
                //     context, '/welcome', (route) => false);
              },
              child: const Icon(Icons.abc),
            );
          },
        ),
      ),
    );
  }
}
