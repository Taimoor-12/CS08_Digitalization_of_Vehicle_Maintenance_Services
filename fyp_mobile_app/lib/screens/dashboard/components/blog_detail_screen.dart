import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:intl/intl.dart';

class BlogDetail extends StatefulWidget {
  static const String routeName = '/blog-details';
  const BlogDetail(
      {Key? key,
      required this.image,
      required this.title,
      required this.author,
      required this.date,
      required this.body})
      : super(key: key);

  final String image;
  final String title;
  final String author;
  final String date;
  final String body;

  @override
  State<BlogDetail> createState() => _BlogDetailState();
}

class _BlogDetailState extends State<BlogDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: kTextColor,
        backgroundColor: kBackgroundColor,
        title: Text('Blog information'),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // margin: EdgeInsets.only(right: kDefaultPadding),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(right: kDefaultPadding * 1.5),
                height: size.height * 0.4,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(10, 10),
                      blurRadius: 100,
                      color: kPrimaryColor.withOpacity(0.29),
                    )
                  ],
                  image: DecorationImage(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.image
                        // "https://images.unsplash.com/photo-1542435503-956c469947f6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80"
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                alignment: Alignment.centerLeft,
                child: Text(
                  // 'The art of repairing cars and washing them',
                  // 'The art through which your car can blaze',
                  // 'Title of the article that can be fairly long :)',
                  // 'How cars can be maintained properly',
                  widget.title,
                  // 'Title of the article :)',
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontWeight: FontWeight.bold, color: kTextColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProfilePicture(
                      name: widget.author,
                      radius: 17,
                      fontsize: size.width / 27,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        // 'Taimoor Ali, 3 January 2023',
                        '${widget.author}, ${DateFormat().format(DateTime.parse(widget.date))}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: kTextColor.withOpacity(0.4),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                // height: size.height * 0.4,
                width: size.width * 0.95,
                // margin: EdgeInsets.only(left: kDefaultPadding / 6),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: kTextColor.withOpacity(0.4),
                  // color: Colors.amberAccent.withOpacity(0.5),
                  // color: kPrimaryColor.withOpacity(0.4),
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     offset: Offset(10, 10),
                  //     blurRadius: 100,
                  //     color: kPrimaryColor.withOpacity(0.29),
                  //   )
                  // ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    widget.body,
                    // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In tincidunt hendrerit sapien, eu gravida odio viverra id. Duis ornare lorem sed velit tincidunt, eu maximus mauris suscipit. Aliquam et nisi nec neque laoreet cursus. Quisque scelerisque neque sem, eu tincidunt dui pharetra in. Pellentesque tincidunt tellus sem, at venenatis ante tempus ac. Nulla consequat libero ut sem elementum, quis accumsan mi condimentum. Sed luctus a metus et vehicula. Suspendisse mi orci, congue a placerat ullamcorper, posuere non tortor.'
                    // 'Phasellus viverra metus vitae turpis bibendum, et tincidunt urna laoreet. Vivamus fringilla tortor nibh, at eleifend neque mattis a. Quisque bibendum massa lectus, id aliquam metus efficitur ut. Donec facilisis dignissim nisl non porttitor. Praesent pharetra finibus felis, in vehicula nunc. Integer lacinia quam id libero suscipit, a eleifend augue eleifend. Praesent dignissim volutpat enim, eu hendrerit augue. Mauris laoreet aliquet ex, a ullamcorper odio efficitur nec. Vivamus cursus lacinia sagittis.  ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: kTextColor.withOpacity(0.6)),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
