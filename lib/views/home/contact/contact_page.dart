import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/components/home_appbar.dart';
import 'package:smart_jakarta/views/home/contact/cubit/contact_page_cubit.dart';
import 'package:smart_jakarta/views/home/contact/view_states/add_contact_page.dart';
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
    return BlocListener<ContactPageCubit, ContactPageState>(
      listener: (context, state) {
        if (state is AddContactPageState && state.errorMsg != null) {
          final snackBar = SnackBar(
            content: Text(state.errorMsg!),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 140,
              left: 10,
              right: 10,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
            } else if (state is AddContactPageState) {
              return const AddContactPage();
            } else {
              return const ContactPageError();
            }
          },
        ),
      ),
    );
  }
}
