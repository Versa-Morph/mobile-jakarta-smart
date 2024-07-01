import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/cubit/emergency_cubit/emergency_page_cubit.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/cubit/theme_cubit/theme_cubit.dart';
import 'package:smart_jakarta/core/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => EmergencySituationCubit(),
        ),
        BlocProvider(
          create: (context) => LocationCubit()..getUserLocation(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Smart Jakarta',
            theme: state.themeData,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            onGenerateRoute: AppRoutes.onGenerateRoutes,
          );
        },
      ),
    );
  }
}
