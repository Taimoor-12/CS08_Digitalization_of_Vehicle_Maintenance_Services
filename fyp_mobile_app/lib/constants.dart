import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

// class MongoDatabase {
//   static connect() async {
//     var db = await Db.create(
//         'mongodb+srv://fypProject08:G0CQYaEJTVAOMEKd@cluster0.0k0oh3u.mongodb.net/test?retryWrites=true&w=majority');
//     await db.open();
//     var status = db.serverStatus();
//     print(status);
//     var collection = db.collection('customers');
//     print(await collection.find().toList());
//   }
// }

// Connect to the cluster
var coll;
void connect() async {
  var db = Db(
      'mongodb+srv://flutter_developer:flutter123@cluster0.0k0oh3u.mongodb.net/test?retryWrites=true&w=majority');

  await db.open();

// Perform database operations
  coll = db.collection('customers');
  var res = await coll.find().toList();
  print(res);
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
// colors to use in the app

const kPrimaryColor = Color(0xFF47B5FF);
const kTextColor = Color(0xFF06283D);
const kBackgroundColor = Color(0xFFDFF6FF);
// const kBackgroundColor = Colors.white;
const SECRET_KEY =
    "sk_test_51M5rPqCJvwNxuJIRjhOoYcHMhrVeeBB3R3SFfDEDX4uMUQ1qVSYBuF2Hc9uv7PKha7Ao8O2Z2xlznhwNHmKEdubd00u6SaA7LB";
String uri = 'http://192.168.110.48:4000';
// String uri2 =
//     'http://mongodb+srv://flutter_developer:flutter123@cluster0.0k0oh3u.mongodb.net/test?retryWrites=true&w=majority:8080';
String uri2 = 'http://192.168.100.9:8080';
// String uri2 = 'http://localhost:8080';
String uri4 = 'http://192.168.100.9:8030';
String uri3 = 'http://192.168.100.9:8088';
String uri5 = 'http://192.168.100.9:8020';
const double kDefaultPadding = 20.0;

List list = [
  'https://media.istockphoto.com/photos/auto-mechanic-are-checking-the-condition-of-the-car-according-to-the-picture-id1312733746?b=1&k=20&m=1312733746&s=170667a&w=0&h=3qcCPGDKiTd-cf_3Y_Dj7ZNdljF1dp8g9mBqe5tlUuQ=',
  'https://media.istockphoto.com/photos/auto-mechanic-are-checking-the-condition-of-the-car-according-to-the-picture-id1312733746?b=1&k=20&m=1312733746&s=170667a&w=0&h=3qcCPGDKiTd-cf_3Y_Dj7ZNdljF1dp8g9mBqe5tlUuQ=',
  'https://media.istockphoto.com/photos/auto-mechanic-are-checking-the-condition-of-the-car-according-to-the-picture-id1312733746?b=1&k=20&m=1312733746&s=170667a&w=0&h=3qcCPGDKiTd-cf_3Y_Dj7ZNdljF1dp8g9mBqe5tlUuQ=',
  'https://media.istockphoto.com/photos/auto-mechanic-are-checking-the-condition-of-the-car-according-to-the-picture-id1312733746?b=1&k=20&m=1312733746&s=170667a&w=0&h=3qcCPGDKiTd-cf_3Y_Dj7ZNdljF1dp8g9mBqe5tlUuQ=',
];

const List<Map<String, String>> categoryImages = [
  {
    'title': '4',
    'name': 'Car wash',
    'image': 'assets/images/carWash.png',
  },
  {
    'title': '1',
    'name': 'Mechanical work',
    'image': 'assets/images/mechanicalWork.png',
  },
  {
    'title': '2',
    'name': 'Electrical work',
    'image': 'assets/images/electricalWork.png',
  },
  {
    'title': '5',
    'name': 'Roadside assistance',
    'image': 'assets/images/roadsideAssistance.png',
  },
  {
    'title': '3',
    'name': 'Wheel alignment',
    'image': 'assets/images/wheelAlignment.png',
  },
  {
    'title': '6',
    'name': 'Detailing',
    'image': 'assets/images/detailing.png',
  },
];

const List<Map<String, String>> carouselImages = [
  {
    'title': 'Carousel1',
    'image': 'assets/carouselImages/Carousel1.jpeg',
  },
  {
    'title': 'Carousel2',
    'image': 'assets/carouselImages/Carousel2.jpeg',
  },
  {
    'title': 'Carousel3',
    'image': 'assets/carouselImages/Carousel3.jpeg',
  },
  {
    'title': 'Carousel4',
    'image': 'assets/carouselImages/Carousel4.jpeg',
  },
  {
    'title': 'Carousel5',
    'image': 'assets/carouselImages/Carousel5.jpeg',
  },
];

const List<Map<String, String>> brandImages = [
  {
    'title': 'Audi',
    'image': 'assets/images/Audi.png',
  },
  {
    'title': 'Daihatsu',
    'image': 'assets/images/daihatsu.png',
  },
  {
    'title': 'Honda',
    'image': 'assets/images/honda.png',
  },
  {
    'title': 'Hyundai',
    'image': 'assets/images/hyundai.png',
  },
  {
    'title': 'Kia',
    'image': 'assets/images/kia.png',
  },
  {
    'title': 'Suzuki',
    'image': 'assets/images/suzuki.png',
  },
  {
    'title': 'Toyota',
    'image': 'assets/images/toyota.png',
  },
];
