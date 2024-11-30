import 'dart:io';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lipstick/Screens/Product%20Details%20Page/Bloc/productDetails_bloc.dart';
import 'package:lipstick/Screens/Product%20Details%20Page/Models/productDetailsRepository.dart';
import 'package:lipstick/Screens/Product%20Details%20Page/Models/productDetailsResponse.dart';
import 'package:lipstick/Screens/Product%20Details%20Page/Utils/endDrawer.dart';
import 'package:lipstick/Service/apiService.dart';
import 'package:lipstick/Styles/textStyles.dart';
import 'package:lipstick/utils/customColors.dart';
import 'package:lipstick/utils/hexColor.dart';
import 'package:lipstick/utils/loader.dart';
import 'package:lipstick/utils/themeHelper.dart';
import 'package:lipstick/utils/toastMessage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Class for the Login Screen Page
class productDetailsPage extends StatefulWidget {
  const productDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<productDetailsPage> createState() => _LoginPageState();
}

// State class for the Login Screen Page
class _LoginPageState extends State<productDetailsPage> {
  late productDetailsBloc productBloc;
  final _dio = Dio();
  ProductDetailsResponse? details;
  String selectedColor = "Warm Cocoa";
  final TextEditingController _messageController = TextEditingController();
  bool isMessaging = false;
  bool isShowDescription = false;
  bool isShowSpecification = false;
  bool isShowHowToUse = false;
  int selectedQuantity = 0;
  int maxOrder = 0;
  int minOrder = 0;
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  double _rating = 0;
  final _formKey = GlobalKey<FormState>();
  List<dynamic> cart = [];
  bool _isDrawerClosed = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    productBloc =
        productDetailsBloc(Productdetailsrepository(ApiService(_dio)));
    context.read<productDetailsBloc>().add(Start());
    checkAndUpdateQuantity();

