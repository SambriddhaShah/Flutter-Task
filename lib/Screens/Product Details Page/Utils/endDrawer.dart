import 'package:flutter/material.dart';
import 'package:lipstick/Styles/textStyles.dart';
import 'package:lipstick/utils/customColors.dart';
import 'package:lipstick/utils/toastMessage.dart';

class CartDrawer extends StatefulWidget {
  final Function onCheckout;
  final List<dynamic> cart;
  final Function(List<dynamic>) onCartUpdated;
  // widget.onCartUpdated(editedCart);
  const CartDrawer(
      {Key? key,
      required this.onCheckout,
      required this.cart,
      required this.onCartUpdated})
      : super(key: key);

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  List<dynamic>? cartt;

  @override
  void initState() {
    cartt = widget.cart;

    super.initState();
  }

  double calculateTotalPrice() {
    double total = 0.0;

    for (var item in cartt!) {
      double price =
          double.tryParse(item['price']) ?? 0.0; // Convert price to double
      int quantity =
          item['Quantity'] ?? 1; // Get the quantity, default to 1 if not found
      total += price * quantity; // Add price * quantity to the total
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: [
          // Drawer Header
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cart (${cartt!.length} item)',
              style: Styles.secondMainTitle,
            ),
          ),
          Divider(),
          // Cart Item
          Container(
              height: MediaQuery.of(context).size.height / 3,
              child: cartt!.length != 0
                  ? ListView.builder(
                      itemCount: cartt!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Product Image
                                  Container(
                                    width: 60,
                                    height: 60,
                                    child: Image.network(
                                      cartt![index][
                                          'image'], // Replace with product image
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartt![index]['name'],
                                          style: Styles.normalBoldText,
                                        ),
                                        Text('Color: ${cartt![index]['color']}',
                                            style: Styles.normalLightText),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹ ${cartt![index]['price']}',
                                              style: Styles.normalBoldText,
                                            ),
                                            Text(
                                              '₹ ${cartt![index]['strikePrice']}',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                        // Quantity Selector
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: CustomColors.appColor),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      if (cartt![index]
                                                                  ['Quantity'] -
                                                              1 >=
                                                          cartt![index]
                                                              ['minOrder']) {
                                                        setState(() {
                                                          cartt![index]
                                                                  ['Quantity'] =
                                                              cartt![index][
                                                                      'Quantity'] -
                                                                  1;
                                                        });
                                                        widget.onCartUpdated(
                                                            cartt!);
                                                      } else {
                                                        ToastMessage.showMessage(
                                                            'Cannot order less Quantity');
                                                      }
                                                    },
                                                    icon: const Icon(
                                                        Icons.remove),
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                    cartt![index]['Quantity']
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      if (cartt![index]
                                                                  ['Quantity'] +
                                                              1 <=
                                                          cartt![index]
                                                              ['maxOrder']) {
                                                        setState(() {
                                                          cartt![index]
                                                                  ['Quantity'] =
                                                              cartt![index][
                                                                      'Quantity'] +
                                                                  1;
                                                        });
                                                        widget.onCartUpdated(
                                                            cartt!);
                                                      } else {
                                                        ToastMessage.showMessage(
                                                            'Cannot add more');
                                                      }
                                                    },
                                                    icon: const Icon(Icons.add),
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                child:
                                                    const SizedBox(width: 20)),
                                            Text(
                                              "(Available: ${cartt![index]['maxOrder']})",
                                              style: Styles.normalLightText,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              cartt!.removeAt(index);

                                              widget.onCartUpdated(cartt!);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(
                                                  30,
                                                  30,
                                                ),
                                                backgroundColor:
                                                    CustomColors.appColor),
                                            child: Text(
                                              'Remove',
                                              style: Styles.ButtonStyle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            cartt!.length == 1
                                ? SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(),
                                  )
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No Items',
                        style: Styles.normalBoldText,
                      ),
                    )),
          Divider(),
          // Price Summary
          Container(
            decoration: BoxDecoration(
              color: CustomColors.PrimaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price Summary',
                    style: Styles.secondMainTitle,
                  ),
                  Divider(
                    color: CustomColors.PrimaryColor,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total'),
                      Text('₹ ${calculateTotalPrice().toInt()}'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Payable'),
                      Text('₹ ${calculateTotalPrice().toInt()}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          // Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    cartt!.clear();
                    widget.onCartUpdated(cartt!);
                    widget.onCheckout();
                    // Handle Order as Guest action
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        double.infinity,
                        50,
                      ),
                      backgroundColor: CustomColors.appColor),
                  child: Text(
                    'Order as Guest',
                    style: Styles.ButtonStyle,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    cartt!.clear();
                    widget.onCartUpdated(cartt!);
                    widget.onCheckout();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: CustomColors.appColor,
                  ),
                  child: Text(
                    'Proceed To Checkout',
                    style: Styles.ButtonStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ); // Wrap your Drawer with WillPopScope
  }
}
