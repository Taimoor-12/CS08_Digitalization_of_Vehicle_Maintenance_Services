import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/service_provider.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/category_populate.dart';
import 'package:fyp_mobile_app/services/service_provider_service.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

String text = "";

ServiceProviderService service = ServiceProviderService();

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: kTextColor,
        title: Padding(
          padding: const EdgeInsets.only(left: kDefaultPadding * 2),
          child: Text('Search'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: kDefaultPadding),
        child: FutureBuilder(
          future: service.getAllServiceData(
            context: context,
          ),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return const Scaffold(
                body: Center(
                  child: SpinKitRotatingCircle(
                    color: kPrimaryColor,
                    size: 50,
                  ),
                ),
              );
            } else {
              print("Snapshot Length: " + snapshot.data.length.toString());
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text(
                    'No services',
                    style: TextStyle(
                        fontSize: 22, color: kTextColor.withOpacity(0.4)),
                  ),
                );
              }

              return GridView.builder(
                  padding: EdgeInsets.only(
                      left: kDefaultPadding / 1.6,
                      right: kDefaultPadding / 1.6),
                  itemCount: snapshot.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    // childAspectRatio: 1.4,
                    // mainAxisExtent: 380,
                  ),
                  itemBuilder: (context, index) {
                    var serviceType = snapshot.data[index].serviceType;
                    print("Service Type: " + serviceType);
                    return GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(
                        //     context, ServiceProviderDetailScreen.routeName);
                      },
                      child: CategoryPopulate(
                        size: size,
                        id: snapshot.data[index].id,
                        name: snapshot.data[index].name,
                        serviceType: snapshot.data[index].serviceType,
                        price: snapshot.data[index].price,
                        timeRequired: snapshot.data[index].timeRequired,
                        description: snapshot.data[index].description,
                        providerName: snapshot.data[index].providerName,
                        image: snapshot.data[index].image,
                        address: snapshot.data[index].address,
                        where: snapshot.data[index].where,
                        categoryName: serviceType == "1"
                            ? "Mechanical Services"
                            : serviceType == "2"
                                ? "Electrical Services"
                                : serviceType == "3"
                                    ? "Wheel Alignment"
                                    : serviceType == "4"
                                        ? "Car Wash"
                                        : serviceType == "5"
                                            ? "Roadside Assistance"
                                            : "Detailing",

                        email: snapshot.data[index].email,
                        number: snapshot.data[index].number,
                        // category: snapshot.data[index].category,
                        // image: snapshot.data[index].bufferImage,
                        average: snapshot.data[index].average,
                        rating: snapshot.data[index].rating,
                        isSelected: false,
                        i: index,
                        provider: snapshot.data[index],
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Doorstep',
    'Pickup and drop',
    '3000',
    'Honda',
    'Toyota'
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      // IconButton(
      //     onPressed: () {
      //       close(context, query);
      //     },
      //     icon: Icon(Icons.search_outlined))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement buildResults
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding),
      child: FutureBuilder(
        future: service.getAllServiceData(
          context: context,
          query: query,
        ),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return const Scaffold(
              body: Center(
                child: SpinKitRotatingCircle(
                  color: kPrimaryColor,
                  size: 50,
                ),
              ),
            );
          } else {
            if (snapshot.data.length == 0) {
              return Center(
                child: Text(
                  'No services',
                  style: TextStyle(
                      fontSize: 22, color: kTextColor.withOpacity(0.4)),
                ),
              );
            }

            return GridView.builder(
                padding: EdgeInsets.only(
                    left: kDefaultPadding / 1.6, right: kDefaultPadding / 1.6),
                itemCount: snapshot.data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  // childAspectRatio: 1.4,
                  // mainAxisExtent: 380,
                ),
                itemBuilder: (context, index) {
                  var serviceType = snapshot.data[index].serviceType;
                  print("Service Type: " + serviceType);
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(
                      //     context, ServiceProviderDetailScreen.routeName);
                    },
                    child: CategoryPopulate(
                      size: size,
                      id: snapshot.data[index].id,
                      name: snapshot.data[index].name,
                      serviceType: snapshot.data[index].serviceType,
                      price: snapshot.data[index].price,
                      image: snapshot.data[index].image,
                      timeRequired: snapshot.data[index].timeRequired,
                      description: snapshot.data[index].description,
                      address: snapshot.data[index].address,
                      providerName: snapshot.data[index].providerName,
                      where: snapshot.data[index].where,
                      categoryName: serviceType == "1"
                          ? "Mechanical Services"
                          : serviceType == "2"
                              ? "Electrical Services"
                              : serviceType == "3"
                                  ? "Wheel Alignment"
                                  : serviceType == "4"
                                      ? "Car Wash"
                                      : serviceType == "5"
                                          ? "Roadside Assistance"
                                          : "Detailing",

                      email: snapshot.data[index].email,
                      number: snapshot.data[index].number,
                      // category: snapshot.data[index].category,
                      // image: snapshot.data[index].bufferImage,
                      average: snapshot.data[index].average,
                      rating: snapshot.data[index].rating,
                      isSelected: false,
                      i: index,
                      provider: snapshot.data[index],
                    ),
                  );
                });
          }
        },
      ),
    );

    // List<String> matchQuery = [];
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    // return ListView.builder(
    //     itemCount: matchQuery.length,
    //     itemBuilder: (context, index) {
    //       var result = matchQuery[index];
    //       return GestureDetector(
    //         onTap: () {
    //           print('WHAT');
    //           close(context, null);
    //         },
    //         child: ListTile(
    //           title: Text(result),
    //         ),
    //       );
    //     });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  query = "Pickup";
                },
                child: Container(
                  height: 40,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: kPrimaryColor.withOpacity(0.95)),
                  child: Center(
                    child: Text(
                      'Pickup',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  query = "Doorstep";
                },
                child: Container(
                  height: 40,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(
                              2.0, 2.0), // shadow direction: bottom right
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: kPrimaryColor.withOpacity(0.95)),
                  child: Center(
                    child: Text(
                      'Doorstep',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // // TODO: implement buildSuggestions
    // List<String> matchQuery = [];
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    // return ListView.builder(
    //     itemCount: matchQuery.length,
    //     itemBuilder: (context, index) {
    //       var result = matchQuery[index];
    //       return GestureDetector(
    //         onTap: () {
    //           print('Hey');
    //           close(context, null);
    //         },
    //         child: ListTile(
    //           title: Text(result),
    //         ),
    //       );
    //     });
  }
}
