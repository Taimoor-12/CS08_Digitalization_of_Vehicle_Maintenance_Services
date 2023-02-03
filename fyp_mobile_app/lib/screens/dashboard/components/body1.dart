// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fyp_mobile_app/models/service_provider_model.dart';
// import 'package:fyp_mobile_app/providers/service_provider.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/brand_screen.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/category_populate.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/category_screen.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/single_featured.dart';
// import 'package:fyp_mobile_app/services/service_provider_service.dart';
// import 'package:provider/provider.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// import '../../../constants.dart';
// import '../../../providers/emailPasswordProvider.dart';
//
// class Body1 extends StatefulWidget {
//   const Body1({Key? key}) : super(key: key);
//
//   @override
//   State<Body1> createState() => _Body1State();
// }
//
// class _Body1State extends State<Body1> {
//   ServiceProviderService service = ServiceProviderService();
//   // void navigateToBrandPage(
//   // void navigateToCategoryPage(
//   //     BuildContext context, String category, String image) {
//   //   Navigator.pushNamed(context, CategoryScreen.routeName,
//   //       arguments: CategoryScreen(category: category, image: image));
//   // }
//
//   void navigateToBrandPage(
//       BuildContext context, String category, String image) {
//     Navigator.pushNamed(context, BrandScreen.routeName,
//         arguments: BrandScreen(category: category, image: image));
//   }
//
//   // Future<List<ServiceProvider>> serviceProviders = [];
//   //
//   // @override
//   // void initState() {
//   //   serviceProviders = service.getFeatured();
//   //   super.initState();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     List list = [
//       'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
//       'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
//       'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
//       'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
//     ];
//     final name = Provider.of<Email>(context, listen: false).fullName;
//     Size size = MediaQuery.of(context).size;
//     ScrollController _scrollController = ScrollController();
//     final featuredList =
//         Provider.of<ServiceProviderProvider>(context, listen: false);
//
//     _scrollToBottom() {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//     }
//
//     return ListView(
//       physics: ScrollPhysics(),
//       children: [
//         Stack(
//           children: [
//             Container(
//               height: size.height * 0.27,
//               width: size.width,
//               padding: EdgeInsets.only(
//                 top: kDefaultPadding,
//                 left: kDefaultPadding,
//                 right: kDefaultPadding,
//               ),
//               decoration: BoxDecoration(
//                 color: kPrimaryColor,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(36),
//                   bottomRight: Radius.circular(36),
//                 ),
//               ),
//               child: SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // IconButton(
//                     //   onPressed: () {},
//                     //   icon: Icon(
//                     //     Icons.menu_rounded,
//                     //     color: kTextColor,
//                     //     size: 30,
//                     //   ),
//                     // ),
//                     SizedBox(
//                       height: 25,
//                     ),
//                     Text(
//                       'Hi, ',
//                       textAlign: TextAlign.left,
//                       style: Theme.of(context).textTheme.headline5!.copyWith(
//                             overflow: TextOverflow.ellipsis,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'What service do\n you need?',
//                       textAlign: TextAlign.left,
//                       style: Theme.of(context).textTheme.headline5!.copyWith(
//                             overflow: TextOverflow.ellipsis,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//               top: size.height * 0.13,
//               right: size.width * 0.02,
//               child: ClipRRect(
//                 child: Image.asset(
//                   'assets/images/services.png',
//                   scale: 3,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//           ],
//         ),
//         // SizedBox(
//         //   height: 20,
//         // ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
//           child: CarouselSlider(
//             items: carouselImages.map(
//               (i) {
//                 return Builder(
//                   builder: (BuildContext context) => Image.asset(
//                     i['image']!,
//                     fit: BoxFit.contain,
//                     height: 200,
//                   ),
//                 );
//               },
//             ).toList(),
//             options: CarouselOptions(
//               viewportFraction: 1,
//               height: 200,
//               enableInfiniteScroll: true,
//               reverse: false,
//               aspectRatio: 16 / 9,
//               autoPlay: true,
//               autoPlayInterval: Duration(seconds: 5),
//               autoPlayAnimationDuration: Duration(milliseconds: 1200),
//             ),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//           width: size.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: kDefaultPadding),
//                 child: Text(
//                   'Category',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 0),
//                 child: SizedBox(
//                   height: size.height * 0.12,
//                   child: ListView.builder(
//                     itemCount: categoryImages.length,
//                     itemExtent: 85,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           // navigateToCategoryPage(
//                           //     context,
//                           //     categoryImages[index]['title']!,
//                           //     categoryImages[index]['image']!);
//
//                           navigateToBrandPage(
//                               context,
//                               categoryImages[index]['title']!,
//                               categoryImages[index]['image']!);
//                         },
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(50),
//                                 child: Image.asset(
//                                   categoryImages[index]['image']!,
//                                   fit: BoxFit.cover,
//                                   height: 50,
//                                   width: 50,
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               categoryImages[index]['title']!,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         // Padding(
//         //   padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
//         //   child: CarouselSlider(
//         //     items: carouselImages.map(
//         //       (i) {
//         //         return Builder(
//         //           builder: (BuildContext context) => Image.asset(
//         //             i['image']!,
//         //             fit: BoxFit.contain,
//         //             height: 200,
//         //           ),
//         //         );
//         //       },
//         //     ).toList(),
//         //     options: CarouselOptions(
//         //       viewportFraction: 1,
//         //       height: 200,
//         //       enableInfiniteScroll: true,
//         //       reverse: false,
//         //       autoPlay: true,
//         //       autoPlayInterval: Duration(seconds: 5),
//         //       autoPlayAnimationDuration: Duration(milliseconds: 1200),
//         //     ),
//         //   ),
//         // ),
//
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//           width: size.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: kDefaultPadding),
//                 child: Text(
//                   'Featured',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         GridView.builder(
//             padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             itemCount: featuredList.listFeatured.length,
//             physics: ScrollPhysics(),
//             shrinkWrap: true,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 1, childAspectRatio: 1.2, mainAxisExtent: 380),
//             itemBuilder: (context, index) {
//               return GestureDetector(
//                 onTap: () {
//                   // Navigator.pushNamed(
//                   //     context, ServiceProviderDetailScreen.routeName);
//                 },
//                 // child: Text('Yo'),
//                 child: CategoryPopulate(
//                   size: size,
//                   id: featuredList.listFeatured[index].id,
//                   name: featuredList.listFeatured[index].name,
//                   address: featuredList.listFeatured[index].address,
//                   price: featuredList.listFeatured[index].price,
//                   brand: featuredList.listFeatured[index].brandName,
//                   category: featuredList.listFeatured[index].category,
//                   image: featuredList.listFeatured[index].bufferImage!,
//                   average: featuredList.listFeatured[index].average!,
//                   isSelected: false,
//                   i: index,
//                   provider: featuredList.listFeatured[index],
//                   // rating: featuredList.listFeatured[index].rating,
//                 ),
//               );
//             }),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_mobile_app/models/service_provider_model.dart';
import 'package:fyp_mobile_app/providers/service_provider.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/blog_detail_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/brand_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/category_populate.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/category_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/single_featured.dart';
import 'package:fyp_mobile_app/services/blog_service.dart';
import 'package:fyp_mobile_app/services/service_provider_service.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../constants.dart';
import '../../../providers/emailPasswordProvider.dart';

