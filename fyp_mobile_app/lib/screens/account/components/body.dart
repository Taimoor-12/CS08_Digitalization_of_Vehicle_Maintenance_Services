import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/models/user_model.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/screens/account/components/personal_details.dart';
import 'package:fyp_mobile_app/screens/orders/orders.dart';
import 'package:fyp_mobile_app/screens/account/components/profilePageTop.dart';
import 'package:fyp_mobile_app/screens/account/components/top_buttons.dart';
import 'package:fyp_mobile_app/utils.dart';
import 'package:provider/provider.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService authService = AuthService();
  List<File> images = [];
  void selectImages() async {
    var res = await pickImages(context: context);
    setState(() {
      images = res;
    });
  }

  // late User user;
  // late NumberUser userNum;
  // Future<Object> getUserType() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? emailOrPhone = await prefs.getBool('email');
  //   if (emailOrPhone == true) {
  //     user = Provider.of<UserProvider>(context, listen: false).user;
  //     userNum;
  //   } else {
  //     return Provider.of<NumberProvider>(context, listen: false).numberUser;
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context).user;
    // return Column(
    //   children: [
    //     Container(
    //       margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
    //       // it will cover 20% of our total height
    //       height: size.height * 0.4,
    //       child: Stack(
    //         children: [
    //           Container(
    //             padding: EdgeInsets.only(
    //               left: kDefaultPadding,
    //               right: kDefaultPadding,
    //               bottom: kDefaultPadding,
    //             ),
    //             height: size.height * 0.4,
    //             width: size.width,
    //             decoration: BoxDecoration(
    //               color: kPrimaryColor,
    //               borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(36),
    //                 bottomRight: Radius.circular(36),
    //               ),
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.only(top: kDefaultPadding * 2),
    //               child: Text(
    //                 "Hi $name!",
    //                 style: Theme.of(context).textTheme.headline4?.copyWith(
    //                       color: Colors.white,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
    return Stack(
      children: [
        ProfilePageTop(size: size, user: user),
        Container(
          padding: EdgeInsets.only(
              top: kDefaultPadding * 3,
              left: kDefaultPadding,
              right: kDefaultPadding),
          margin: EdgeInsets.only(top: size.height * 0.27),
          width: size.width,
          decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Account',
                style: TextStyle(
                    fontSize: 22,
                    color: kTextColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PersonalDetails.routeName);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 30,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Personal details',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '>',
                      style: TextStyle(
                        fontSize: 22,
                        color: kTextColor.withOpacity(0.23),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              // GestureDetector(
              //   onTap: () {},
              //   child: Row(
              //     children: [
              //       Icon(
              //         Icons.car_repair,
              //         size: 30,
              //         color: kPrimaryColor,
              //       ),
              //       SizedBox(
              //         width: 30,
              //       ),
              //       Text(
              //         'Add a vehicle',
              //         style: TextStyle(
              //           fontSize: 22,
              //         ),
              //       ),
              //       Spacer(),
              //       Text(
              //         '>',
              //         style: TextStyle(
              //           fontSize: 22,
              //           color: kTextColor.withOpacity(0.23),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Orders.routeName);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.notes,
                      size: 30,
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Order history',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '>',
                      style: TextStyle(
                        fontSize: 22,
                        color: kTextColor.withOpacity(0.23),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                'Others',
                style: TextStyle(
                    fontSize: 22,
                    color: kTextColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 45,
              ),
              Container(
                width: size.width,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    authService.logOut(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    elevation: 4.5,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 30,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        /*top: 110,*/
        // right: 35,
        Positioned(
          top: size.height * 0.15,
          right: size.width * 0.07,
          child: user.image != null && user.image!.isNotEmpty
              ? GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(user.image!),
                  ),
                )
              : ProfilePicture(
                  name: user.firstName,
                  radius: 70,
                  fontsize: size.width / 7,
                ),
          // child: user.bufferImage != null && user.bufferImage!.isNotEmpty
          //     ? GestureDetector(
          //         onTap: () {},
          //         child: CircleAvatar(
          //           radius: 70,
          //           backgroundImage: MemoryImage(
          //             Uint8List.fromList(user.bufferImage!),
          //           ),
          //         ),
          //       )
          //     : ProfilePicture(
          //         name: user.firstName,
          //         radius: 70,
          //         fontsize: size.width / 7,
          //       ),

          // child: images.isNotEmpty
          //     ? GestureDetector(
          //         onTap: () {},
          //         child: CircleAvatar(
          //           radius: 70,
          //           backgroundImage: FileImage(images[0]),
          //         ),
          //       )
          //     : GestureDetector(
          //         onTap: selectImages,
          //         child: CircleAvatar(
          //           radius: 70,
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: Colors.white24,
          //               borderRadius: BorderRadius.all(Radius.circular(100)),
          //             ),
          //             child: Center(
          //               child: Text(
          //                 '+',
          //                 style: TextStyle(
          //                   fontSize: 50,
          //                   fontWeight: FontWeight.w300,
          //                   color: kTextColor.withOpacity(0.3),
          //                 ),
          //               ),
          //             ),
          //           ),
          //           // backgroundImage: NetworkImage(
          //           //     'https://images.unsplash.com/photo-1575844611398-2a68400b437c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80'),
          //         ),
          //       ),
        ),
      ],
    );
  }
}
