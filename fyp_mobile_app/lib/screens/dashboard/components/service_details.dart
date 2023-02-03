import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';

class ServiceDetails extends StatefulWidget {
  static const String routeName = '/service-details';
  const ServiceDetails({Key? key}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
                top: size.height * 0.32),
            //padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: kBackgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Car wash',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'XYZ workshop name',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Container(
                  width: size.width,
                  height: 10,
                  color: kPrimaryColor.withOpacity(0.05),
                ),
                // ListView.builder(
                //   itemCount: 5,
                //   itemBuilder: (context, index) {
                //     return OrderTile(size: size, status: list[index]);
                //   },
                // ),

                Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: 5,
                //     itemExtent: 120,
                //     itemBuilder: (context, index) {
                //       return ServiceTile(size: size);
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.3,
            width: size.width,
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      MediaQuery.of(context).size.width, 20.0)),
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1575844611398-2a68400b437c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 15,
            child: CircleAvatar(
              backgroundColor: kBackgroundColor,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