class Body1 extends StatefulWidget {
  const Body1({Key? key}) : super(key: key);

  @override
  State<Body1> createState() => _Body1State();
}

class _Body1State extends State<Body1> {
  ServiceProviderService service = ServiceProviderService();
  // void navigateToBrandPage(
  void navigateToCategoryPage(
      BuildContext context, String category, String image, String name) {
    Navigator.pushNamed(context, CategoryScreen.routeName,
        arguments: CategoryScreen(
          category: category,
          image: image,
          categoryName: name,
        ));
  }

  // void navigateToBrandPage(
  //     BuildContext context, String category, String image, String name) {
  //   Navigator.pushNamed(context, BrandScreen.routeName,
  //       arguments: BrandScreen(category: category, image: image, name: name));
  // }

  List Strings = [
    'How cars can be maintained properly',
    'Detailing services that can drastically improve the looks of your vehicleidshfiusefheusifhfusiehesfuihfesiuhfiufsehfesuihfesiufeh',
    'How electric cars can replace the combustion engine'
  ];

  // Future<List<ServiceProvider>> serviceProviders = [];
  //
  // @override
  // void initState() {
  //   serviceProviders = service.getFeatured();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    List list = [
      'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
      'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
      'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
      'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
    ];
    final name = Provider.of<Email>(context, listen: false).fullName;
    Size size = MediaQuery.of(context).size;
    BlogService blogService = BlogService();
    ScrollController _scrollController = ScrollController();
    final featuredList =
        Provider.of<ServiceProviderProvider>(context, listen: false);

    _scrollToBottom() {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }

    return ListView(
      physics: ScrollPhysics(),
      children: [
        Stack(
          children: [
            Container(
              height: size.height * 0.27,
              width: size.width,
              padding: EdgeInsets.only(
                top: kDefaultPadding,
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.menu_rounded,
                    //     color: kTextColor,
                    //     size: 30,
                    //   ),
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Hi, ',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'What service do\n you need?',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.13,
              right: size.width * 0.02,
              child: ClipRRect(
                child: Image.asset(
                  'assets/images/services.png',
                  scale: 3,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 20,
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: CarouselSlider(
            items: carouselImages.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) => Image.asset(
                    i['image']!,
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 200,
              enableInfiniteScroll: true,
              reverse: false,
              aspectRatio: 16 / 9,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 1200),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: SizedBox(
                  height: size.height * 0.12,
                  child: ListView.builder(
                    itemCount: categoryImages.length,
                    itemExtent: 85,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          navigateToCategoryPage(
                            context,
                            categoryImages[index]['title']!,
                            categoryImages[index]['image']!,
                            categoryImages[index]['name']!,
                          );
                          print(categoryImages[index]['image']!);
                          // navigateToBrandPage(
                          //   context,
                          //   categoryImages[index]['title']!,
                          //   categoryImages[index]['image']!,
                          //   categoryImages[index]['name']!,
                          // );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  categoryImages[index]['image']!,
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                            Text(
                              categoryImages[index]['name']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        //   child: CarouselSlider(
        //     items: carouselImages.map(
        //       (i) {
        //         return Builder(
        //           builder: (BuildContext context) => Image.asset(
        //             i['image']!,
        //             fit: BoxFit.contain,
        //             height: 200,
        //           ),
        //         );
        //       },
        //     ).toList(),
        //     options: CarouselOptions(
        //       viewportFraction: 1,
        //       height: 200,
        //       enableInfiniteScroll: true,
        //       reverse: false,
        //       autoPlay: true,
        //       autoPlayInterval: Duration(seconds: 5),
        //       autoPlayAnimationDuration: Duration(milliseconds: 1200),
        //     ),
        //   ),
        // ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Text(
                  'Featured',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ],
          ),
        ),
        // GridView.builder(
        //     padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        //     itemCount: featuredList.listFeatured.length,
        //     physics: ScrollPhysics(),
        //     shrinkWrap: true,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 1, childAspectRatio: 1.2, mainAxisExtent: 380),
        //     itemBuilder: (context, index) {
        //       return GestureDetector(
        //         onTap: () {
        //           // Navigator.pushNamed(
        //           //     context, ServiceProviderDetailScreen.routeName);
        //         },
        //         // child: Text('Yo'),
        //         child: CategoryPopulate(
        //           size: size,
        //           id: featuredList.listFeatured[index].id,
        //           name: featuredList.listFeatured[index].name,
        //           address: featuredList.listFeatured[index].address,
        //           price: featuredList.listFeatured[index].price,
        //           brand: featuredList.listFeatured[index].brandName,
        //           category: featuredList.listFeatured[index].category,
        //           image: featuredList.listFeatured[index].bufferImage!,
        //           average: featuredList.listFeatured[index].average!,
        //           isSelected: false,
        //           i: index,
        //           provider: featuredList.listFeatured[index],
        //           // rating: featuredList.listFeatured[index].rating,
        //         ),
        //       );
        //     }),
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          itemCount: featuredList.listFeatured.isEmpty
              ? 1
              : featuredList.listFeatured.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.2,
              mainAxisExtent: featuredList.listFeatured.isEmpty ? 50 : 380),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigator.pushNamed(
                //     context, ServiceProviderDetailScreen.routeName);
              },
              // child: Text('Yo'),
              child: featuredList.listFeatured.length == 0
                  ? Center(
                      child: Text(
                        'No featured services',
                        style: TextStyle(
                          fontSize: 18,
                          color: kTextColor.withOpacity(0.4),
                        ),
                      ),
                    )
                  : CategoryPopulate(
                      size: size,
                      id: featuredList.listFeatured[index].id,
                      name: featuredList.listFeatured[index].name,
                      serviceType: featuredList.listFeatured[index].serviceType,
                      price: featuredList.listFeatured[index].price,
                      timeRequired:
                          featuredList.listFeatured[index].timeRequired,
                      description: featuredList.listFeatured[index].description,
                      providerName:
                          featuredList.listFeatured[index].providerName,
                      where: featuredList.listFeatured[index].where,
                      address: featuredList.listFeatured[index].address,
                      image: featuredList.listFeatured[index].image,
                      categoryName: featuredList
                                  .listFeatured[index].serviceType ==
                              "1"
                          ? "Mechanical work"
                          : featuredList.listFeatured[index].serviceType == "2"
                              ? "Electrical work"
                              : featuredList.listFeatured[index].serviceType ==
                                      "3"
                                  ? "Wheel alignment"
                                  : featuredList.listFeatured[index]
                                              .serviceType ==
                                          "4"
                                      ? "Car wash"
                                      : featuredList.listFeatured[index]
                                                  .serviceType ==
                                              "5"
                                          ? "Roadside assistance"
                                          : "Detailing",
                      email: featuredList.listFeatured[index].email,
                      number: featuredList.listFeatured[index].number,
                      // category: snapshot.data[index].category,
                      // image: snapshot.data[index].bufferImage,
                      average: featuredList.listFeatured[index].average!,
                      rating: featuredList.listFeatured[index].rating!,
                      isSelected: false,
                      i: index,
                      provider: featuredList.listFeatured[index],
                      // rating: featuredList.listFeatured[index].rating,
                    ),
            );
          },
        ),

        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        //   width: size.width,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: kDefaultPadding),
        //         child: Text(
        //           'Blogs',
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        //   width: size.width,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: kDefaultPadding * 2),
        //         child: Text(
        //           'Blogs',
        //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
        //         child: SizedBox(
        //           height: size.height * 0.3,
        //           child: ListView.builder(
        //             itemCount: 5,
        //             physics: ClampingScrollPhysics(),
        //             shrinkWrap: true,
        //             scrollDirection: Axis.horizontal,
        //             itemBuilder: (context, index) {
        //               return GestureDetector(
        //                 onTap: () {
        //                   // navigateToCategoryPage(
        //                   //     context,
        //                   //     categoryImages[index]['title']!,
        //                   //     categoryImages[index]['image']!);
        //                   // print(categoryImages[index]['image']!);
        //                   // navigateToBrandPage(
        //                   //   context,
        //                   //   categoryImages[index]['title']!,
        //                   //   categoryImages[index]['image']!,
        //                   //   categoryImages[index]['name']!,
        //                   // );
        //                 },
        //                 child: Column(
        //                   children: [
        //                     Container(
        //                       height: size.height * 0.3,
        //                       width: size.width * 0.12,
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // Padding(
        //   padding: const EdgeInsets.only(
        //       left: kDefaultPadding, bottom: kDefaultPadding),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       Text(
        //         'Blogs',
        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        //       ),
        //       SizedBox(
        //         height: 20,
        //       ),
        //       Container(
        //         constraints: BoxConstraints(
        //           maxHeight: size.height * 0.5,
        //         ),
        //         child: ListView.builder(
        //           // physics: ClampingScrollPhysics(),
        //           shrinkWrap: true,
        //           scrollDirection: Axis.horizontal,
        //           itemCount: 5,
        //           itemBuilder: (BuildContext context, int index) {
        //             return Container(
        //               width: size.width * 0.8,
        //               margin: EdgeInsets.only(
        //                   right: kDefaultPadding / 4,
        //                   left: kDefaultPadding / 1.5),
        //               decoration: BoxDecoration(
        //                 color: Colors.white,
        //                 borderRadius: BorderRadius.circular(30),
        //               ),
        //               child: Column(
        //                 mainAxisSize: MainAxisSize.min,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Container(
        //                     margin: EdgeInsets.only(
        //                         left: kDefaultPadding / 1.5,
        //                         right: kDefaultPadding / 1.5,
        //                         top: kDefaultPadding / 2),
        //                     child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(30),
        //                       // child: Image.memory(
        //                       //   Uint8List.fromList(widget.image),
        //                       //   fit: BoxFit.cover,
        //                       //   width: widget.size.width,
        //                       //   height: 150,
        //                       // ),
        //                       child: Image.network(
        //                         'https://images.unsplash.com/photo-1542435503-956c469947f6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
        //                         fit: BoxFit.cover,
        //                         width: size.width * 0.75,
        //                         height: size.height * 0.28,
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Container(
        //                     // constraints: BoxConstraints(
        //                     //   maxWidth: size.width * 0.75,
        //                     // ),
        //                     padding: EdgeInsets.symmetric(
        //                         horizontal: kDefaultPadding / 1.5),
        //                     child: FittedBox(
        //                       fit: BoxFit.cover,
        //                       child: Text(
        //                         'The art of repairing cars and washing them',
        //                         style: Theme.of(context)
        //                             .textTheme
        //                             .headline6!
        //                             .copyWith(
        //                               fontWeight: FontWeight.bold,
        //                             ),
        //                       ),
        //                     ),
        //                   ),
        //                   Spacer(),
        //                   Container(
        //                     padding: EdgeInsets.symmetric(
        //                         horizontal: kDefaultPadding / 1.5),
        //                     child: Row(
        //                       mainAxisSize: MainAxisSize.min,
        //                       children: [
        //                         ProfilePicture(
        //                           name: 'Ameer Hamza',
        //                           radius: 15,
        //                           fontsize: size.width / 30,
        //                         ),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         Text(
        //                           'Ameer Hamza',
        //                           style: TextStyle(
        //                             fontSize: 16,
        //                             fontWeight: FontWeight.w700,
        //                             color: kTextColor.withOpacity(0.4),
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                 ],
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Text(
                  'Blogs',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),

        FutureBuilder(
          future: blogService.getBlogs(context: context),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
              return Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Center(
                  child: SpinKitRotatingCircle(
                    color: kPrimaryColor,
                    size: 30,
                  ),
                ),
              );
            } else {
              if (snapshot.data.length == 0) {
                return Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Center(
                    child: Text(
                      'No blogs',
                      style: TextStyle(
                          fontSize: 22, color: kTextColor.withOpacity(0.4)),
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < snapshot.data.length; i++)
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            BlogDetail.routeName,
                            arguments: BlogDetail(
                                image: snapshot.data[i].image,
                                title: snapshot.data[i].title,
                                date: snapshot.data[i].date,
                                author: snapshot.data[i].author,
                                body: snapshot.data[i].body),
                          );
                        },
                        child: Container(
                          width: size.width * 0.8,
                          margin: EdgeInsets.symmetric(
                              horizontal: kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: kDefaultPadding / 2,
                                    left: kDefaultPadding / 1.5,
                                    right: kDefaultPadding / 1.5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  // child: Image.memory(
                                  //   Uint8List.fromList(widget.image),
                                  //   fit: BoxFit.cover,
                                  //   width: widget.size.width,
                                  //   height: 150,
                                  // ),
                                  child: Image.network(
                                    snapshot.data[i].image,
                                    // 'https://images.unsplash.com/photo-1542435503-956c469947f6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
                                    fit: BoxFit.cover,
                                    width: size.width * 0.75,
                                    height: size.height * 0.28,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                // constraints: BoxConstraints(
                                //   maxWidth: size.width * 0.75,
                                // ),
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                child: Text(
                                  // 'The art of repairing cars and washing them',
                                  // Strings[i],
                                  snapshot.data[i].title,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ProfilePicture(
                                      name: snapshot.data[i].author,
                                      radius: 15,
                                      fontsize: size.width / 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      snapshot.data[i].author,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: kTextColor.withOpacity(0.4),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }
          },
        ),

        // SingleChildScrollView(
        //     scrollDirection: Axis.horizontal,
        //     child: Row(
        //       children: [
        //         for (int i = 0; i < 3; i++)
        //           GestureDetector(
        //             onTap: () {
        //               Navigator.pushNamed(context, BlogDetail.routeName);
        //             },
        //             child: Container(
        //               width: size.width * 0.8,
        //               margin:
        //                   EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        //               decoration: BoxDecoration(
        //                 color: Colors.white.withOpacity(0.7),
        //                 borderRadius: BorderRadius.circular(36),
        //               ),
        //               child: Column(
        //                 children: [
        //                   Padding(
        //                     padding: EdgeInsets.only(
        //                         top: kDefaultPadding / 2,
        //                         left: kDefaultPadding / 1.5,
        //                         right: kDefaultPadding / 1.5),
        //                     child: ClipRRect(
        //                       borderRadius: BorderRadius.circular(30),
        //                       // child: Image.memory(
        //                       //   Uint8List.fromList(widget.image),
        //                       //   fit: BoxFit.cover,
        //                       //   width: widget.size.width,
        //                       //   height: 150,
        //                       // ),
        //                       child: Image.network(
        //                         'https://images.unsplash.com/photo-1542435503-956c469947f6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
        //                         fit: BoxFit.cover,
        //                         width: size.width * 0.75,
        //                         height: size.height * 0.28,
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Container(
        //                     // constraints: BoxConstraints(
        //                     //   maxWidth: size.width * 0.75,
        //                     // ),
        //                     alignment: Alignment.centerLeft,
        //                     padding:
        //                         EdgeInsets.symmetric(horizontal: kDefaultPadding),
        //                     child: Text(
        //                       // 'The art of repairing cars and washing them',
        //                       Strings[i],
        //                       textAlign: TextAlign.left,
        //                       style:
        //                           Theme.of(context).textTheme.headline6!.copyWith(
        //                                 fontWeight: FontWeight.bold,
        //                               ),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Container(
        //                     padding:
        //                         EdgeInsets.symmetric(horizontal: kDefaultPadding),
        //                     child: Row(
        //                       // mainAxisSize: MainAxisSize.min,
        //                       // mainAxisAlignment: MainAxisAlignment.start,
        //                       children: [
        //                         ProfilePicture(
        //                           name: 'Ameer Hamza',
        //                           radius: 15,
        //                           fontsize: size.width / 30,
        //                         ),
        //                         SizedBox(
        //                           width: 10,
        //                         ),
        //                         Text(
        //                           'Ameer Hamza',
        //                           style: TextStyle(
        //                             fontSize: 16,
        //                             fontWeight: FontWeight.w700,
        //                             color: kTextColor.withOpacity(0.4),
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //       ],
        //     ),
        //   ),
      ],
    );
  }
}

// featuredList.listFeatured[index].id
