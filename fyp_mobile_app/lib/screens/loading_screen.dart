import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/screens/splash.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:fyp_mobile_app/services/service_provider_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  AuthService authService = AuthService();
  ServiceProviderService service = ServiceProviderService();
  String? _currentAddress;
  Position? _currentPosition;

  @override
  void initState() {
    try {
      authService.getUserData(context: context);
      // service.getServiceData(type: type, context: context)
      service.getFeatured(context: context);

      Future.delayed(Duration(seconds: 5), () {
        getCurrentPosition();
      });
      // getCurrentPosition();
      // authService.getUserData(context: context);
      // service.getFeatured(context: context);
      super.initState();
    } catch (e) {
      // TODO
    }
  }

  Future<bool?> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied by your side.')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    try {
      if (!hasPermission!) {
        // var status = await Permission.location.status;
        // if (status.isDenied) {
        //   openAppSettings();
        // } else if (status.isPermanentlyDenied) {
        //   openAppSettings();
        // } else if (status.isGranted) {
        //   getCurrentPosition();
        // }

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Splash();
        }));
      } else {
        await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.best)
            .then((Position position) {
          setState(() => _currentPosition = position);
          getAddressFromLatLng(_currentPosition!);
        }).catchError((e) {
          debugPrint(e);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAddressFromLatLng(Position position) async {
    try {
      await placemarkFromCoordinates(
              _currentPosition!.latitude, _currentPosition!.longitude)
          .then((List<Placemark> placemarks) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress =
              '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
        });
        print(_currentAddress?.trim());
        Provider.of<Email>(context, listen: false).setAddress(_currentAddress!);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Splash();
        }));
      }).catchError((e) {
        debugPrint(e);
      });
    } catch (e) {
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitRotatingCircle(
        color: kPrimaryColor,
        size: 50,
      ),
    );
  }
}
