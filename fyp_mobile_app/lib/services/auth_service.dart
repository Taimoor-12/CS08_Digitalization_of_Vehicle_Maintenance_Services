import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/screens/login/components/check_email_screen.dart';
import 'package:fyp_mobile_app/screens/login/components/reset_password_page.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_otp.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_phone_otp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/error_handling.dart';
import 'package:fyp_mobile_app/models/user_model.dart';
import 'package:fyp_mobile_app/utils.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_email_otp.dart';

import '../screens/components/bottom_bar.dart';
import '../screens/dashboard/dashboard.dart';
import '../screens/login/login_screen.dart';

class AuthService {
  // sign up with phone

  void SignUpUserPhone({
    required BuildContext context,
    required VoidCallback func,
    required String phone,
    String? page,
  }) async {
    try {
      User user = User(
          id: '',
          firstName: '',
          lastName: '',
          email: '',
          password: '',
          address: '',
          role: '',
          token: '',
          number: phone);

      http.Response res = await http.post(
        Uri.parse('$uri2/customer/auth/register-phone'),
        body: jsonEncode({
          'number': phone,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('phone', phone);
            showSnackBar(context, 'OTP sent to your number');
            try {
              func();
              // Navigator.pushNamed(context, VerifyOTP.routeName);

              if (page != null && page == "Register") {
                Navigator.pushNamed(
                  context,
                  VerifyPhoneOTP.routeName,
                  arguments: VerifyPhoneOTP(phone: phone),
                );
              }
            } catch (e) {}
          },
          onFailure: () {
            try {
              func();
              // print(res.statusCode);
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  //verify Phone Number

  void verifyPhone({
    required BuildContext context,
    required String phone,
    required String otp,
    required String firstName,
    required String lastName,
    required VoidCallback func,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri2/customer/auth/verify-otp'),
        body: jsonEncode({
          "number": phone,
          "password": password,
          "firstname": firstName,
          "lastname": lastName,
          "otp": otp,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onFailure: () {
          try {
            func();
          } catch (e) {}
        },
        onSuccess: () async {
          showSnackBar(context, 'Account created! Number verified');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          func();
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  //sign up user with email

  void SignUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required VoidCallback func,
    required String firstName,
    required String lastName,
    String? page,
  }) async {
    try {
      User user = User(
        id: '',
        // name: name,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        address: '',
        token: '',
        number: '',
        role: '',
        // cart: [],
      );

      http.Response res = await http.post(
        Uri.parse('$uri2/customer/auth/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onFailure: () {
          try {
            func();
          } catch (e) {}
        },
        onSuccess: () {
          try {
            func();
          } catch (e) {}

          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          User user = userProvider.user.copyWith(
            id: jsonDecode(res.body)['userId'],
          );
          userProvider.setUserFromModel(user);
          // showSnackBar(
          //     context, 'Account created! Login with the same credentials');
          showSnackBar(context, 'Verification code sent to your email');
          // Navigator.pushNamedAndRemoveUntil(
          //     context, LoginScreen.routeName, (route) => false);

          if (page != null && page == "Register") {
            Navigator.pushNamed(context, VerifyEmailOTPScreen.routeName);
          }
        },
      );
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  void verifyEmailOTP({
    required BuildContext context,
    required String userId,
    required String code,
    required VoidCallback func,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri2/customer/auth/verifyOTP'),
        body: jsonEncode({
          'userId': userId,
          'otp': code,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          try {
            func();
          } catch (e) {}

          if (jsonDecode(res.body)['status'] == "failed") {
            showSnackBar(context, jsonDecode(res.body)['message']);
          } else {
            showSnackBar(context, jsonDecode(res.body)['message']);
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.routeName, (route) => false);
          }
        },
        onFailure: () {
          try {
            func();
          } catch (e) {}
        },
      );
    } catch (e) {
      // TODO
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  //sign in user
  void SignInUser({
    required BuildContext context,
    required String email,
    required String password,
    required VoidCallback func,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', password);
      await prefs.setBool('email', true);

      http.Response res = await http.post(
        Uri.parse('$uri2/customer/auth/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      var verifiedDynamic = jsonDecode(res.body)['verified'];
      String verified = verifiedDynamic?.toString() ?? '';

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () async {
            if (verified == "false") {
              showSnackBar(context, 'Login failed. Verify your email.');
              return;
            }

            // SharedPreferences.setMockInitialValues({});
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            var userProvider =
                Provider.of<UserProvider>(context, listen: false);

            print(res.body);

            userProvider.setUser(res.body);
            // print(userProvider.user.id);
            // print(userProvider.user.role);

            User user = userProvider.user.copyWith(
              role: 'email',
              id: jsonDecode(res.body)['userId'],
            );
            userProvider.setUserFromModel(user);
            // print(userProvider.user.role);
            // print(userProvider.user.id);

            // List<dynamic> bufferDynamic =
            //     jsonDecode(res.body)['image']['data']['data'];
            // List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();

            // userProvider.user.role = 'email';
            // userProvider.setUser(userProvider.user.toJson());

            // print(jsonDecode(res.body)['userId']);
            // userProvider.user.id = jsonDecode(res.body)['userId'];
            // userProvider.setUser(userProvider.user.toJson());
            // print(userProvider.user.toJson());

            try {
              if (jsonDecode(res.body)['image']['data']['data'] != null) {
                List<dynamic> bufferDynamic =
                    jsonDecode(res.body)['image']['data']['data'];
                List<int> bufferInt =
                    bufferDynamic.map((e) => e as int).toList();

                User user = userProvider.user.copyWith(
                  bufferImage: bufferInt,
                );
                userProvider.setUserFromModel(user);
                print(userProvider.user.toJson());
              }
            } catch (e) {}

            // print(jsonDecode(res.body)['message']);

            // userProvider.user.role = 'email';
            // print(userProvider.user.toJson());
            // userProvider.notify();

            // var finalUserProvider =
            //     Provider.of<FinalUserProvider>(context, listen: false);
            // finalUserProvider.setUser(res.body);

            // print(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            await prefs.setString(
                'firstname', jsonDecode(res.body)['firstname']);
            try {
              func();
              Navigator.pushNamedAndRemoveUntil(
                context,
                BottomBar.routeName,
                (route) => false,
              );
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  //sign in with Phone

  void SignInUserPhone({
    required BuildContext context,
    required String phone,
    required String password,
    required VoidCallback func,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', password);
      await prefs.setBool('email', false);

      http.Response res = await http.post(
        Uri.parse('$uri2/customer/auth/login-phone'),
        body: jsonEncode({
          'number': phone,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () async {
            // SharedPreferences.setMockInitialValues({});
            SharedPreferences prefs = await SharedPreferences.getInstance();
            // Provider.of<NumberProvider>(context, listen: false)
            //     .setUser(res.body);

            print(jsonDecode(res.body));

            var userProvider =
                Provider.of<UserProvider>(context, listen: false);

            userProvider.setUser(res.body);
            // print(userProvider.user.id);
            // print(userProvider.user.role);

            User user = userProvider.user.copyWith(
              role: 'number',
            );
            userProvider.setUserFromModel(user);
            print(userProvider.user.id);
            print(userProvider.user.role);
            print(userProvider.user.token);

            // userProvider.setUser(res.body);
            // userProvider.user.role = 'number';
            // userProvider.setUser(userProvider.user.toJson());
            // userProvider.user.id = jsonDecode(res.body)['_id'];
            // userProvider.setUser(userProvider.user.toJson());
            // print(userProvider.user.toJson());

            try {
              // if (jsonDecode(res.body)['image']['data']['data'] != null) {
              //   List<dynamic> bufferDynamic =
              //       jsonDecode(res.body)['image']['data']['data'];
              //   List<int> bufferInt =
              //       bufferDynamic.map((e) => e as int).toList();
              //
              //   User user = userProvider.user.copyWith(
              //     bufferImage: bufferInt,
              //   );
              //   userProvider.setUserFromModel(user);
              //   print(userProvider.user.toJson());
              // }
            } catch (e) {}

            print(Provider.of<UserProvider>(context, listen: false).user.token);
            print(jsonDecode(res.body)['token']);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            try {
              func();
              Navigator.pushNamedAndRemoveUntil(
                context,
                BottomBar.routeName,
                (route) => false,
              );
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  // fetchData pracitice
  // void getData() async {
  //   http.Response userRes = await http.get(
  //     Uri.parse('$uri/api/services/'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //
  //   var response = jsonDecode(userRes.body);
  //   for (var res in response) {
  //     print(res['firstname']);
  //   }
  // }

  //get user data
  Future<void> getUserData({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? emailPhone = prefs.getBool('email');

      if (emailPhone == true) {
        String? token = prefs.getString('x-auth-token');

        if (token == null) {
          prefs.setString('x-auth-token', '');
        }

        var tokenRes = await http.post(
          Uri.parse('$uri2/customer/auth/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          },
        );
        print(jsonDecode(tokenRes.body));

        var response = jsonDecode(tokenRes.body);

        if (response == true) {
          // get user data
          http.Response userRes = await http.get(
            Uri.parse('$uri2/customer/auth/persistentLoginFlutter'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-access-token': token
            },
          );
          // print(jsonDecode(userRes.body));

          var userProvider = Provider.of<UserProvider>(context, listen: false);

          userProvider.setUser(userRes.body);
          User user = userProvider.user.copyWith(
            role: 'email',
            token: token,
          );
          userProvider.setUserFromModel(user);
          print(userProvider.user.id);
          print(userProvider.user.role);
          print(userProvider.user.token);

          // userProvider.user.role = 'email';
          //
          // userProvider.setUser(userProvider.user.toJson());
          //
          // userProvider.user.id = jsonDecode(userRes.body)['_id'];
          // userProvider.setUser(userProvider.user.toJson());
          // print(userProvider.user.toJson());

          try {
            // List<dynamic> bufferDynamic =
            //     jsonDecode(userRes.body)['image']['data']['data'];
            // List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();

            // if (jsonDecode(userRes.body)['image'] != null) {
            //   User user = userProvider.user.copyWith(
            //     image: jsonDecode(userRes.body)['image'].toString(),
            //   );
            //   userProvider.setUserFromModel(user);
            //   print(userProvider.user.toJson());
            // }
          } catch (e) {}

          // var finalUserProvider =
          //     Provider.of<FinalUserProvider>(context, listen: false);
          // finalUserProvider.setUser(userProvider.user);
        }
      } else {
        String? token = prefs.getString('x-auth-token');

        if (token == null) {
          prefs.setString('x-auth-token', '');
        }

        var tokenRes = await http.post(
          Uri.parse('$uri2/customer/auth/tokenIsValidPhone'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          },
        );

        var response = jsonDecode(tokenRes.body);
        print(response);

        if (response == true) {
          // get user data
          http.Response userRes = await http.get(
            Uri.parse('$uri2/customer/auth/persistentLoginFlutterPhone'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-access-token': token
            },
          );

          print(jsonDecode(userRes.body));

          var userProvider = Provider.of<UserProvider>(context, listen: false);

          userProvider.setUser(userRes.body);
          User user = userProvider.user.copyWith(
            role: 'number',
            token: token,
          );
          userProvider.setUserFromModel(user);
          print(userProvider.user.id);
          print(userProvider.user.role);
          print(userProvider.user.token);

          // userProvider.setUser(userRes.body);
          // userProvider.user.role = 'number';
          // userProvider.setUser(userProvider.user.toJson());
          //
          // userProvider.user.id = jsonDecode(userRes.body)['_id'];
          // userProvider.setUser(userProvider.user.toJson());
          // print(userProvider.user.toJson());

          try {
            // List<dynamic> bufferDynamic =
            //     jsonDecode(userRes.body)['image']['data']['data'];
            // List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
            //
            // User user = userProvider.user.copyWith(
            //   bufferImage: bufferInt,
            // );
            // userProvider.setUserFromModel(user);
            // print(userProvider.user.toJson());
          } catch (e) {}
        }
      }

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSuccess: () async {
      //       SharedPreferences.setMockInitialValues({});
      //       SharedPreferences prefs = await SharedPreferences.getInstance();
      //       Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //       await prefs.setString(
      //           'x-auth-token', jsonDecode(res.body)['token']);
      //       await prefs.setString('Name', jsonDecode(res.body)['name']);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return Dashboard();
      //           },
      //         ),
      //       );
      //     });
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }

  //get user data
  Future<void> getUserDataPhone({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('$uri/api/users/tokenIsValidPhone'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/api/users/phoneToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
      }

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      // httpErrorHandle(
      //     response: res,
      //     context: context,
      //     onSuccess: () async {
      //       SharedPreferences.setMockInitialValues({});
      //       SharedPreferences prefs = await SharedPreferences.getInstance();
      //       Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //       await prefs.setString(
      //           'x-auth-token', jsonDecode(res.body)['token']);
      //       await prefs.setString('Name', jsonDecode(res.body)['name']);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) {
      //             return Dashboard();
      //           },
      //         ),
      //       );
      //     });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      await sharedPreferences.setString('password', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // void sendResetEmail(
  //     {required BuildContext context,
  //     required String email,
  //     required VoidCallback func}) async {
  //   try {
  //     var res = await http.put(Uri.parse('$uri/api/users/forgot'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode({
  //           'email': email,
  //         }));
  //
  //     // http.Response res = await http.post(
  //     //   Uri.parse('$uri/api/users/login'),
  //     //   body: jsonEncode({
  //     //     'email': email,
  //     //     'password': password,
  //     //   }),
  //     //   headers: <String, String>{
  //     //     'Content-Type': 'application/json; charset=UTF-8',
  //     //   },
  //     // );
  //
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onFailure: () {},
  //         onSuccess: () async {
  //           try {
  //             func();
  //             Navigator.pushNamed(context, PasswordResetPage.routeName);
  //           } catch (e) {}
  //         });
  //   } catch (e) {
  //     try {
  //       func();
  //     } catch (e) {}
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void sendResetEmail(
      {required BuildContext context,
      required String email,
      required VoidCallback func}) async {
    try {
      var res = await http.put(Uri.parse('$uri2/customer/auth/forgotPassword'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'email': email,
          }));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () async {
            try {
              func();
              // Navigator.pushNamed(context, PasswordResetPage.routeName);
              Navigator.pushNamed(context, CheckEmailScreen.routeName);
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  void sendNewPassword(
      {required BuildContext context,
      required String resetLink,
      required VoidCallback func,
      required String password}) async {
    try {
      var res = await http.put(Uri.parse('$uri/api/users/reset'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'resetLink': resetLink,
            'newPass': password,
          }));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () async {
            try {
              func();
              Navigator.pushNamed(context, LoginScreen.routeName);
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  // void sendNewName(
  //     {required BuildContext context,
  //     required String name,
  //     required VoidCallback func}) async {
  //   try {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //
  //     var res = await http.put(Uri.parse('$uri/api/users/edit-name'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token,
  //         },
  //         body: jsonEncode({'name': name}));
  //
  //     // http.Response res = await http.post(
  //     //   Uri.parse('$uri/api/users/login'),
  //     //   body: jsonEncode({
  //     //     'email': email,
  //     //     'password': password,
  //     //   }),
  //     //   headers: <String, String>{
  //     //     'Content-Type': 'application/json; charset=UTF-8',
  //     //   },
  //     // );
  //
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onFailure: () {
  //           try {
  //             func();
  //           } catch (e) {}
  //         },
  //         onSuccess: () {
  //           showSnackBar(context, 'Your name is updated');
  //           User user = userProvider.user.copyWith(
  //             name: jsonDecode(res.body)['name'],
  //           );
  //           userProvider.setUserFromModel(user);
  //           try {
  //             func();
  //           } catch (e) {}
  //         });
  //   } catch (e) {
  //     try {
  //       func();
  //     } catch (e) {}
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void sendNewName(
      {required BuildContext context,
      required String firstname,
      required String lastname,
      required String id,
      required VoidCallback func}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      var res =
          await http.put(Uri.parse('$uri2/customer/account/updateProfile/$id'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-access-token': userProvider.user.token,
              },
              body: jsonEncode({
                'firstname': firstname,
                'lastname': lastname,
              }));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () {
            showSnackBar(context, 'Your name is updated');
            User user = userProvider.user.copyWith(
              firstName: firstname,
              lastName: lastname,
            );
            userProvider.setUserFromModel(user);
            try {
              func();
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  void sendNewNamePhone(
      {required BuildContext context,
      required String firstname,
      required String lastname,
      required String id,
      required VoidCallback func}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      var res = await http.put(
          Uri.parse('$uri2/customer/account/updateProfilePhone/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-access-token': userProvider.user.token,
          },
          body: jsonEncode({
            'firstname': firstname,
            'lastname': lastname,
          }));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () {
            showSnackBar(context, 'Your name is updated');
            User user = userProvider.user.copyWith(
              firstName: firstname,
              lastName: lastname,
            );
            userProvider.setUserFromModel(user);
            try {
              func();
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  // void sendNewNamePhone(
  //     {required BuildContext context,
  //     required String name,
  //     required VoidCallback func}) async {
  //   try {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     var res = await http.put(Uri.parse('$uri/api/users/edit-namePhone'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token,
  //         },
  //         body: jsonEncode({'name': name}));
  //
  //     // http.Response res = await http.post(
  //     //   Uri.parse('$uri/api/users/login'),
  //     //   body: jsonEncode({
  //     //     'email': email,
  //     //     'password': password,
  //     //   }),
  //     //   headers: <String, String>{
  //     //     'Content-Type': 'application/json; charset=UTF-8',
  //     //   },
  //     // );
  //
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onFailure: () {
  //           try {
  //             func();
  //           } catch (e) {}
  //         },
  //         onSuccess: () {
  //           showSnackBar(context, 'Your name is updated');
  //           User user = userProvider.user.copyWith(
  //             name: jsonDecode(res.body)['name'],
  //           );
  //           userProvider.setUserFromModel(user);
  //           try {
  //             func();
  //           } catch (e) {}
  //         });
  //   } catch (e) {
  //     try {
  //       func();
  //     } catch (e) {}
  //     showSnackBar(context, e.toString());
  //   }
  // }

  // void updatePassword(
  //     {required BuildContext context,
  //     required String newPassword,
  //     required VoidCallback func}) async {
  //   try {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('password', newPassword);
  //
  //     var res = await http.put(Uri.parse('$uri/api/users/edit-password'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token,
  //         },
  //         body: jsonEncode({'password': newPassword}));
  //
  //     // http.Response res = await http.post(
  //     //   Uri.parse('$uri/api/users/login'),
  //     //   body: jsonEncode({
  //     //     'email': email,
  //     //     'password': password,
  //     //   }),
  //     //   headers: <String, String>{
  //     //     'Content-Type': 'application/json; charset=UTF-8',
  //     //   },
  //     // );
  //
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onFailure: () {
  //           try {
  //             func();
  //           } catch (e) {}
  //         },
  //         onSuccess: () {
  //           showSnackBar(context, 'Your password is updated');
  //           User user = userProvider.user.copyWith(
  //             password: jsonDecode(res.body)['password'],
  //           );
  //           userProvider.setUserFromModel(user);
  //           Provider.of<Email>(context, listen: false).setPassword(newPassword);
  //           try {
  //             func();
  //           } catch (e) {}
  //         });
  //   } catch (e) {
  //     try {
  //       func();
  //     } catch (e) {}
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void updatePassword(
      {required BuildContext context,
      required String id,
      required String newPassword,
      required VoidCallback func}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', newPassword);

      var res =
          await http.put(Uri.parse('$uri2/customer/account/updatePassword/$id'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-access-token': userProvider.user.token,
              },
              body: jsonEncode({'password': newPassword}));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
      print(jsonDecode(res.body));

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () {
            showSnackBar(context, 'Your password is updated');
            User user = userProvider.user.copyWith(
              password: jsonDecode(res.body)['password'],
            );
            userProvider.setUserFromModel(user);
            Provider.of<Email>(context, listen: false).setPassword(newPassword);
            try {
              func();
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  // void updatePasswordPhone(
  //     {required BuildContext context,
  //     required String newPassword,
  //     required VoidCallback func}) async {
  //   try {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('password', newPassword);
  //
  //     var res = await http.put(Uri.parse('$uri/api/users/edit-passwordPhone'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token,
  //         },
  //         body: jsonEncode({'password': newPassword}));
  //
  //     // http.Response res = await http.post(
  //     //   Uri.parse('$uri/api/users/login'),
  //     //   body: jsonEncode({
  //     //     'email': email,
  //     //     'password': password,
  //     //   }),
  //     //   headers: <String, String>{
  //     //     'Content-Type': 'application/json; charset=UTF-8',
  //     //   },
  //     // );
  //
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onFailure: () {
  //           try {
  //             func();
  //           } catch (e) {}
  //         },
  //         onSuccess: () {
  //           showSnackBar(context, 'Your password is updated');
  //           User user = userProvider.user.copyWith(
  //             password: jsonDecode(res.body)['password'],
  //           );
  //           userProvider.setUserFromModel(user);
  //           Provider.of<Email>(context, listen: false).setPassword(newPassword);
  //           try {
  //             func();
  //           } catch (e) {}
  //         });
  //   } catch (e) {
  //     try {
  //       func();
  //     } catch (e) {}
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void updatePasswordPhone(
      {required BuildContext context,
      required String id,
      required String newPassword,
      required VoidCallback func}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('password', newPassword);

      var res = await http.put(
          Uri.parse('$uri2/customer/account/updatePasswordPhone/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-access-token': userProvider.user.token,
          },
          body: jsonEncode({'password': newPassword}));

      print(jsonDecode(res.body));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () {
            showSnackBar(context, 'Your password is updated');
            User user = userProvider.user.copyWith(
              password: jsonDecode(res.body)['password'],
            );
            userProvider.setUserFromModel(user);
            Provider.of<Email>(context, listen: false).setPassword(newPassword);
            try {
              func();
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  void updateEmail(
      {required BuildContext context,
      required String email,
      required VoidCallback func}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('password', newPassword);

      var res = await http.put(Uri.parse('$uri/api/users/edit-email'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({'email': email}));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () {
            showSnackBar(context, 'Your email is updated');
            User user = userProvider.user.copyWith(
              email: jsonDecode(res.body)['email'],
            );
            userProvider.setUserFromModel(user);
            try {
              func();
            } catch (e) {}
            // Provider.of<Email>(context, listen: false).setEmail(email);
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  // void addPic(
  //     {required BuildContext context,
  //     required File image,
  //     required VoidCallback func}) async {
  //   try {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     // SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // await prefs.setString('password', newPassword);
  //
  //     var response =
  //         http.MultipartRequest('POST', Uri.parse('$uri/api/users/upload'));
  //     response.files.add(await http.MultipartFile.fromBytes(
  //         'testImage', image.readAsBytesSync(),
  //         filename: image.path.split('/').last));
  //
  //     // response.fields['testImage'] = image.toString();
  //
  //     response.headers['x-auth-token'] = userProvider.user.token;
  //
  //     var res = await response.send();
  //
  //     var responseFinal = await http.Response.fromStream(res);
  //
  //     // var res = await http.post(Uri.parse('$uri/api/users/upload'),
  //     //     headers: <String, String>{
  //     //       // 'Content-Type': 'application/json; charset=UTF-8',
  //     //       'x-auth-token': userProvider.user.token,
  //     //     },
  //     //     body: ({'originalname': image.readAsBytesSync()}));
  //
  //     // http.Response res = await http.post(
  //     //   Uri.parse('$uri/api/users/login'),
  //     //   body: jsonEncode({
  //     //     'email': email,
  //     //     'password': password,
  //     //   }),
  //     //   headers: <String, String>{
  //     //     'Content-Type': 'application/json; charset=UTF-8',
  //     //   },
  //     // );
  //
  //     httpErrorHandle(
  //         response: responseFinal,
  //         context: context,
  //         onFailure: () {
  //           try {
  //             func();
  //           } catch (e) {}
  //         },
  //         onSuccess: () {
  //           showSnackBar(context, 'Image saved');
  //           // final result = jsonDecode(responseFinal.body) as Map<String, dynamic>;
  //           List<dynamic> bufferDynamic =
  //               jsonDecode(responseFinal.body)['image']['data']['data'];
  //           List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
  //
  //           User user = userProvider.user.copyWith(
  //             bufferImage: bufferInt,
  //           );
  //           userProvider.setUserFromModel(user);
  //           // print(userProvider.user.bufferImage);
  //
  //           try {
  //             func();
  //           } catch (e) {}
  //         });
  //   } catch (e) {
  //     try {
  //       func();
  //     } catch (e) {}
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void addPic(
      {required BuildContext context,
      required File image,
      required VoidCallback func}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('password', newPassword);

      var response = http.MultipartRequest(
          'POST', Uri.parse('$uri2/customer/account/add-profile-picture'));
      response.files.add(
        await http.MultipartFile.fromBytes(
          'image', image.readAsBytesSync(),
          // filename: image.path.split('/').last
        ),
      );

      // response.fields['testImage'] = image.toString();

      response.headers['x-access-token'] = userProvider.user.token;

      var res = await response.send();

      // print('yo');

      var responseFinal = await http.Response.fromStream(res);

      // var res = await http.post(Uri.parse('$uri/api/users/upload'),
      //     headers: <String, String>{
      //       // 'Content-Type': 'application/json; charset=UTF-8',
      //       'x-auth-token': userProvider.user.token,
      //     },
      //     body: ({'originalname': image.readAsBytesSync()}));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: responseFinal,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () {
            showSnackBar(context, 'Image saved');
            // final result = jsonDecode(responseFinal.body) as Map<String, dynamic>;
            // List<dynamic> bufferDynamic =
            //     jsonDecode(responseFinal.body)['image']['data']['data'];
            // List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();

            User user = userProvider.user.copyWith(
              image: jsonDecode(responseFinal.body)['image'].toString(),
            );
            userProvider.setUserFromModel(user);
            // print(userProvider.user.bufferImage);

            try {
              func();
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  // void addPicPhone(
  //     {required BuildContext context,
  //     required File image,
  //     required VoidCallback func}) async {
  //   try {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     // SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // await prefs.setString('password', newPassword);
  //
  //     var response =
  //         http.MultipartRequest('POST', Uri.parse('$uri/api/users/uploadNum'));
  //     response.files.add(await http.MultipartFile.fromBytes(
  //         'testImage', image.readAsBytesSync(),
  //         filename: image.path.split('/').last));
  //
  //     // response.fields['testImage'] = image.toString();
  //
  //     response.headers['x-auth-token'] = userProvider.user.token;
  //
  //     var res = await response.send();
  //
  //     var responseFinal = await http.Response.fromStream(res);
  //
  //     // var res = await http.post(Uri.parse('$uri/api/users/upload'),
  //     //     headers: <String, String>{
  //     //       // 'Content-Type': 'application/json; charset=UTF-8',
  //     //       'x-auth-token': userProvider.user.token,
  //     //     },
  //     //     body: ({'originalname': image.readAsBytesSync()}));
  //
  //     // http.Response res = await http.post(
  //     //   Uri.parse('$uri/api/users/login'),
  //     //   body: jsonEncode({
  //     //     'email': email,
  //     //     'password': password,
  //     //   }),
  //     //   headers: <String, String>{
  //     //     'Content-Type': 'application/json; charset=UTF-8',
  //     //   },
  //     // );
  //
  //     httpErrorHandle(
  //         response: responseFinal,
  //         context: context,
  //         onFailure: () {
  //           try {
  //             func();
  //           } catch (e) {}
  //         },
  //         onSuccess: () {
  //           showSnackBar(context, 'Image saved');
  //           // final result = jsonDecode(responseFinal.body) as Map<String, dynamic>;
  //           List<dynamic> bufferDynamic =
  //               jsonDecode(responseFinal.body)['image']['data']['data'];
  //           List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
  //
  //           User user = userProvider.user.copyWith(
  //             bufferImage: bufferInt,
  //           );
  //           userProvider.setUserFromModel(user);
  //           // print(userProvider.user.bufferImage);
  //
  //           try {
  //             func();
  //           } catch (e) {}
  //         });
  //   } catch (e) {
  //     try {
  //       func();
  //     } catch (e) {}
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void addPicPhone(
      {required BuildContext context,
      required File image,
      required VoidCallback func}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('password', newPassword);

      var response = http.MultipartRequest('POST',
          Uri.parse('$uri2/customer/account/add-profile-picture-phone'));
      response.files.add(
        await http.MultipartFile.fromBytes(
          'image',
          image.readAsBytesSync(),
          // filename: image.path.split('/').last,
        ),
      );

      // response.fields['testImage'] = image.toString();

      response.headers['x-access-token'] = userProvider.user.token;

      var res = await response.send();

      var responseFinal = await http.Response.fromStream(res);

      // var res = await http.post(Uri.parse('$uri/api/users/upload'),
      //     headers: <String, String>{
      //       // 'Content-Type': 'application/json; charset=UTF-8',
      //       'x-auth-token': userProvider.user.token,
      //     },
      //     body: ({'originalname': image.readAsBytesSync()}));

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/users/login'),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );

      httpErrorHandle(
          response: responseFinal,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () {
            showSnackBar(context, 'Image saved');
            // final result = jsonDecode(responseFinal.body) as Map<String, dynamic>;
            // List<dynamic> bufferDynamic =
            //     jsonDecode(responseFinal.body)['image']['data']['data'];
            // List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();

            User user = userProvider.user.copyWith(
              image: jsonDecode(responseFinal.body)['image'].toString(),
            );
            userProvider.setUserFromModel(user);
            // print(userProvider.user.bufferImage);

            try {
              func();
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  // void removePic(
  //     {required BuildContext context, required VoidCallback func}) async {
  //   try {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     var res = await http.put(
  //       Uri.parse('$uri/api/users/clear-picture'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //     );
  //
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onFailure: () {
  //           try {
  //             func();
  //           } catch (e) {}
  //         },
  //         onSuccess: () {
  //           showSnackBar(context, 'Image removed');
  //
  //           User user = userProvider.user.copyWith(
  //             bufferImage: [],
  //           );
  //           userProvider.setUserFromModel(user);
  //           // print(userProvider.user.bufferImage);
  //
  //           try {
  //             func();
  //           } catch (e) {}
  //         });
  //   } catch (e) {
  //     try {
  //       func();
  //     } catch (e) {}
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void removePic(
      {required BuildContext context, required VoidCallback func}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      var res = await http.put(
        Uri.parse('$uri2/customer/account/remove-pic'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () {
            showSnackBar(context, 'Image removed');

            User user = userProvider.user.copyWith(
              image: '',
            );
            userProvider.setUserFromModel(user);
            // print(userProvider.user.bufferImage);

            try {
              func();
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }

  // void removePicPhone(
  //     {required BuildContext context, required VoidCallback func}) async {
  //   try {
  //     final userProvider = Provider.of<UserProvider>(context, listen: false);
  //     var res = await http.put(
  //       Uri.parse('$uri/api/users/clear-picturePhone'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //     );
  //
  //     httpErrorHandle(
  //         response: res,
  //         context: context,
  //         onFailure: () {
  //           try {
  //             func();
  //           } catch (e) {}
  //         },
  //         onSuccess: () {
  //           showSnackBar(context, 'Image removed');
  //
  //           User user = userProvider.user.copyWith(
  //             bufferImage: [],
  //           );
  //           userProvider.setUserFromModel(user);
  //           // print(userProvider.user.bufferImage);
  //
  //           try {
  //             func();
  //           } catch (e) {}
  //         });
  //   } catch (e) {
  //     try {
  //       func();
  //     } catch (e) {}
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void removePicPhone(
      {required BuildContext context, required VoidCallback func}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      var res = await http.put(
        Uri.parse('$uri2/customer/account/remove-pic-phone'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onFailure: () {
            try {
              func();
            } catch (e) {}
          },
          onSuccess: () {
            showSnackBar(context, 'Image removed');

            User user = userProvider.user.copyWith(
              image: '',
            );
            userProvider.setUserFromModel(user);
            // print(userProvider.user.bufferImage);

            try {
              func();
            } catch (e) {}
          });
    } catch (e) {
      try {
        func();
      } catch (e) {}
      showSnackBar(context, e.toString());
    }
  }
}
