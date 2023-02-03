import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';

class DetailTile extends StatelessWidget {
  const DetailTile({
    Key? key,
    required this.size,
    required this.title,
    required this.content,
    required this.isObscure,
    required this.press,
  }) : super(key: key);

  final Size size;
  final String title;
  final String content;
  final bool isObscure;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: kDefaultPadding / 2,
          right: kDefaultPadding / 2,
          top: kDefaultPadding / 2),
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      height: size.height * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  press();
                },
                icon: Icon(Icons.edit),
              ),
            ],
          ),
          Text(
            isObscure ? '${content.replaceAll(RegExp(r"."), "*")}' : content,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      ),
    );
  }
}
