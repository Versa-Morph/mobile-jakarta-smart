import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/views/home/contact/contact_page.dart';
import 'package:smart_jakarta/views/home/cubit/home_page_cubit.dart';
import 'package:smart_jakarta/views/home/landing/landing_page.dart';
import 'package:smart_jakarta/views/home/maps/maps_page.dart';
import 'package:smart_jakarta/views/home/profile/profile_page.dart';

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

class HomePageProvider extends StatelessWidget {
  const HomePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit()..fetchUserCredential(),
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
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int currentServiceIndex = 0;

  final List<List<String>> includedTypes = [
    ['police'],
    ['fire_station'],
    ['fire_station', 'police'],
  ];

  List<String> selectedList = [];

  @override
  Widget build(BuildContext context) {
    switch (currentServiceIndex) {
      case 1:
        selectedList = includedTypes[0];
        break;
      case 2:
        selectedList = includedTypes[1];
        break;
      default:
        selectedList = includedTypes[2];
        break;
    }
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            children: [
              LandingPageProvider(
                onTap: (agencyId) {
                  setState(() {
                    currentServiceIndex = agencyId;
                  });

                  _pageController.jumpToPage(1);
                },
              ),
              MapsPageProvider(
                includedTypes: selectedList,
              ),
              const ContactPageProvider(),
              const ProfilePageProvider(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _bottomNavItem,
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xffD99022),
            unselectedItemColor: const Color(0xffA39E9E),
            onTap: (value) {
              _pageController.jumpToPage(value);
            },
          ),
        );
      },
    );
  }
}
