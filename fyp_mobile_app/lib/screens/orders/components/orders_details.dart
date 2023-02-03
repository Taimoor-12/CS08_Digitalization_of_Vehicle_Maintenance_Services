// import 'package:flutter/material.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:fyp_mobile_app/models/service_provider_model.dart';
// import 'package:intl/intl.dart';
//
// class OrderDetails extends StatefulWidget {
//   static const String routeName = '/order-details';
//   const OrderDetails(
//       {Key? key,
//       required this.provider,
//       required this.status,
//       required this.date,
//       required this.price,
//       required this.orderNo,
//       required this.address})
//       : super(key: key);
//
//   final List<ServiceProvider> provider;
//   final int status;
//   final int date;
//   final double price;
//   final String orderNo;
//   final String address;
//
//   @override
//   State<OrderDetails> createState() => _OrderDetailsState();
// }
//
// class _OrderDetailsState extends State<OrderDetails> {
//   int currentStep = 0;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     currentStep = widget.status;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(size.height * 0.1),
//         child: AppBar(
//           foregroundColor: kTextColor,
//           title: Text(
//             'Order details',
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//           ),
//           backgroundColor: kPrimaryColor,
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               // size: 12,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       body: ListView(
//         children: [
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             padding: EdgeInsets.only(top: kDefaultPadding),
//             child: Row(
//               children: [
//                 Text(
//                   '#${widget.orderNo}',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   'PKR ${widget.price.toInt().toString()}',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w800,
//                     color: kPrimaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.address,
//                     style: TextStyle(
//                       fontSize: 16,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   widget.status == 0
//                       ? 'Pending'
//                       : widget.status == 1
//                           ? 'Processing'
//                           : 'Completed',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: widget.status == 0
//                         ? Colors.amber
//                         : widget.status == 1
//                             ? Colors.black45
//                             : Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: Divider(
//               thickness: 2,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: ListView.builder(
//                 itemCount: widget.provider.length,
//                 shrinkWrap: true,
//                 physics: ScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   return Container(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               '1x',
//                               style: TextStyle(fontWeight: FontWeight.w400),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Expanded(
//                               child: Text(
//                                 '${widget.provider[index].name} - ${widget.provider[index].category}',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w700,
//                                     overflow: TextOverflow.ellipsis),
//                               ),
//                             ),
//                             Text(
//                               'PKR ${widget.provider[index].price}',
//                               style: TextStyle(fontWeight: FontWeight.w700),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               'Brand: ',
//                               style: TextStyle(
//                                   fontSize: 13,
//                                   color: kTextColor.withOpacity(0.4)),
//                             ),
//                             Text(
//                               widget.provider[index].brandName,
//                               style: TextStyle(
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 40,
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: Text(
//               'Ordered @ ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.date))}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: Divider(
//               thickness: 2,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: Text(
//               'Tracking',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//             child: Stepper(
//               physics: ScrollPhysics(),
//               currentStep: currentStep,
//               controlsBuilder: (context, details) {
//                 return SizedBox();
//               },
//               steps: [
//                 Step(
//                   title: Text('Pending'),
//                   content: Text('Service yet to be performed..'),
//                   isActive: currentStep >= 0,
//                   state:
//                       currentStep >= 0 ? StepState.complete : StepState.indexed,
//                 ),
//                 Step(
//                   title: Text('Processing'),
//                   content: Text('Your order is being processed..'),
//                   isActive: currentStep >= 1,
//                   state:
//                       currentStep >= 1 ? StepState.complete : StepState.indexed,
//                 ),
//                 Step(
//                   title: Text('Completed'),
//                   content: Text('Service offered successfully..'),
//                   isActive: currentStep >= 2,
//                   state:
//                       currentStep >= 2 ? StepState.complete : StepState.indexed,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Container(
// // width: size.width,
// // padding: EdgeInsets.only(top: kDefaultPadding),
// // margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
// // child: Column(
// // children: [
// // Row(
// // children: [
// // Text(
// // '#${widget.orderNo}',
// // style: TextStyle(
// // fontSize: 22,
// // fontWeight: FontWeight.w700,
// // ),
// // ),
// // Spacer(),
// // Text(
// // 'PKR ${widget.price.toInt().toString()}',
// // style: TextStyle(
// // fontSize: 22,
// // fontWeight: FontWeight.w800,
// // color: kPrimaryColor,
// // ),
// // ),
// // ],
// // ),
// // SizedBox(
// // height: 10,
// // ),
// // Row(
// // children: [
// // Expanded(
// // child: Text(
// // widget.address,
// // style: TextStyle(
// // fontSize: 16,
// // overflow: TextOverflow.ellipsis,
// // ),
// // ),
// // ),
// // Text(
// // widget.status == 0 ? 'Pending' : 'Completed',
// // style: TextStyle(
// // fontSize: 16,
// // color: widget.status == 0 ? Colors.amber : Colors.green,
// // fontWeight: FontWeight.bold,
// // ),
// // ),
// // ],
// // ),
// // SizedBox(
// // height: 10,
// // ),
// // Divider(
// // thickness: 2,
// // ),
// // SizedBox(
// // height: 10,
// // ),
// // Expanded(
// // child: ListView.builder(
// // shrinkWrap: true,
// // itemCount: widget.provider.length,
// // itemBuilder: (context, index) {
// // return Column(
// // crossAxisAlignment: CrossAxisAlignment.start,
// // children: [
// // Row(
// // mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // children: [
// // Text(
// // '1x',
// // style: TextStyle(fontWeight: FontWeight.w400),
// // ),
// // SizedBox(
// // width: 5,
// // ),
// // Expanded(
// // child: Text(
// // '${widget.provider[index].name} - ${widget.provider[index].category}',
// // style: TextStyle(
// // fontWeight: FontWeight.w700,
// // overflow: TextOverflow.ellipsis),
// // ),
// // ),
// // Text(
// // 'PKR ${widget.provider[index].price}',
// // style: TextStyle(fontWeight: FontWeight.w700),
// // ),
// // ],
// // ),
// // SizedBox(
// // height: 20,
// // ),
// // ],
// // );
// // }),
// // ),
// // ],
// // ),
// // ),

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/models/service_provider_model.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatefulWidget {
  static const String routeName = '/order-details';
  const OrderDetails(
      {Key? key,
      required this.id,
      required this.status,
      required this.requestedOn,
      required this.totalPrice,
      required this.customerId,
      required this.firstName,
      required this.carName,
      required this.carNumber,
      required this.customerAddress,
      required this.serviceName,
      required this.serviceProviderId,
      required this.mechanicName,
      required this.mechanicEmail,
      required this.mechanicPhone})
      : super(key: key);

  final String id;
  final String status;
  final String requestedOn;
  final double totalPrice;
  final String customerId;
  final String firstName;
  final String carName;
  final String carNumber;
  final String customerAddress;
  final String serviceName;
  final String serviceProviderId;
  final String mechanicName;
  final String mechanicEmail;
  final String mechanicPhone;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentStep = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.status == 'PLACED') {
      currentStep = 1;
    } else if (widget.status == 'REJECT') {
      currentStep = 0;
    } else if (widget.status == 'ACCEPTED') {
      currentStep = 3;
    } else if (widget.status == 'COMPLETED') {
      currentStep = 4;
    } else if (widget.status == 'IN-PROCESS') {
      currentStep = 2;
    }
    print(currentStep);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.1),
        child: AppBar(
          foregroundColor: kTextColor,
          title: Text(
            'Order details',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              // size: 12,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            padding: EdgeInsets.only(top: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   '#${widget.orderNo}',
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
                Flexible(
                  child: AutoSizeText(
                    widget.serviceName,
                    // style: TextStyle(
                    //   color: kTextColor,
                    //   fontWeight: FontWeight.bold,
                    //   fontSize: 30,
                    // ),
                    // maxFontSize: 24,
                    minFontSize: 22,
                    style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Text(
                //   'PKR ${widget.totalPrice.toInt().toString()}',
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.w800,
                //     color: kPrimaryColor,
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PKR ${widget.totalPrice.toInt().toString()}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.customerAddress,
                    style: TextStyle(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // Text(
                //   widget.status,
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: widget.status == 'PLACED'
                //         ? Colors.black45
                //         : widget.status == 'ACCEPTED'
                //             ? Colors.amber
                //             : widget.status == 'REJECT'
                //                 ? Colors.red
                //                 : Colors.green,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Divider(
              thickness: 2,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          //   child: ListView.builder(
          //       itemCount: widget.provider.length,
          //       shrinkWrap: true,
          //       physics: ScrollPhysics(),
          //       itemBuilder: (context, index) {
          //         return Container(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(
          //                     '1x',
          //                     style: TextStyle(fontWeight: FontWeight.w400),
          //                   ),
          //                   SizedBox(
          //                     width: 5,
          //                   ),
          //                   Expanded(
          //                     child: Text(
          //                       '${widget.provider[index].name} - ${widget.provider[index].category}',
          //                       style: TextStyle(
          //                           fontWeight: FontWeight.w700,
          //                           overflow: TextOverflow.ellipsis),
          //                     ),
          //                   ),
          //                   Text(
          //                     'PKR ${widget.provider[index].price}',
          //                     style: TextStyle(fontWeight: FontWeight.w700),
          //                   ),
          //                 ],
          //               ),
          //               Row(
          //                 children: [
          //                   Text(
          //                     'Brand: ',
          //                     style: TextStyle(
          //                         fontSize: 13,
          //                         color: kTextColor.withOpacity(0.4)),
          //                   ),
          //                   Text(
          //                     widget.provider[index].brandName,
          //                     style: TextStyle(
          //                       fontSize: 16,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: 40,
          //               ),
          //             ],
          //           ),
          //         );
          //       }),
          // ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //
                //     // Expanded(
                //     //   child: Text(
                //     //     '${widget.provider[index].name} - ${widget.provider[index].category}',
                //     //     style: TextStyle(
                //     //         fontWeight: FontWeight.w700,
                //     //         overflow: TextOverflow.ellipsis),
                //     //   ),
                //     // ),
                //     // Text(
                //     //   'PKR ${widget.provider[index].price}',
                //     //   style: TextStyle(fontWeight: FontWeight.w700),
                //     // ),
                //   ],
                // ),
                widget.mechanicName.isNotEmpty
                    ? Text(
                        'Mechanic Details: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                widget.mechanicName.isNotEmpty
                    ? Card(
                        color: kPrimaryColor,
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            widget.mechanicName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTextColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                widget.mechanicEmail.isNotEmpty
                    ? Card(
                        color: kPrimaryColor,
                        child: ListTile(
                          leading: Icon(Icons.email),
                          title: Text(
                            widget.mechanicEmail,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTextColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                widget.mechanicPhone.isNotEmpty
                    ? Card(
                        color: kPrimaryColor,
                        child: ListTile(
                          leading: Icon(Icons.phone),
                          title: Text(
                            widget.mechanicPhone,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kTextColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    : Container(),

                SizedBox(
                  height: 10,
                ),
                widget.carName.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Car: ',
                            style: TextStyle(
                                fontSize: 13,
                                color: kTextColor.withOpacity(0.4)),
                          ),
                          Text(
                            widget.carName,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            'Number: ',
                            style: TextStyle(
                                fontSize: 13,
                                color: kTextColor.withOpacity(0.4)),
                          ),
                          Text(
                            widget.carNumber,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              'Ordered @ ${DateFormat().format(DateTime.parse(widget.requestedOn))}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Divider(
              thickness: 2,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              'Tracking',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: widget.status != 'REJECT'
                  ? Stepper(
                      physics: ScrollPhysics(),
                      currentStep: currentStep - 1,
                      controlsBuilder: (context, details) {
                        return SizedBox();
                      },
                      steps: [
                        Step(
                          title: Text('Placed'),
                          content: Text('Your order is being confirmed..'),
                          isActive: currentStep >= 1,
                          state: currentStep >= 1
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: Text('In-Process'),
                          content: Text('Your order is being processed..'),
                          isActive: currentStep >= 2,
                          state: currentStep >= 2
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: Text('Accepted'),
                          content: Text('Order accepted successfully..'),
                          isActive: currentStep >= 3,
                          state: currentStep >= 3
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: Text('Completed'),
                          content: Text('Order completed successfully..'),
                          isActive: currentStep >= 4,
                          state: currentStep >= 4
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                      ],
                    )
                  : Stepper(
                      physics: ScrollPhysics(),
                      currentStep: currentStep,
                      controlsBuilder: (context, details) {
                        return SizedBox();
                      },
                      steps: [
                        Step(
                          title: Text('Reject'),
                          content:
                              Text('Service is rejected by this mechanic.'),
                          isActive: currentStep >= 0,
                          state: currentStep >= 0
                              ? StepState.error
                              : StepState.indexed,
                        ),
                      ],
                    )),
        ],
      ),
    );
  }
}

// Container(
// width: size.width,
// padding: EdgeInsets.only(top: kDefaultPadding),
// margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
// child: Column(
// children: [
// Row(
// children: [
// Text(
// '#${widget.orderNo}',
// style: TextStyle(
// fontSize: 22,
// fontWeight: FontWeight.w700,
// ),
// ),
// Spacer(),
// Text(
// 'PKR ${widget.price.toInt().toString()}',
// style: TextStyle(
// fontSize: 22,
// fontWeight: FontWeight.w800,
// color: kPrimaryColor,
// ),
// ),
// ],
// ),
// SizedBox(
// height: 10,
// ),
// Row(
// children: [
// Expanded(
// child: Text(
// widget.address,
// style: TextStyle(
// fontSize: 16,
// overflow: TextOverflow.ellipsis,
// ),
// ),
// ),
// Text(
// widget.status == 0 ? 'Pending' : 'Completed',
// style: TextStyle(
// fontSize: 16,
// color: widget.status == 0 ? Colors.amber : Colors.green,
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// SizedBox(
// height: 10,
// ),
// Divider(
// thickness: 2,
// ),
// SizedBox(
// height: 10,
// ),
// Expanded(
// child: ListView.builder(
// shrinkWrap: true,
// itemCount: widget.provider.length,
// itemBuilder: (context, index) {
// return Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// '1x',
// style: TextStyle(fontWeight: FontWeight.w400),
// ),
// SizedBox(
// width: 5,
// ),
// Expanded(
// child: Text(
// '${widget.provider[index].name} - ${widget.provider[index].category}',
// style: TextStyle(
// fontWeight: FontWeight.w700,
// overflow: TextOverflow.ellipsis),
// ),
// ),
// Text(
// 'PKR ${widget.provider[index].price}',
// style: TextStyle(fontWeight: FontWeight.w700),
// ),
// ],
// ),
// SizedBox(
// height: 20,
// ),
// ],
// );
// }),
// ),
// ],
// ),
// ),
