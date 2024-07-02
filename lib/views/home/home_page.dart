import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/cubit/location_cubit/location_cubit.dart';
import 'package:smart_jakarta/views/home/contact/contact_page.dart';
import 'package:smart_jakarta/views/home/cubit/home_page_cubit.dart';
import 'package:smart_jakarta/views/home/landing/landing_page.dart';
import 'package:smart_jakarta/views/home/maps/maps_page.dart';
import 'package:smart_jakarta/views/home/profile/user_profile_page.dart';

final List<BottomNavigationBarItem> _bottomNavItem = [
  const BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(
        'assets/icons/home_icon.png',
      ),
    ),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(
        'assets/icons/location_icon.png',
      ),
    ),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(
        'assets/icons/contact_icon.png',
      ),
    ),
    label: '',
  ),
  const BottomNavigationBarItem(
    icon: ImageIcon(
      AssetImage(
        'assets/icons/profile_icon.png',
      ),
    ),
    label: '',
  ),
];

// // Screen List
// final List<Widget> _screenList = [
//   LandingPage(),
//   const MapsPageWrapper(),
//   const ContactPage(),
//   const UserProfilePage(),
// ];

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(
        locationCubit: context.read<LocationCubit>(),
      ),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: PageView(
            controller: context.read<HomePageCubit>().pageController,
            onPageChanged: (value) {
              context.read<HomePageCubit>().changeTab(value);
            },
            children: [
              LandingPage(
                navigateToMaps: (index) {
                  return context
                      .read<HomePageCubit>()
                      .pageController
                      .jumpToPage(
                        index,
                        // duration: const Duration(milliseconds: 1500),
                        // curve: Curves.fastOutSlowIn,
                      );
                },
              ),
              const MapsPageWrapper(),
              const ContactPage(),
              const UserProfilePage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _bottomNavItem,
            currentIndex: state.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xffD99022),
            unselectedItemColor: const Color(0xffA39E9E),
            onTap: (value) {
              context.read<HomePageCubit>().pageController.jumpToPage(value);
            },
          ),
        );
      },
    );
  }
}
