import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/service_provider.dart';
import 'package:fyp_mobile_app/providers/swapButtonProvider.dart';
import 'package:fyp_mobile_app/providers/swapCartButtonProvider.dart';
import 'package:fyp_mobile_app/providers/textController.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/router.dart';
import 'package:fyp_mobile_app/screens/dashboard/dashboard.dart';
import 'package:fyp_mobile_app/screens/loading_screen.dart';
import 'package:fyp_mobile_app/screens/login/login_screen.dart';
import 'package:fyp_mobile_app/screens/welcome/welcome_screen.dart';
import 'package:fyp_mobile_app/fetchScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/emailPasswordProvider.dart';
import 'providers/buttonActive.dart';
import 'package:fyp_mobile_app/screens/splash.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp_mobile_app/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MongoDatabase.connect();
  Stripe.publishableKey =
      "pk_test_51M5rPqCJvwNxuJIRUnqcio1rIgZ3zkjqL31b9a8mB4gvqLRGT496lL1kqoz9Nie5aYM42wl6US9MpUKhgJrvG5lL00gSXx8gNT";
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  // @override
  // void initState() {
  //   Future.delayed(Duration.zero).then((value) {
  //     authService.getUserData(context: context);
  //   });
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return Email();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return UserProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return SwapButtonProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return SwapCartButtonProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return SwapCartButtonProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return ServiceProviderProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FYP Mobile App',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: GoogleFonts.outfitTextTheme(
            Theme.of(context).textTheme.apply(
                  bodyColor: kTextColor,
                ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        // home: DatafromAPI(),
        // home: Builder(
        //   builder: (context) {
        //     return FutureBuilder(
        //       future: authService.getUserData(
        //         context: context,
        //       ),
        //       builder: (context, snapshot) {
        //         if (snapshot.connectionState == ConnectionState.done) {
        //           return LoadingScreen();
        //         }
        //         return const Scaffold(
        //           body: Center(
        //             child: SpinKitRotatingCircle(
        //               color: kPrimaryColor,
        //               size: 50,
        //             ),
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
        home: LoadingScreen(),
        // home: WelcomeScreen(),
      ),
    );
  }
}
