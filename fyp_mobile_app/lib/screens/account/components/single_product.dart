import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.03),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2, vertical: kDefaultPadding / 2),
            // width: size.width / 3,
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: size.width / 3,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              padding: EdgeInsets.only(
                  left: kDefaultPadding, right: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order#XXXX',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Pending',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.yellow),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'XYZ Workshop name',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Service name',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
