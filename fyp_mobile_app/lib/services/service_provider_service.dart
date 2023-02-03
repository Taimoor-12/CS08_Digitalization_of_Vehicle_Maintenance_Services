import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/fetchScreen.dart';
import 'package:fyp_mobile_app/models/rating_model.dart';
import 'package:fyp_mobile_app/models/service_provider_model.dart';
import 'package:fyp_mobile_app/providers/service_provider.dart';
import 'package:fyp_mobile_app/providers/swapCartButtonProvider.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:fyp_mobile_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:fyp_mobile_app/models/user_model.dart';
import '../error_handling.dart';

class ServiceProviderService {
  // Future getUserData(
  //     {required String category,
  //     required String brandName,
  //     required BuildContext context}) async {
  //   var response = await http.get(
  //     Uri.parse(
  //         '$uri/api/services/getPro?category=$category&brandName=$brandName'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //
  //   var jsonData = jsonDecode(response.body);
  //   List<ServiceProvider> serProviders = [];
  //   // List<String> imageString = [];
  //   // String image = "";
  //
  //   for (var u in jsonData) {
  //     List<dynamic> bufferDynamic = u['image']['data']['data'];
  //     List<dynamic> ratingDynamic = u['rating'];
  //     List<Rating> ratings = List<Rating>.from(
  //       ratingDynamic.map(
  //         (x) => Rating.fromMap(x),
  //       ),
  //     );
  //     List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
  //
  //     dynamic averageDynamic = u['aver'];
  //     double average = averageDynamic?.toDouble() ?? 0.0;
  //
  //     // double average = u['aver'];
  //     // print(average);
  //     // String image = base64Encode(bufferInt);
  //     // Uint8List imageInt = base64.decode(image.split('\n').join().toString());
  //     ServiceProvider spo = ServiceProvider(
  //         id: u['_id'],
  //         name: u['name'],
  //         category: u['category'],
  //         price: u['price'],
  //         brandName: u['brandName'],
  //         address: u['address'],
  //         average: average,
  //         rating: ratings,
  //         bufferImage: bufferInt);
  //
  //     // var serviceProv =
  //     //     Provider.of<ServiceProviderProvider>(context, listen: false);
  //     // serviceProv.setServiceProvider(u);
  //     // serviceProv.provider.bufferImage = bufferInt;
  //     // serviceProv.setServiceProvider(serviceProv.provider.toJson());
  //     // print(serviceProv.provider.toJson());
  //     serProviders.add(spo);
  //   }
  //   print(serProviders.length);
  //   final providerList =
  //       Provider.of<ServiceProviderProvider>(context, listen: false);
  //   providerList.assignList(serProviders);
  //   return providerList.listPro;
  //   // print(ser_providers.toString());
  //   // return ser_providers;
  // }

