import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:http/http.dart' as http;

class DatafromAPI extends StatefulWidget {
  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<DatafromAPI> {
  Future getUserData() async {
    var response =
        await http.get(Uri.parse('http://192.168.100.9:4000/api/services/'));
    var jsonData = jsonDecode(response.body);
    List<User1> users = [];
    // List<String> imageString = [];
    // String image = "";

    for (var u in jsonData) {
      List<dynamic> bufferDynamic = u['image']['data']['data'];
      List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
      String image = base64Encode(bufferInt);
      Uint8List imageInt = base64.decode(image.split('\n').join().toString());
      // for (var i in bufferInt) {
      //   String temp = i.toRadixString(2) + image;
      //   image = temp;
      // }
      // print(image);
      // imageString.add(image);
      // base64.normalize(image);
      User1 user = User1(u["firstname"], imageInt);
      users.add(user);
    }
    print(users.toString());
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Matches Data"),
      ),
      body: Container(
        child: Card(
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(snapshot.data[i].firstname),
//                        subtitle: Text(snapshot.data[i].lastname),
                        trailing: Image.memory(
                          snapshot.data[i].bufferImage,
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ),
    );
  }
}

class User1 {
  final String firstname;
  Uint8List bufferImage;
  User1(this.firstname, this.bufferImage);

  @override
  String toString() {
    return '{name: ${firstname}, image: ${bufferImage}}';
  }
}
