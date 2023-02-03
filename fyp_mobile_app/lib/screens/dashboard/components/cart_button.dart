import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/models/service_provider_model.dart';
import 'package:fyp_mobile_app/providers/service_provider.dart';
import 'package:fyp_mobile_app/providers/swapCartButtonProvider.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:fyp_mobile_app/services/service_provider_service.dart';

class CartButton extends StatefulWidget {
  CartButton({
    Key? key,
    required this.id,
    required this.isSelected,
    required this.index,
  }) : super(key: key);

  final String id;
  bool isSelected;
  // int index;
  final int index;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  // bool isSelected = false;
  ServiceProviderService service = ServiceProviderService();
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
// // your code goes here
//       final userProvider = Provider.of<UserProvider>(context, listen: false);
//       try {
//         for (int i = 0; i < userProvider.user.cart.length; i++) {
//           if (widget.id == userProvider.user.cart[i]['product']['_id']) {
//             isSelected = userProvider.user.cart[i]['addToCart'];
//             print(isSelected);
//             break;
//           }
//         }
//       } catch (e) {
//         // TODO
//       }
//     });
//   }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    bool selected = false;
    // for (int i = 0; i < userProvider.user.cart.length; i++) {
    //   if (userProvider.user.cart[i]['product']['_id'] == widget.id) {
    //     selected = true;
    //     break;
    //   } else {
    //     selected = false;
    //   }
    // }
    // print(widget.isSelected);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        !selected
            ? ElevatedButton(
                onPressed: () {
                  // service.clickToCart(id: widget.id);
                  print('tai');
                  // print(widget.index);
                  setState(() {
                    selected = true;
                  });
                  service.addToCart(
                      context: context,
                      serviceID: widget.id,
                      isSelected: selected,
                      index: widget.index,
                      userID: userProvider.user.id);

                  // print(widget.index);

                  // Provider.of<SwapCartButtonProvider>(context, listen: false)
                  //     .setCartButton(false);
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
                      Icons.add_shopping_cart,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Add to cart",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            : Row(
                children: [
                  IconButton(
                      onPressed: () {
                        // service.clickDeleteCart(id: widget.id);
                        setState(() {
                          selected = false;
                        });
                        service.deleteFromCart(
                          context: context,
                          serviceID: widget.id,
                        );

                        // Provider.of<SwapCartButtonProvider>(context,
                        //         listen: false)
                        //     .setCartButton(true);
                      },
                      icon: Icon(Icons.delete)),
                  ElevatedButton(
                    onPressed: null,
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
                          Icons.check,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Added to cart",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ],
    );
  }
}
