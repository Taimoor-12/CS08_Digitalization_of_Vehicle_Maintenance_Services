import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/models/user_model.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/screens/account/components/detail_tile.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_email.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_name.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_password.dart';
import 'package:fyp_mobile_app/screens/registration/components/inputField.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../providers/user_provider.dart';
import 'package:fyp_mobile_app/utils.dart';

class PersonalDetails extends StatefulWidget {
  static const String routeName = '/personal-details';
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  AuthService authService = AuthService();

  bool _isSaved = false;
  bool _isInAsyncCall = false;

  @override
  void initState() {
    super.initState();
    getPassword();
  }

  void getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? password = await prefs.getString('password');
    if (password != null) {
      Provider.of<Email>(context, listen: false).setPassword(password);
    }
  }

  List<File> images = [];

  void selectImages() async {
    var res = await pickImages(context: context);
    setState(() {
      images = res;
    });
  }

  void setBoolTrue() {
    setState(() {
      _isSaved = true;
      _isInAsyncCall = false;
    });
  }

  void setBoolFalse() {
    setState(() {
      _isSaved = false;
      _isInAsyncCall = false;
      images.clear();
    });
  }

  Uint8List convertStringToUint8List(String str) {
    final List<int> codeUnits = str.codeUnits;
    final Uint8List unit8List = Uint8List.fromList(codeUnits);

    return unit8List;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context).user;
    // if (user.bufferImage != null && user.bufferImage!.isNotEmpty) {
    //   setState(() {
    //     _isSaved = true;
    //   });
    // }
    if (user.image != null && user.image!.isNotEmpty) {
      setState(() {
        _isSaved = true;
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Personal Details',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        foregroundColor: kTextColor,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // images.isNotEmpty ||
            //         (user.bufferImage != null && user.bufferImage!.isNotEmpty)
            //     ? GestureDetector(
            //         onTap: () {},
            //         child: CircleAvatar(
            //           radius: 60,
            //           backgroundImage: images.isEmpty
            //               ? MemoryImage(
            //                   Uint8List.fromList(user.bufferImage!),
            //                 )
            //               : MemoryImage(
            //                   Uint8List.fromList(images[0].readAsBytesSync()),
            //                 ),
            //         ),
            //       )

            images.isNotEmpty || (user.image != null && user.image!.isNotEmpty)
                ? GestureDetector(
                    onTap: () {},
                    child: images.isEmpty
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(user.image!),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(
                              Uint8List.fromList(images[0].readAsBytesSync()),
                            ),
                          ),
                    // child: CircleAvatar(
                    //   radius: 60,
                    //   backgroundImage: images.isEmpty
                    //       ? MemoryImage(
                    //           convertStringToUint8List(user.image!),
                    //         )
                    //       : MemoryImage(
                    //           Uint8List.fromList(images[0].readAsBytesSync()),
                    //         ),
                    // ),
                  )
                : GestureDetector(
                    onTap: selectImages,
                    child: CircleAvatar(
                      radius: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w300,
                              color: kTextColor,
                            ),
                          ),
                        ),
                      ),
                      // backgroundImage: NetworkImage(
                      //     'https://images.unsplash.com/photo-1575844611398-2a68400b437c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80'),
                    ),
                  ),

            images.isNotEmpty && _isSaved != true
                ? Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: kDefaultPadding * 6,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isInAsyncCall = true;
                            });

                            if (user.role == 'email') {
                              authService.addPic(
                                  context: context,
                                  image: images[0],
                                  func: setBoolTrue);
                            } else {
                              authService.addPicPhone(
                                  context: context,
                                  image: images[0],
                                  func: setBoolTrue);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            elevation: 4.5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.image,
                                size: 30,
                              ),
                              // SizedBox(
                              //   width: size.width * 0.2,
                              // ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Save image",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              images.clear();
                            });
                          },
                          icon: Icon(Icons.delete)),
                    ],
                  )
                : _isSaved == true
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: kDefaultPadding * 5,
                              right: kDefaultPadding * 5),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isInAsyncCall = true;
                              });

                              if (user.role == 'email') {
                                authService.removePic(
                                    context: context, func: setBoolFalse);
                              } else {
                                authService.removePicPhone(
                                    context: context, func: setBoolFalse);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              elevation: 4.5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 30,
                                ),
                                // SizedBox(
                                //   width: size.width * 0.2,
                                // ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Delete image",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),

            DetailTile(
              size: size,
              title: 'Name',
              content: user.firstName + " " + user.lastName,
              isObscure: false,
              press: () {
                Navigator.pushNamed(context, EditName.routeName);
              },
            ),

            // user.role == 'email'
            //     ? DetailTile(
            //         size: size,
            //         title: 'Email',
            //         content: user.email,
            //         isObscure: false,
            //         press: () {
            //           Navigator.pushNamed(context, EditEmail.routeName);
            //         },
            //       )
            //     : SizedBox(
            //         height: 0,
            //       ),
            DetailTile(
              size: size,
              title: 'Password',
              content: Provider.of<Email>(context).password,
              isObscure: true,
              press: () {
                Navigator.pushNamed(context, EditPassword.routeName);
              },
            ),
            // DetailTile(
            //   size: size,
            //   title: 'Address',
            //   content: user.address == '' ? '(Set your address)' : user.address,
            //   isObscure: false,
            //   press: () {
            //     print('Clicked');
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
