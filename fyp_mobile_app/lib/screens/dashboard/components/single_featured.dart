import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';

class SingleFeatured extends StatelessWidget {
  const SingleFeatured({
    Key? key,
    required this.size,
    required this.image,
  }) : super(key: key);

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: kDefaultPadding / 10, right: 0, bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.03),
      ),
      child: Row(
        children: [
          Container(
            // width: size.width / 3,
            height: 120,
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
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/yellowStar.png',
                        height: 12,
                        width: 12,
                      ),
                      Text(
                        '4.1',
                        style: TextStyle(fontWeight: FontWeight.w500),
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
                    'XYZ Workshop address',
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
