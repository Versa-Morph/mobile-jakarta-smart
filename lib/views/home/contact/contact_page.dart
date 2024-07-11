import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/views/home/contact/cubit/contact_page_cubit.dart';
import 'package:smart_jakarta/views/home/contact/view_states/contact_page_empty.dart';
import 'package:smart_jakarta/views/home/contact/view_states/contact_page_error.dart';
import 'package:smart_jakarta/views/home/contact/view_states/contact_page_loaded.dart';
import 'package:smart_jakarta/views/home/contact/view_states/contact_page_loading.dart';

class ContactPageProvider extends StatelessWidget {
  const ContactPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactPageCubit()..fetchUserContact(),
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
          if (state is ContactPageLoadingState) {
            return const ContactPageLoading();
          } else if (state is ContactPageLoadedState) {
            return ContactPageLoaded(
              contactList: state.userContact,
            );
          } else if (state is ContactPageEmptyState) {
            return const ContactPageEmpty();
          } else {
            return const ContactPageError();
          }
        },
      ),
    );
  }
}
