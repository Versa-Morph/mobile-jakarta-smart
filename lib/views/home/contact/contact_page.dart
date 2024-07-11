import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/cubit/authenticaion_cubit/authentication_cubit.dart';
import 'package:smart_jakarta/views/home/contact/cubit/contact_page_cubit.dart';

class ContactPageProvider extends StatelessWidget {
  const ContactPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactPageCubit(),
      child: const ContactPage(),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
          appBarTitle: 'Contact',
          userPictPath: 'assets/images/user_img_placeholder.png'),
      body: BlocBuilder<ContactPageCubit, ContactPageState>(
        builder: (context, state) {
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        context.read<AuthenticationCubit>().logout();
        Navigator.pushNamedAndRemoveUntil(
            context, '/welcome', (route) => false);
      }),
    );
  }
}
