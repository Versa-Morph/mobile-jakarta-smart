import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_jakarta/cubit/theme_cubit/theme_cubit.dart';
import 'package:smart_jakarta/models/user_contact.dart';
import 'package:smart_jakarta/utility/string_capitalize.dart';
import 'package:smart_jakarta/views/home/contact/widgets/add_contact_button.dart';
import 'package:smart_jakarta/views/home/contact/widgets/contact_condition.dart';

class ContactPageLoaded extends StatelessWidget {
  const ContactPageLoaded({
    super.key,
    required this.contactList,
  });
  final List<UserContact> contactList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(27),
        child: Column(
          children: [
            ListView.builder(
              itemCount: contactList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = contactList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: ListTile(
                    // tileColor: const Color(0xffffffff),
                    tileColor: Colors.black12,
                    title: Text(
                      item.fullName.capitalize(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: context.read<ThemeCubit>().state.themeData ==
                                ThemeData.dark()
                            ? Colors.white
                            : const Color(0xff2C2828),
                      ),
                    ),
                    subtitle: Text(
                      item.phoneNumber,
                      style: TextStyle(
                        fontSize: 15,
                        color: context.read<ThemeCubit>().state.themeData ==
                                ThemeData.dark()
                            ? Colors.white
                            : const Color(0xffA39E9E),
                      ),
                    ),
                    leading: CircleAvatar(
                      radius: 40,
                      foregroundImage: NetworkImage(
                        item.profilePictPath,
                      ),
                      backgroundImage: const AssetImage(
                        'assets/images/placeholder_image_large.png',
                      ),
                      onForegroundImageError: (exception, stackTrace) {},
                      backgroundColor: Colors.black12,
                    ),
                    trailing: item.isDanger == true
                        ? ContactCondition(
                            text: 'In Danger',
                            isDanger: item.isDanger,
                          )
                        : ContactCondition(
                            text: 'Safe',
                            isDanger: item.isDanger,
                          ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 16,
                    ),
                  ),
                );
              },
            ),

            // add more button
            AddContactButton(
              onTap: () {
                // TODO: IMPLEMENT ONTAP
              },
            ),
          ],
        ),
      ),
    );
  }
}
