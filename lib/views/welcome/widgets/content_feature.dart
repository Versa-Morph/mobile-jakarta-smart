import 'package:flutter/material.dart';

class ContentFeature extends StatelessWidget {
  const ContentFeature({
    super.key,
    required this.leadingImagePath,
    required this.contentText,
  });
  final String leadingImagePath;
  final List<InlineSpan> contentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xffFFFFFF)
            : Colors.black12,
        borderRadius: BorderRadius.circular(35),
      ),
      child: ListTile(
          leading: Image.asset(leadingImagePath),
          dense: true,
          horizontalTitleGap: 20,
          title: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xff2C2828),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              children: contentText,
            ),
          )),
    );
  }
}
