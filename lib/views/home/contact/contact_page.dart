import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/cubit/authenticaion_cubit/authentication_cubit.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/services/maps_api_service.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
          appBarTitle: 'Contact',
          userPictPath: 'assets/images/user_img_placeholder.png'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () async {
                    if (state is LocationAcquired) {
                      print(state.placemarks);
                    }
                    // final test = jsonDecode(token!);
                    // final asd = test['expires_in'];
                  },
                  child: const Icon(Icons.abc),
                );
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                  final token = localStorage.getString('token');
                  print(token);
                },
                child: const Text('TEST')),
            ElevatedButton(
                onPressed: () async {
                  final response = await MapsApiService().getDirection(
                      origin: LatLng(-6.203890878541474, 107.00424867191408),
                      destination:
                          LatLng(-6.184626513395576, 106.97906471489249));
                },
                child: const Text('tosst'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.read<AuthenticationCubit>().logout();
        Navigator.pushNamedAndRemoveUntil(
            context, '/welcome', (route) => false);
      }),
    );
  }
}