  Future getServiceData(
      {required String type, required BuildContext context}) async {
    var response = await http.get(
      Uri.parse(
          '$uri3/admin/car-services/findServicesByType?serviceType=$type'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var jsonData = jsonDecode(response.body);
    List<ServiceProvider> serProviders = [];
    // List<String> imageString = [];
    // String image = "";

    for (var u in jsonData) {
      // List<dynamic> bufferDynamic = u['image']['data']['data'];
      List<dynamic> ratingDynamic = u['rating'];
      List<Rating> ratings = List<Rating>.from(
        ratingDynamic.map(
          (x) => Rating.fromMap(x),
        ),
      );
      // List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();

      dynamic averageDynamic = u['aver'];
      double average = averageDynamic?.toDouble() ?? 0.0;
      dynamic dynamicID = u['serviceProviderId'];
      String providerID = dynamicID?.toString() ?? '';

      var response1 = await http.get(
        Uri.parse(
            '$uri3/admin/auth/serviceProviderInformation?_id=$providerID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      var jsonData1 = jsonDecode(response1.body);

      ServiceProvider spo = ServiceProvider(
        id: u['serviceProviderId'],
        name: u['name'],
        serviceType: u['serviceType'],
        price: u['price'],
        description: u['description'],
        timeRequired: u['timeRequired'],
        where: u['where'],
        email: jsonData1['email'],
        number: jsonData1['mobile'],
        providerName: jsonData1['firstname'] + " " + jsonData1['lastname'],
        image: jsonData1['image'],
        address: jsonData1['address'],
        average: average,
        rating: ratings,
        // bufferImage: bufferInt
      );
      print(spo.providerName);

      // var serviceProv =
      //     Provider.of<ServiceProviderProvider>(context, listen: false);
      // serviceProv.setServiceProvider(u);
      // serviceProv.provider.bufferImage = bufferInt;
      // serviceProv.setServiceProvider(serviceProv.provider.toJson());
      // print(serviceProv.provider.toJson());
      serProviders.add(spo);
    }
    print(serProviders.length);
    final providerList =
        Provider.of<ServiceProviderProvider>(context, listen: false);
    providerList.assignList(serProviders);
    return providerList.listPro;
    // print(ser_providers.toString());
    // return ser_providers;
  }

  void addToCart({
    required BuildContext context,
    required String serviceID,
    required String userID,
    required bool isSelected,
    required int index,
  }) async {
    http.Response res = await http.post(
      Uri.parse('$uri/api/services/add-to-cart'),
      body: jsonEncode({
        'id1': serviceID,
        'id2': userID,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // print(jsonDecode(res.body));
    // userProvider.user.cart = jsonDecode(res.body)['cart'];
    // userProvider.setUser(res.body);
    // userProvider.user.role = 'email';
    // userProvider.setUser(userProvider.user.toJson());
    // userProvider.user.id = jsonDecode(res.body)['_id'];
    // userProvider.setUser(userProvider.user.toJson());
    // print(userProvider.user.toJson());

    httpErrorHandle(
      response: res,
      context: context,
      onFailure: () {},
      onSuccess: () {
        // final userProvider = Provider.of<UserProvider>(context, listen: false);
        // print(jsonDecode(res.body));
        // userProvider.user.cart = jsonDecode(res.body)['cart'];
        // userProvider.setUser(res.body);
        // userProvider.user.role = 'email';
        userProvider.setUser(userProvider.user.toJson());
        // userProvider.user.id = jsonDecode(res.body)['_id'];
        // userProvider.setUser(userProvider.user.toJson());
        print(userProvider.user.toJson());
        // print(userProvider.user.cart.length);
        // try {
        //   final serviceProviderList =
        //       Provider.of<ServiceProviderProvider>(context, listen: false);
        //   serviceProviderList.listPro[index].isSelected =
        //       !serviceProviderList.listPro[index].isSelected;
        //   print('The index');
        //   print(index);
        //   print(serviceProviderList.listPro[index].isSelected);
        //   serviceProviderList.assignList(serviceProviderList.listPro);
        // } catch (e) {
        //   // TODO
        // }

        // bool value;
        // if (userProvider.user.cart.isEmpty) {
        // } else {
        //   for (int i = 0; i < userProvider.user.cart.length; i++) {
        //     print('HEY');
        //     print(serviceID);
        //     try {
        //       print(userProvider.user.cart[i]['product']['_id']);
        //       if (userProvider.user.cart[i]['product']['_id'] == serviceID) {
        //         isSelected = userProvider.user.cart[i]['addToCart'];
        //         // userProvider.user.cart[i]['addToCart'] = !isSelected;
        //         // userProvider.setUser(userProvider.user.toJson());
        //         // print(userProvider.user.cart);
        //         // User user =
        //         //     userProvider.user.copyWith(cart: userProvider.user.cart);
        //         // userProvider.setUserFromModel(user);
        //         print(userProvider.user.cart[i]['addToCart']);
        //         print(userProvider.user.cart[i]['product']['brandName']);
        //         value = userProvider.user.cart[i]['addToCart'];
        //         // Provider.of<SwapCartButtonProvider>(context, listen: false)
        //         //     .setCartButton(value);
        //
        //         break;
        //       }
        //     } catch (e) {
        //       // TODO
        //     }
        //   }
        // }
        // userProvider.setUser(userProvider.user.toJson());
        // print(userProvider.user.cart);

        // if (index == -1) {
        // } else {
        //   print(isSelected);
        //   userProvider.user.cart[index]['addToCart'] = !isSelected;
        // }
      },
    );
  }

  void deleteFromCart({
    required BuildContext context,
    required String serviceID,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    print(serviceID);
    http.Response res = await http.delete(
      Uri.parse('$uri/api/services/remove-from-cart/$serviceID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
    );
    // print(jsonDecode(res.body));
    // userProvider.user.cart = jsonDecode(res.body)['cart'];
    // userProvider.setUser(res.body);
    // userProvider.user.role = 'email';
    // userProvider.setUser(userProvider.user.toJson());
    // userProvider.user.id = jsonDecode(res.body)['_id'];
    // userProvider.setUser(userProvider.user.toJson());
    // print(userProvider.user.toJson());

    httpErrorHandle(
      response: res,
      context: context,
      onFailure: () {},
      onSuccess: () {
        // final userProvider = Provider.of<UserProvider>(context, listen: false);
        // print(jsonDecode(res.body));
        // userProvider.user.cart = jsonDecode(res.body)['cart'];
        // userProvider.setUser(res.body);
        // userProvider.user.role = 'email';
        userProvider.setUser(userProvider.user.toJson());
        // userProvider.user.id = jsonDecode(res.body)['_id'];
        // userProvider.setUser(userProvider.user.toJson());
        print(userProvider.user.toJson());
      },
    );
  }

  // void clickToCart({required String id}) async {
  //   http.Response res = await http.post(
  //     Uri.parse('$uri/api/services/click-cart'),
  //     body: jsonEncode({
  //       'id': id,
  //     }),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //
  //   // print(jsonDecode(res.body)['addToCart']);
  //   // print(jsonDecode(res.body)['brandName']);
  // }
  //
  // void clickDeleteCart({required String id}) async {
  //   http.Response res = await http.post(
  //     Uri.parse('$uri/api/services/click-delete'),
  //     body: jsonEncode({
  //       'id': id,
  //     }),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //
  //   // print(jsonDecode(res.body)['addToCart']);
  //   // print(jsonDecode(res.body)['brandName']);
  // }

  // Future getFeatured({required BuildContext context}) async {
  //   var res = await http.get(
  //     Uri.parse('$uri/api/services/featured-product'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //
  //   var jsonData = jsonDecode(res.body);
  //   List<ServiceProvider> serProviders = [];
  //   // List<String> imageString = [];
  //   // String image = "";
  //
  //   for (var u in jsonData) {
  //     List<dynamic> bufferDynamic = u['image']['data']['data'];
  //     List<dynamic> ratingDynamic = u['rating'];
  //     List<Rating> ratings = List<Rating>.from(
  //       ratingDynamic.map(
  //         (x) => Rating.fromMap(x),
  //       ),
  //     );
  //     List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
  //
  //     dynamic averageDynamic = u['aver'];
  //     double average = averageDynamic?.toDouble() ?? 0.0;
  //
  //     // double average = u['aver'];
  //     // print(average);
  //     // String image = base64Encode(bufferInt);
  //     // Uint8List imageInt = base64.decode(image.split('\n').join().toString());
  //     ServiceProvider spo = ServiceProvider(
  //         id: u['_id'],
  //         name: u['name'],
  //         category: u['category'],
  //         price: u['price'],
  //         brandName: u['brandName'],
  //         address: u['address'],
  //         average: average,
  //         rating: ratings,
  //         bufferImage: bufferInt);
  //
  //     // var serviceProv =
  //     //     Provider.of<ServiceProviderProvider>(context, listen: false);
  //     // serviceProv.setServiceProvider(u);
  //     // serviceProv.provider.bufferImage = bufferInt;
  //     // serviceProv.setServiceProvider(serviceProv.provider.toJson());
  //     // print(serviceProv.provider.toJson());
  //     serProviders.add(spo);
  //   }
  //   print(serProviders.length);
  //   // return serProviders;
  //   final providerList =
  //       Provider.of<ServiceProviderProvider>(context, listen: false);
  //   providerList.assignFeatured(serProviders);
  // }

  Future getFeatured({required BuildContext context}) async {
    var res = await http.get(
      Uri.parse('$uri2/customer/rating/featured-product'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    var jsonData = jsonDecode(res.body);
    print(jsonData);
    List<ServiceProvider> serProviders = [];
    // List<String> imageString = [];
    // String image = "";

    for (var u in jsonData) {
      List<dynamic> ratingDynamic = u['rating'];
      List<Rating> ratings = List<Rating>.from(
        ratingDynamic.map(
          (x) => Rating.fromMap(x),
        ),
      );
      // List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();

      dynamic averageDynamic = u['aver'];
      double average = averageDynamic?.toDouble() ?? 0.0;
      dynamic dynamicID = u['serviceProviderId'];
      String providerID = dynamicID?.toString() ?? '';

      var response1 = await http.get(
        Uri.parse(
            '$uri3/admin/auth/serviceProviderInformation?_id=$providerID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var jsonData1 = jsonDecode(response1.body);
      // print(jsonData1['address']);

      ServiceProvider spo = ServiceProvider(
        id: u['serviceProviderId'],
        name: u['name'],
        serviceType: u['serviceType'],
        price: u['price'],
        description: u['description'],
        timeRequired: u['timeRequired'],
        where: u['where'],
        email: jsonData1['email'],
        number: jsonData1['mobile'],
        providerName: jsonData1['firstname'] + " " + jsonData1['lastname'],
        image: jsonData1['image'],
        address: jsonData1['address'].toString(),
        average: average,
        rating: ratings,
        // bufferImage: bufferInt
      );
      serProviders.add(spo);
    }
    print("Length of featured " + serProviders.length.toString());
    // return serProviders;
    final providerList =
        Provider.of<ServiceProviderProvider>(context, listen: false);
    providerList.assignFeatured(serProviders);
    print("Length of provider featured " +
        providerList.listFeatured.length.toString());
  }

  Future getAllServiceData(
      {String? query, required BuildContext context}) async {
    var response = await http.get(
      Uri.parse('$uri3/admin/car-services/findAllServicesForCustomer/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (jsonDecode(response.body)['service'] == null) {
      return [];
    }
    var jsonData = jsonDecode(response.body)['service'];
    print("JsonData: " + jsonData.toString());
    List<ServiceProvider> serProviders = [];
    // List<String> imageString = [];
    // String image = "";

    for (var u in jsonData) {
      // List<dynamic> bufferDynamic = u['image']['data']['data'];
      List<dynamic> ratingDynamic = u['rating'];
      List<Rating> ratings = List<Rating>.from(
        ratingDynamic.map(
          (x) => Rating.fromMap(x),
        ),
      );
      // List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();

      dynamic averageDynamic = u['aver'];
      double average = averageDynamic?.toDouble() ?? 0.0;
      dynamic dynamicID = u['serviceProviderId'];
      String providerID = dynamicID?.toString() ?? '';

      var response1 = await http.get(
        Uri.parse(
            '$uri3/admin/auth/serviceProviderInformation?_id=$providerID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      var jsonData1 = jsonDecode(response1.body);

      ServiceProvider spo = ServiceProvider(
        id: u['serviceProviderId'],
        name: u['name'],
        serviceType: u['serviceType'],
        price: u['price'],
        description: u['description'],
        timeRequired: u['timeRequired'],
        where: u['where'],

        email: jsonData1['email'],
        number: jsonData1['mobile'],
        providerName: jsonData1['firstname'] + " " + jsonData1['lastname'],
        image: jsonData1['image'],
        address: jsonData1['address'],
        average: average,
        rating: ratings,
        // bufferImage: bufferInt
      );
      print("Provider Name: " + spo.providerName.toString());

      // var serviceProv =
      //     Provider.of<ServiceProviderProvider>(context, listen: false);
      // serviceProv.setServiceProvider(u);
      // serviceProv.provider.bufferImage = bufferInt;
      // serviceProv.setServiceProvider(serviceProv.provider.toJson());
      // print(serviceProv.provider.toJson());
      serProviders.add(spo);
    }
    if (query != null && (query != 'Pickup' && query != 'Doorstep')) {
      serProviders = serProviders
          .where((element) =>
              element.name.toLowerCase().contains((query.toLowerCase())) ||
              element.providerName
                  .toLowerCase()
                  .contains((query.toLowerCase())) ||
              element.price
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              element.address
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    } else if (query != null && (query == 'Pickup' || query == 'Doorstep')) {
      String whereNumber = "";
      if (query == 'Pickup') {
        whereNumber = "1";
      } else {
        whereNumber = "2";
      }
      print(whereNumber);
      serProviders = serProviders
          .where((element) => element.where == whereNumber)
          .toList();
    }
    print("Length: " + serProviders.length.toString());
    final providerList =
        Provider.of<ServiceProviderProvider>(context, listen: false);
    providerList.assignSearch(serProviders);
    return providerList.listSearch;
    // print(ser_providers.toString());
    // return ser_providers;
  }
}