    super.initState();
  }

  void checkAndUpdateQuantity() {
    // Find the item in cart that matches the selected color
    var cartItem = cart.firstWhere(
      (item) => item['color'] == selectedColor,
      orElse: () => null,
    );

    // If the item is found, update the selectedQuantity
    if (cartItem != null) {
      setState(() {
        selectedQuantity = cartItem['Quantity'];
      });
    } else {
      selectedQuantity = minOrder;
    }
  }

  void incrementQuantity(int maxOrder) {
    setState(() {
      if (selectedQuantity < maxOrder) {
        selectedQuantity++;
      } else {
        ToastMessage.showMessage('Quantity not available');
      }
    });
  }

  void decrementQuantity() {
    setState(() {
      if (selectedQuantity > minOrder) {
        selectedQuantity--;
      } else {
        ToastMessage.showMessage('Cannot Order Quantity below $minOrder');
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_nameController.text}');
      print('Rating: $_rating');
      print('Comments: ${_commentController.text}');
      ToastMessage.showMessage('Review Submitted Sucessfully');
      FocusScope.of(context).unfocus();
      setState(() {
        _nameController.clear();
        _commentController.clear();
        _rating = 0;
      });
    }
  }

  void updateCart(List<dynamic> updatedCart) {
    setState(() {
      cart = updatedCart; // Update the cart with new data
    });
  }

  @override
  void dispose() {
    productBloc.close();
    _nameController.dispose();
    _commentController.dispose();
    _messageController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextt) {
    return PopScope(
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },

      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('LipStick'),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: BlocConsumer<productDetailsBloc, productDetailsState>(
          listener: (context, state) async {
            if (state is productDetailsError) {
              buildErrorLayout();
            } else if (state is productDetailsSuccessful) {
              Successfull(state.productDetails);
            }
          },
          builder: (context, state) {
            if (state is productDetailsLoading) {
              return LoadingWidget(child: Container());
            } else if (state is productDetailsSuccessful) {
              return buildInitialInput(
                  data: state.productDetails, contextt: contextt);
            } else {
              return LoadingWidget(
                  child: Container(
                color: Colors.blue,
              ));
            }
          },
        ),
        endDrawer: CartDrawer(
          onCartUpdated: updateCart,
          cart: cart,
          onCheckout: () {
            ToastMessage.showMessage('Purchase Completed');
            FocusManager.instance.primaryFocus!.unfocus();
            checkAndUpdateQuantity();
            Navigator.of(context).pop();
            setState(() {});
          },
        ),
      ),
    );
  }

  // Widget for building the initial input form
  Widget buildInitialInput(
      {ProductDetailsResponse? data, BuildContext? contextt}) {
    return Builder(builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Feature Image and Thumbnails
            SizedBox(
              height: 300,
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: data!.data!.images!.map<Widget>((image) {
                  return Image.network(image, fit: BoxFit.cover);
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: data!.data!.images!.length, // Total number of images
                  effect: ExpandingDotsEffect(
                    dotWidth: 8.0,
                    dotHeight: 8.0,
                    spacing: 8.0,
                    expansionFactor: 4.0,
                    activeDotColor: HexColor(data.data!.colorVariants!
                        .firstWhere(
                            (element) => element.color!.name == selectedColor)
                        .color!
                        .colorValue!
                        .join('')), // Customize active dot color
                    dotColor: Colors.grey, // Customize inactive dot color
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Product Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.data!.title.toString(), style: Styles.mainTitlle),
                  Text(
                      'CODE: ${data.data!.colorVariants!.firstWhere((element) => element.color!.name == selectedColor).productCode}',
                      style: Styles.normalBoldText),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Rating: ', style: Styles.secondaryTitle),
                      RatingBar.readOnly(
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        initialRating: data.data!.ratings!.toDouble(),
                        maxRating: 5,
                      )
                    ],
                  ),

                  //price Section
                  Row(
                    children: [
                      Text(
                        "₹${data.data!.colorVariants!.firstWhere((element) => element.color!.name == selectedColor).price}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "₹${data.data!.colorVariants!.firstWhere((element) => element.color!.name == selectedColor).strikePrice}",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough),
                      ),
                      const SizedBox(width: 10),
                      Text(
                          "${data.data!.colorVariants!.firstWhere((element) => element.color!.name == selectedColor).offPercent}% OFF",
                          style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Variants
                  Text("Color ($selectedColor)", style: Styles.secondaryTitle),

                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Wrap(
                      children: (data.data!.colorVariants as List<dynamic>)
                          .map<Widget>((variant) {
                        return ChoiceChip(
                          shape: CircleBorder(),
                          label: Text(''),
                          backgroundColor:
                              HexColor(variant.color.colorValue.join('')),
                          selected: selectedColor == variant.color.name,
                          selectedColor: HexColor(variant.color.colorValue
                              .join('')), // Use the same color when selected
                          onSelected: (selected) {
                            setState(() {
                              selectedColor = variant.color.name;
                              maxOrder = data.data!.colorVariants!
                                      .firstWhere((element) =>
                                          element.color!.name ==
                                          variant.color.name)
                                      .maxOrder ??
                                  0;
                              minOrder = data.data!.colorVariants!
                                      .firstWhere((element) =>
                                          element.color!.name ==
                                          variant.color.name)
                                      .minOrder ??
                                  0;
                              checkAndUpdateQuantity();
                            });
                          },
                          side: BorderSide(
                            color: selectedColor == variant.color.name
                                ? Colors.black
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Quantity Selector
                  const Text(
                    "Select Quantity:",
                    style: Styles.secondaryTitle,
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: CustomColors.appColor),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: decrementQuantity,
                                icon: const Icon(Icons.remove),
                                color: Colors.red,
                              ),
                              Text(
                                "$selectedQuantity",
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () => incrementQuantity(maxOrder),
                                icon: const Icon(Icons.add),
                                color: Colors.green,
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: const SizedBox(width: 20)),
                        Text(
                          "(Available: $maxOrder)",
                          style: Styles.normalLightText,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Add to Cart & Message Seller
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ToastMessage.showMessage("Added to Cart!");
                            if (selectedQuantity >= minOrder) {
                              int existingItemIndex = cart.indexWhere(
                                  (item) => item['color'] == selectedColor);

                              if (existingItemIndex != -1) {
                                // Replace the existing item with the new one
                                cart[existingItemIndex] = {
                                  'name': data.data!.title,
                                  'color': selectedColor,
                                  'Quantity': selectedQuantity,
                                  'minOrder': minOrder,
                                  'maxOrder': maxOrder,
                                  'price': data.data!.colorVariants!
                                      .firstWhere((element) =>
                                          element.color!.name == selectedColor)
                                      .price
                                      .toString(),
                                  'strikePrice': data.data!.colorVariants!
                                      .firstWhere((element) =>
                                          element.color!.name == selectedColor)
                                      .strikePrice
                                      .toString(),
                                  'image': data.data!.images![0]
                                };
                              } else {
                                cart.add({
                                  'name': data.data!.title,
                                  'color': selectedColor,
                                  'Quantity': selectedQuantity,
                                  'minOrder': minOrder,
                                  'maxOrder': maxOrder,
                                  'price': data.data!.colorVariants!
                                      .firstWhere((element) =>
                                          element.color!.name == selectedColor)
                                      .price
                                      .toString(),
                                  'strikePrice': data.data!.colorVariants!
                                      .firstWhere((element) =>
                                          element.color!.name == selectedColor)
                                      .strikePrice
                                      .toString(),
                                  'image': data.data!.images![0]
                                });
                              }
                              Scaffold.of(context).openEndDrawer();
                            }
                          },
                          child: const Text("Add to Cart",
                              style: Styles.ButtonStyle),
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (!isMessaging)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isMessaging = !isMessaging;
                              });
                            },
                            child: const Text("Message Seller",
                                style: Styles.ButtonStyle),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (isMessaging)
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: CustomColors.PrimaryColor.withOpacity(0.3)),
                      child: Column(
                        children: [
                          const Text('Send Message to Seller',
                              style: Styles.ButtonStyle),
                          const SizedBox(
                            height: 8,
                          ),
                          TextField(
                            controller: _messageController,
                            decoration: ThemeHelper().textInputDecoration(
                                lableText: 'Message',
                                hintText: 'Enter Your Message'),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isMessaging = !isMessaging;
                                      _messageController.clear();
                                    });
                                    _messageController.clear();
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: const Text(
                                    "Cancel",
                                    style: Styles.ButtonStyle,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    ToastMessage.showMessage(
                                        "Thank you for Contacting Us!");
                                    _messageController.clear();
                                  },
                                  child: const Text(
                                    "Send Message",
                                    style: Styles.ButtonStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Description

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowDescription = !isShowDescription;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColors.appColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Text("Description:",
                                        style: Styles.secondMainTitle),
                                  ),
                                ),
                              ),
                              IconButton(
                                // padding: const EdgeInsets.only(right: 25),
                                icon: Icon(
                                  isShowDescription == true
                                      ? Icons.expand_more
                                      : Icons.expand_less_outlined,
                                  size: 30,
                                  color: CustomColors.PrimaryColor,
                                ),
                                highlightColor: CustomColors.appColorAccent,
                                onPressed: () {
                                  setState(() {
                                    isShowDescription = !isShowDescription;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isShowDescription == true
                              ? Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Center(
                                            child: HtmlWidget(
                                                data.data!.description!),
                                          ),
                                        )
                                      ]))
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Specifications

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowSpecification = !isShowSpecification;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColors.appColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Text("Specifications:",
                                        style: Styles.secondMainTitle),
                                  ),
                                ),
                              ),
                              IconButton(
                                // padding: const EdgeInsets.only(right: 25),
                                icon: Icon(
                                  isShowSpecification == true
                                      ? Icons.expand_more
                                      : Icons.expand_less_outlined,
                                  size: 30,
                                  color: CustomColors.PrimaryColor,
                                ),
                                highlightColor: CustomColors.appColorAccent,
                                onPressed: () {
                                  setState(() {
                                    isShowSpecification = !isShowSpecification;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isShowSpecification == true
                              ? Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Center(
                                            child: HtmlWidget(
                                                data.data!.ingredient!),
                                          ),
                                        )
                                      ]))
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // how to use
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowHowToUse = !isShowHowToUse;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColors.appColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Text("How To Use?:",
                                        style: Styles.secondMainTitle),
                                  ),
                                ),
                              ),
                              IconButton(
                                // padding: const EdgeInsets.only(right: 25),
                                icon: Icon(
                                  isShowHowToUse == true
                                      ? Icons.expand_more
                                      : Icons.expand_less_outlined,
                                  size: 30,
                                  color: CustomColors.PrimaryColor,
                                ),
                                highlightColor: CustomColors.appColorAccent,
                                onPressed: () {
                                  setState(() {
                                    isShowHowToUse = !isShowHowToUse;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isShowHowToUse == true
                              ? Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Center(
                                            child: HtmlWidget(
                                                data!.data!.howToUse!),
                                          ),
                                        )
                                      ]))
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  //Reviews and Ratings
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColors.PrimaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reviews and Ratings',
                          style: Styles.secondMainTitle,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Reviews to show',
                              style: Styles.normalBoldText,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //Rating and Review
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColors.PrimaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Add a Review',
                            style: Styles.secondMainTitle,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: '* ', // Red asterisk
                                  style: Styles.normalTextRed,
                                ),
                                TextSpan(
                                  text: 'Guest Full Name', // Black text
                                  style: Styles.secondaryTitle,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: ThemeHelper().textInputDecoration(
                                hintText: 'Enter your full name',
                                lableText: 'Full Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Give your Rating',
                            style: Styles.secondaryTitle,
                          ),
                          RatingBar(
                            size: 30,
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            onRatingChanged: (value) => setState(() {
                              _rating = value;
                            }),
                            initialRating: 0,
                            maxRating: 5,
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: '* ', // Red asterisk
                                  style: Styles.normalTextRed,
                                ),
                                TextSpan(
                                  text: 'Comments', // Black text
                                  style: Styles.secondaryTitle,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _commentController,
                            decoration: ThemeHelper().textInputDecoration(
                                hintText: 'Enter Your Comments',
                                lableText: 'Comments'),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your comments';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text(
                                'Submit',
                                style: Styles.ButtonStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  // Build and display error message
  ScaffoldFeatureController buildErrorLayout() =>
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: CustomColors.appColor,
        content: Text(
          'Invalid username or password',
          style: TextStyle(fontSize: 20),
        ),
      ));

  void Successfull(ProductDetailsResponse value) async {
    setState(() {
      details = value;
      maxOrder = value.data!.colorVariants!
              .firstWhere((element) => element.color!.name == selectedColor)
              .maxOrder ??
          0;
      minOrder = value.data!.colorVariants!
              .firstWhere((element) => element.color!.name == selectedColor)
              .minOrder ??
          0;
      selectedQuantity = minOrder;
    });
  }
}
