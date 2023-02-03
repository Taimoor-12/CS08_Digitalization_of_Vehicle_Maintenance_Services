import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../constants.dart';

class EditName extends StatefulWidget {
  static const String routeName = '/edit-name';
  const EditName({Key? key}) : super(key: key);

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  late TextEditingController nameController;
  late TextEditingController lastnameController;
  AuthService authService = AuthService();

  bool _isInAsyncCall = false;

  @override
  void initState() {
    nameController = TextEditingController();
    lastnameController = TextEditingController();

    final user = Provider.of<UserProvider>(context, listen: false).user;
    nameController.text = user.firstName;
    lastnameController.text = user.lastName;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void setAsyncBool() {
    setState(() {
      _isInAsyncCall = false;
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Name',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: kPrimaryColor,
        foregroundColor: kTextColor,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.5,
        child: Container(
          height: size.height,
          padding: EdgeInsets.only(top: kDefaultPadding),
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit your name to be used to address you',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Enter something';
                      } else if (value != null &&
                          RegExp(r'^[a-zA-Z ]+$').hasMatch(value) == false) {
                        return 'Enter your first name';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'First name',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: lastnameController,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Enter something';
                      } else if (value != null &&
                          RegExp(r'^[a-zA-Z ]+$').hasMatch(value) == false) {
                        return 'Enter your last name';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Last name',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState != null) {
                          if (formKey.currentState?.validate() == true) {
                            print('validated');
                            FocusScope.of(context).unfocus();

                            if (user.role == 'email') {
                              setState(() {
                                _isInAsyncCall = true;
                              });
                              authService.sendNewName(
                                  context: context,
                                  firstname: nameController.text,
                                  lastname: lastnameController.text,
                                  func: setAsyncBool,
                                  id: user.id);
                            } else {
                              print(nameController.text);
                              setState(() {
                                _isInAsyncCall = true;
                              });
                              authService.sendNewNamePhone(
                                  context: context,
                                  firstname: nameController.text,
                                  lastname: lastnameController.text,
                                  func: setAsyncBool,
                                  id: user.id);
                            }
                          }
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
                        children: [
                          Icon(
                            Icons.save_as_sharp,
                            size: 30,
                          ),
                          SizedBox(
                            width: size.width * 0.28,
                          ),
                          Text(
                            "Save",
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
          ),
        ),
      ),
    );
  }
}
