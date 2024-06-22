import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/views/home/cubit/home_navigation_cubit.dart';

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

// TODO: TEMPORARY SCREEN
final List<Widget> _bottomNavScreen = [
  const Center(child: Text('Landing Page')),
  const Center(child: Text('Map Page')),
  const Center(child: Text('Contact Page')),
  const Center(child: Text('Profile Page'))
];

class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeNavigationCubit(),
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
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeNavigationCubit, HomeNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (value) {
              context.read<HomeNavigationCubit>().changeTab(value);
            },
            children: _bottomNavScreen,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _bottomNavItem,
            currentIndex: state.tabIndex,
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
