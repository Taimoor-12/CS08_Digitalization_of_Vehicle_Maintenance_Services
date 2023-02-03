// import 'package:flutter/material.dart';
// import 'package:fyp_mobile_app/models/service_provider_model.dart';
// import 'package:fyp_mobile_app/screens/orders/components/orders_details.dart';
// import 'package:intl/intl.dart';
//
// import '../../../constants.dart';
//
// class OrderTile extends StatefulWidget {
//   const OrderTile({
//     Key? key,
//     required this.size,
//     required this.status,
//     required this.date,
//     required this.price,
//     required this.orderNo,
//     required this.provider,
//     required this.address,
//   }) : super(key: key);
//
//   final Size size;
//   final int status;
//   final int date;
//   final double price;
//   final String orderNo;
//   final String address;
//   final List<ServiceProvider> provider;
//
//   @override
//   State<OrderTile> createState() => _OrderTileState();
// }
//
// class _OrderTileState extends State<OrderTile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.size.width,
//       padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//       margin: EdgeInsets.only(
//           left: kDefaultPadding,
//           right: kDefaultPadding,
//           bottom: kDefaultPadding),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             children: [
//               Text(
//                 '#${widget.orderNo}',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               Spacer(),
//               Text(
//                 'PKR ${widget.price.toInt().toString()}',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                   color: kPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Row(
//             children: [
//               Text(
//                 DateFormat()
//                     .format(DateTime.fromMillisecondsSinceEpoch(widget.date)),
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//               // Text(
//               //   ' 19:44',
//               //   style: TextStyle(
//               //     fontSize: 18,
//               //   ),
//               // ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Divider(
//             thickness: 1.5,
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             children: [
//               Text(
//                 widget.status == 0
//                     ? 'Pending'
//                     : widget.status == 1
//                         ? 'Processing'
//                         : 'Completed',
//                 style: TextStyle(
//                   fontSize: 22,
//                   color: widget.status == 0
//                       ? Colors.amber
//                       : widget.status == 1
//                           ? Colors.black45
//                           : Colors.green,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Spacer(),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigator.pushNamed(context, OrderDetails.routeName,
//                   //     arguments: OrderDetails(
//                   //       provider: widget.provider,
//                   //       orderNo: widget.orderNo,
//                   //       price: widget.price,
//                   //       date: widget.date,
//                   //       status: widget.status,
//                   //       address: widget.address,
//                   //     ));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Theme.of(context).primaryColor,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(15),
//                       topLeft: Radius.circular(15),
//                       bottomRight: Radius.circular(15),
//                       bottomLeft: Radius.circular(15),
//                     ),
//                   ),
//                   elevation: 4.5,
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.list,
//                       size: 30,
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Text(
//                       "View details",
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/models/service_provider_model.dart';
import 'package:fyp_mobile_app/screens/orders/components/orders_details.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({
    Key? key,
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
    required this.size,
    required this.mechanicName,
    required this.mechanicEmail,
    required this.mechanicPhone,
  }) : super(key: key);

  final Size size;
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
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      margin: EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(
              //   child: Text(
              //     widget.serviceName,
              //     style: TextStyle(
              //       fontSize: 22,
              //       fontWeight: FontWeight.w700,
              //     ),
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
                  maxFontSize: 24,
                  minFontSize: 19,
                  style: TextStyle(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
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
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                DateFormat().format(DateTime.parse(widget.requestedOn)),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              // Text(
              //   ' 19:44',
              //   style: TextStyle(
              //     fontSize: 18,
              //   ),
              // ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 1.5,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.status,
                  style: TextStyle(
                    fontSize: 18,
                    color: widget.status == 'PLACED'
                        ? Colors.black26
                        : widget.status == 'IN-PROCESS'
                            ? Colors.black45
                            : widget.status == 'ACCEPTED'
                                ? Colors.amber
                                : widget.status == 'REJECT'
                                    ? Colors.red
                                    : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Spacer(),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, OrderDetails.routeName,
                        arguments: OrderDetails(
                          id: widget.id,
                          status: widget.status,
                          requestedOn: widget.requestedOn,
                          totalPrice: widget.totalPrice,
                          customerId: widget.customerId,
                          firstName: widget.firstName,
                          carName: widget.carName,
                          carNumber: widget.carNumber,
                          customerAddress: widget.customerAddress,
                          serviceName: widget.serviceName,
                          serviceProviderId: widget.serviceProviderId,
                          mechanicName: widget.mechanicName,
                          mechanicPhone: widget.mechanicPhone,
                          mechanicEmail: widget.mechanicEmail,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    elevation: 4.5,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.list,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "View details",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
