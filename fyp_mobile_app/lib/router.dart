import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_email.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_name.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_password.dart';
import 'package:fyp_mobile_app/screens/account/components/personal_details.dart';
import 'package:fyp_mobile_app/screens/cart/components/addressHandling.dart';
import 'package:fyp_mobile_app/screens/cart/components/addressHandlingManual.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/addressHandling.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/addressHandlingManual.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/brand_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/detail_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/ratingScreen.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/service_details.dart';
import 'package:fyp_mobile_app/screens/login/components/check_email_screen.dart';
import 'package:fyp_mobile_app/screens/login/components/reset_password_page.dart';
import 'package:fyp_mobile_app/screens/orders/components/orders_details.dart';
import 'package:fyp_mobile_app/screens/orders/orders.dart';
import 'package:fyp_mobile_app/screens/components/bottom_bar.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/category_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/dashboard.dart';
import 'package:fyp_mobile_app/screens/login/login_screen.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_email_otp.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_otp.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_phone_otp.dart';
import 'package:fyp_mobile_app/screens/registration/registration_screen.dart';
import 'package:fyp_mobile_app/screens/login/components/forget_password_screen.dart';

import 'screens/dashboard/components/blog_detail_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case RegistrationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegistrationScreen(),
      );
    case Dashboard.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Dashboard(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case Orders.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Orders(),
      );

    case ForgetPassword.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgetPassword(),
      );
    case PasswordResetPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PasswordResetPage(),
      );
    case PersonalDetails.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PersonalDetails(),
      );
    case EditName.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditName(),
      );
    case EditEmail.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditEmail(),
      );
    case EditPassword.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditPassword(),
      );
    case VerifyOTP.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VerifyOTP(),
      );
    case VerifyPhoneOTP.routeName:
      final arg = routeSettings.arguments as VerifyPhoneOTP;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => VerifyPhoneOTP(phone: arg.phone),
      );
    case VerifyEmailOTPScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VerifyEmailOTPScreen(),
      );

    case CheckEmailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CheckEmailScreen(),
      );

    case ServiceProviderDetailScreen.routeName:
      final arg = routeSettings.arguments as ServiceProviderDetailScreen;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ServiceProviderDetailScreen(
          name: arg.name,
          serviceType: arg.serviceType,
          description: arg.description,
          timeRequired: arg.timeRequired,
          providerName: arg.providerName,
          price: arg.price,
          categoryName: arg.categoryName,
          where: arg.where,
          image: arg.image,
          email: arg.email,
          number: arg.number,
          id: arg.id,
          address: arg.address,
        ),
      );
    case ServiceDetails.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ServiceDetails(),
      );
    // case AddressPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const AddressPage(),
    //   );
    case AddressPage.routeName:
      final arg = routeSettings.arguments as AddressPage;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressPage(
          price: arg.price,
          id: arg.id,
          name: arg.name,
        ),
      );
    // case AddressPageManual.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const AddressPageManual(),
    //   );
    case AddressPageManual.routeName:
      final arg = routeSettings.arguments as AddressPageManual;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressPageManual(
          price: arg.price,
          id: arg.id,
          name: arg.name,
        ),
      );
    case CategoryScreen.routeName:
      final arg = routeSettings.arguments as CategoryScreen;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryScreen(
                category: arg.category,
                categoryName: arg.categoryName,
                image: arg.image,
                // brandName: arg.brandName,
              ));
    // case OrderDetails.routeName:
    //   final arg = routeSettings.arguments as OrderDetails;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => OrderDetails(
    //           provider: arg.provider,
    //           orderNo: arg.orderNo,
    //           price: arg.price,
    //           date: arg.date,
    //           status: arg.status,
    //           address: arg.address));

    case OrderDetails.routeName:
      final arg = routeSettings.arguments as OrderDetails;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetails(
                id: arg.id,
                status: arg.status,
                requestedOn: arg.requestedOn,
                totalPrice: arg.totalPrice,
                customerId: arg.customerId,
                firstName: arg.firstName,
                carName: arg.carName,
                carNumber: arg.carNumber,
                customerAddress: arg.customerAddress,
                serviceName: arg.serviceName,
                serviceProviderId: arg.serviceProviderId,
                mechanicEmail: arg.mechanicEmail,
                mechanicName: arg.mechanicName,
                mechanicPhone: arg.mechanicPhone,
              ));
    // case BrandScreen.routeName:
    //   final arg = routeSettings.arguments as BrandScreen;
    //   return MaterialPageRoute(
    //       settings: routeSettings,
    //       builder: (_) => BrandScreen(
    //             category: arg.category,
    //             name: arg.name,
    //             image: arg.image,
    //           ));

    case BlogDetail.routeName:
      final arg = routeSettings.arguments as BlogDetail;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => BlogDetail(
                image: arg.image,
                title: arg.title,
                author: arg.author,
                date: arg.date,
                body: arg.body,
              ));

    case RatingScreen.routeName:
      final arg = routeSettings.arguments as RatingScreen;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => RatingScreen(
                providerName: arg.providerName,
                image: arg.image,
                name: arg.name,
                categoryName: arg.categoryName,
                id: arg.id,
                provider: arg.provider,
              ));

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
