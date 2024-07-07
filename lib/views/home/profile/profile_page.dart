import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/views/home/profile/cubit/profile_page_cubit.dart';
import 'package:smart_jakarta/views/home/profile/view_states/profile_page_empty.dart';
import 'package:smart_jakarta/views/home/profile/view_states/profile_page_error.dart';
import 'package:smart_jakarta/views/home/profile/view_states/profile_page_loaded.dart';
import 'package:smart_jakarta/views/home/profile/view_states/profile_page_loading.dart';

class ProfilePageProvider extends StatelessWidget {
  const ProfilePageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfilePageCubit()..fetchUserBio(),
      child: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        appBarTitle: 'Profile',
        userPictPath: 'assets/images/user_img_placeholder.png',
        isSettingsVisible: true,
      ),
      body: BlocBuilder<ProfilePageCubit, ProfilePageState>(
        builder: (context, state) {
          if (state is ProfilePageLoadingState) {
            return const ProfilePageLoading();
          } else if (state is ProfilePageLoadedState) {
            return ProfilePageLoaded(
              userBio: state.userBio,
            );
          } else if (state is ProfilePageEmptyState) {
            return const ProfilePageEmpty();
          } else {
            return const ProfilePageError();
          }
        },
      ),
    );
  }
}
