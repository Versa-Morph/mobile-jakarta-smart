import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/views/home/landing/cubit/landing_page_cubit.dart';
import 'package:smart_jakarta/views/home/landing/view_states/landing_page_error.dart';
import 'package:smart_jakarta/views/home/landing/view_states/landing_page_loaded.dart';
import 'package:smart_jakarta/views/home/landing/view_states/landing_page_loading.dart';

class LandingPageProvider extends StatelessWidget {
  const LandingPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingPageCubit()..fetchAgencyData(),
      child: const LandingPage(),
    );
  }
}

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
        body: BlocBuilder<LandingPageCubit, LandingPageState>(
          builder: (context, state) {
            if (state is LandingPageLoadingState) {
              return const LandingPageLoading();
            } else if (state is LandingPageLoadedState) {
              return LandingPageLoaded(agencyList: state.agencyList);
            } else if (state is LandingPageErrorState) {
              return LandingPageError(
                errorMsg: state.errorMsg,
              );
            } else {
              return const LandingPageError(
                errorMsg: 'Something Wrong !',
              );
            }
          },
        ));
  }
}
