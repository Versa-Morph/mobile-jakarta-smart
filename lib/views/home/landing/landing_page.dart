import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulsator/pulsator.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/cubit/emergency_cubit/emergency_page_cubit.dart';
import 'package:smart_jakarta/views/home/cubit/home_page_cubit.dart';
import 'package:smart_jakarta/views/home/landing/widgets/emergency_button.dart';
import 'package:smart_jakarta/views/home/landing/widgets/service_type_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        appBarTitle: 'Home',
        userPictPath: 'assets/images/user_img_placeholder.png',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Header
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Hello, ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xff2C2828)
                            : const Color(0xff2C2828),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                          child: Text(
                        'Your Location',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? const Color(0xff2C2828)
                                    : const Color(0xff2C2828)),
                      )),
                      const Expanded(
                        child: Text(
                          'Senayan, Jakarta Selatan',
                          style: TextStyle(
                              color: Color(0xffD99022),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Header Text
            const SizedBox(height: 25),

            Text(
              'An Emergency?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0xff36393C),
              ),
            ),
            const SizedBox(height: 10),

            Text(
              'Just hold the button to call',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0xffa39e9e),
              ),
            ),

            // Emergency Button
            BlocBuilder<EmergencySituationCubit, EmergencySituationState>(
              builder: (context, state) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: state is EmergencyState
                      ? Pulsator(
                          style: const PulseStyle(
                            color: Color(0xffD99022),
                            startSize: 0.3,
                          ),
                          child: EmergencyButton(
                            onTap: () {
                              context.read<HomePageCubit>().clear();

                              context
                                  .read<EmergencySituationCubit>()
                                  .stopEmergency();
                            },
                          ),
                        )
                      : EmergencyButton(
                          onTap: () {
                            context
                                .read<EmergencySituationCubit>()
                                .emergencyOccured();
                          },
                        ),
                );
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Choose a service',
              style: TextStyle(
                color: Color(0xffA39E9E),
                fontWeight: FontWeight.w400,
              ),
            ),

            const SizedBox(height: 12),

            // Service Type
            BlocBuilder<EmergencySituationCubit, EmergencySituationState>(
              builder: (context, state) {
                return const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ServiceTypeButton(
                      title: 'There\'s a fire',
                      serviceImagePath: 'assets/icons/service_icon.png',
                    ),
                    ServiceTypeButton(
                      title: 'There\'s an accident',
                      serviceImagePath: 'assets/icons/service_icon2.png',
                    ),
                    ServiceTypeButton(
                      title: 'There\'s a crime',
                      serviceImagePath: 'assets/icons/service_icon3.png',
                    )
                  ],
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
