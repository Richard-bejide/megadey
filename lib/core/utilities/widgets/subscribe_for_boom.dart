// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'error_widget.dart';
// import 'loading_widget.dart';
//
//
// class SubscribeForBoomView extends StatefulWidget {
//   static const routeName = 'subscribeForBoomView';
//
//   const SubscribeForBoomView({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<SubscribeForBoomView> createState() => _SubscribeForBoomViewState();
// }
//
// class _SubscribeForBoomViewState extends State<SubscribeForBoomView> {
//
//   ErrorType? errorType;
//   bool isLoading = false;
//
//   int? selectedPlanAmount = 0;
//   int selectedPlanIndex = 0;
//
//   //boom
//   PlanData? boom1week;
//   PlanData? boom1month;
//   PlanData? boom3month;
//   PlanData? boom6month;
//   PlanData? boom12months;
//
//
//   PaymentMethod? selectedPaymentMethod = PaymentMethod.credit_card;
//
//   List<Map<String, String>> features = [
//     {"Unlimited Swipes": "You'll have unlimited access to swipe on our swipe deck."},
//     {"Unlimited Advanced Filters": "You'll have unlimited access to use wide range of advanced filters."},
//     {"Unlimited Supersavours": "You'll have unlimited usage of the big heart button on our swipe deck to show other users, you really like them."},
//     {"Unlimited Extends": "You'll be able to extends matches expiry time"},
//     {"Unlimited Re-match": "You'll be able to rematch with expired matches"},
//     {"Unlimited Rewind": "You'll have unlimited usage of the rewind button on our swipe deck."},
//     {"Travel mode": "You'll be able to see people in other locations."},
//     {"LimeLight": "You'll appear more frequently on our swipe deck."},
//   ];
//
//
//   @override
//   void initState(){
//     //get plan prices from db
//     _fetchAllPlans();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             stops: const [0.1, 0.6],
//             colors: [Palette.primaryColor, Palette.superLikeColor],
//           ),
//         ),
//         child: SafeArea(
//           child: LoadingOverlay(
//             isLoading: isLoading,
//             color: Palette.primaryColor.withOpacity(0.7),
//             progressIndicator: LoadingWidget(iconColor: Palette.primaryColor, size: 40),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                         padding: const EdgeInsets.only(top: 20.0, bottom: 10, left: 10),
//                         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                           IconButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               icon: const Icon(Icons.arrow_back_ios_new_outlined,
//                                   color: Palette.white, size: 24)),
//                           const Text('Available on Boom',
//                               style: TextStyle(
//                                   color: Palette.white,
//                                   letterSpacing: 0.0,
//                                   fontSize: 24.0,
//                                   fontWeight: FontWeight.w700)),
//                           const SizedBox(width: 60.0),
//                         ]))),
//                 Expanded(
//                   child: isLoading
//                       ? Container()
//                       : errorType != null
//                           ? ErrorScreen(
//                         errorType: errorType!,
//                         onTap: () async {
//                           _fetchAllPlans();
//                         })
//                           : Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: ListView(shrinkWrap: true, children: [
//                           Image.asset('assets/images/logo/Logo mark.png',
//                               height: 80),
//                           const SizedBox(height: 50),
//                           const Center(
//                               child: Text('What you\'ll get:',
//                                   style: TextStyle(
//                                       color: Palette.white, fontSize: 30.0, fontWeight: FontWeight.w700))),
//                           const SizedBox(height: 20),
//                           ListView.builder(
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: features.length,
//                               shrinkWrap: true,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 12.0),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(features[index].keys.first,
//                                           style: const TextStyle(
//                                               fontStyle: FontStyle.italic,
//                                               color: Palette.white,
//                                               fontSize: 17.0,
//                                               fontWeight: FontWeight.w600)),
//                                       const SizedBox(width: 5),
//                                           GestureDetector(
//                                             onTap: (){_featureInfoView(features[index].keys.first, features[index].values.first);},
//                                             child: const Icon(Icons.info_outlined,size: 21,color: Colors.white),
//                                           )
//
//                                     ],
//                                   ),
//                                 );
//                               }),
//                           const SizedBox(height: 20),
//                           _plansView(),
//                         ]),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
//                         child: RoundedButton(
//                             buttonName: 'Get Boom for ${formatPrice(selectedPlanAmount ?? 0)}',
//                             onPressed: () {
//                               locator<PaymentService>().setChosenPlan = PlanType.boom;
//                               NavigationService().navigateTo(PlansView.routeName);
//                             },
//                             buttonColor: Palette.primaryColor,
//                             textColor: Palette.black),
//                       )
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _plansView() {
//     return SingleChildScrollView(
//       child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//             SizedBox(
//               height: 150.0,
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                     height: 150.0,
//                     aspectRatio: 3 / 2,
//                     viewportFraction: 0.6,
//                     initialPage: 0,
//                     enableInfiniteScroll: false,
//                     enlargeCenterPage: true,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         selectedPlanIndex = index;
//                         if (selectedPlanIndex == 0) {
//                           selectedPlanAmount = boom12months?.amount;
//                         } else if (selectedPlanIndex == 1) {
//                           selectedPlanAmount = boom6month?.amount;
//                         } else if (selectedPlanIndex == 2) {
//                           selectedPlanAmount = boom3month?.amount;
//                         } else if (selectedPlanIndex == 3) {
//                           selectedPlanAmount = boom1month?.amount;
//                         } else if (selectedPlanIndex == 4) {
//                           selectedPlanAmount = boom1week?.amount;
//                         }
//                       });
//                     },
//                     scrollDirection: Axis.horizontal),
//                 items: [0,1,2,3,4].map((i) {
//                   return Builder(
//                     builder: (BuildContext context) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: _getPlan(i),
//                       );
//                     },
//                   );
//                 }).toList(),
//               ),
//             ),
//           ])),
//     );
//   }
//
//   Widget _getPlan(int index) {
//     if (index == 0) {
//       return Container(
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: selectedPlanIndex == 0 ? Palette.white : Colors.pinkAccent),
//         child: PlanTypeWidget(
//             bgColor: Colors.pinkAccent,
//             titleColor: Palette.white,
//             subtitleColor: Palette.white,
//             titleText:
//             "1 Year "
//                 "${boom12months?.discountPercent != null && boom12months?.discountPercent != 0
//                 ? '(save ${boom12months?.discountPercent}%)'
//                 : '@'} "
//                 "${formatPrice(boom12months?.amount ?? 0)}",
//         ),
//       );
//     } else if (index == 1) {
//       return Container(
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: selectedPlanIndex == 1 ? Palette.white : Colors.brown),
//         child: PlanTypeWidget(
//             bgColor: Colors.brown,
//             titleColor: Palette.white,
//             subtitleColor: Palette.white,
//             titleText:
//             "6 Months "
//                 "${boom6month?.discountPercent != null && boom6month?.discountPercent != 0
//                 ? '(save ${boom6month?.discountPercent}%)'
//                 : '@'} "
//                 "${formatPrice(boom6month?.amount ?? 0)}",
//         ),
//       );
//     } else if (index == 2) {
//       return Container(
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: selectedPlanIndex == 2 ? Palette.white : Colors.deepOrangeAccent),
//         child: PlanTypeWidget(
//             bgColor: Colors.deepOrangeAccent,
//             titleColor: Palette.white,
//             subtitleColor: Palette.white,
//             titleText:
//             "3 Months "
//                 "${boom3month?.discountPercent != null && boom3month?.discountPercent != 0
//                 ? '(save ${boom3month?.discountPercent}%)'
//                 : '@'} "
//                 "${formatPrice(boom3month?.amount ?? 0)}",
//         ),          );
//     }
//     else if (index == 3) {
//       return Container(
//         padding: const EdgeInsets.all(3),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             color: selectedPlanIndex == 3 ? Palette.white : Colors.orange),
//         child: PlanTypeWidget(
//             bgColor: Colors.orange,
//             titleColor: Palette.white,
//             subtitleColor: Palette.white,
//             titleText:
//             "1 Month "
//                 "${boom1month?.discountPercent != null && boom1month?.discountPercent != 0
//                 ? '(save ${boom1month?.discountPercent}%)'
//                 : '@'} "
//                 "${formatPrice(boom1month?.amount ?? 0)}",
//         ),          );
//     }
//
//     return Container(
//       padding: const EdgeInsets.all(3),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: selectedPlanIndex == 4 ? Palette.white : Colors.lime),
//       child: PlanTypeWidget(
//           bgColor: Colors.lime,
//           titleColor: Palette.white,
//           subtitleColor: Palette.white,
//           titleText:
//           "1 Week "
//               "${boom1week?.discountPercent != null && boom1week?.discountPercent != 0
//               ? '(save ${boom1week?.discountPercent}%)'
//               : '@'} "
//               "${formatPrice(boom1week?.amount ?? 0)}",
//       ),        );
//   }
//
//   void _featureInfoView(String? title, String? subtitle){
//     SuperTooltip tooltip = SuperTooltip(
//       popupDirection: TooltipDirection.up,
//       showCloseButton: ShowCloseButton.inside,
//       maxHeight: 200,
//       outsideBackgroundColor: Colors.black54,
//       content:  Material(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 title ?? '',
//                 softWrap: true,
//                 style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w400),
//               ),
//               const SizedBox(height: 15),
//               Text(
//                 subtitle ?? '',
//                  softWrap: true,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.w300),
//               ),
//             ],
//           )),
//     );
//
//     tooltip.show(context);
//   }
//
//   Future<void> _fetchAllPlans() async {
//     try {
//       isLoading = true;
//       setState(() {});
//       //get firebase auth token
//       IdTokenResult? tokenResult = await FirebaseAuth.instance.currentUser?.getIdTokenResult();
//       String? firebaseAuthToken =  tokenResult?.token;
//
//       var response = await http.get(
//           Uri.parse(Apis.baseUrl + Apis.fetchSubscriptionPlans),
//           headers: {'FirebaseAuthToken': firebaseAuthToken!});
//       print('statusCode::: ${response.statusCode}');
//       print('response::: ${response.body}');
//       //success
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         //plans
//         SubscriptionPlans? plans = SubscriptionPlans.fromJson(json.decode(response.body) as Map<String, dynamic>);
//
//         //BOOM
//         if (plans.boom1Week?.price != null && plans.boom1Week?.discount != null) {
//           boom1week = calculatePrice(amount: plans.boom1Week!.price!, discount: plans.boom1Week!.discount!);
//         }
//
//         if (plans.boom1Month?.price != null && plans.boom1Month?.discount != null) {
//           boom1month = calculatePrice(amount: plans.boom1Month!.price!, discount: plans.boom1Month!.discount!);
//         }
//
//         if (plans.boom3Months?.price != null && plans.boom3Months?.discount != null) {
//           boom3month = calculatePrice(amount: plans.boom3Months!.price!, discount: plans.boom3Months!.discount!);
//         }
//
//         if (plans.boom6Months?.price != null && plans.boom6Months?.discount != null) {
//           boom6month = calculatePrice(amount: plans.boom6Months!.price!, discount: plans.boom6Months!.discount!);
//         }
//
//         if (plans.boom12months?.price != null && plans.boom12months?.discount != null) {
//           boom12months = calculatePrice(amount: plans.boom12months!.price!, discount: plans.boom12months!.discount!);
//         }
//
//         selectedPlanAmount = boom12months?.amount;
//
//         isLoading = false;
//         errorType = null;
//         setState(() {});
//       }
//       //failure
//       else {
//         isLoading = false;
//         errorType = ErrorType.other_exception;
//         setState(() {});
//         print('error ${response.body}');
//       }
//     } on SocketException {
//       isLoading = false;
//       errorType = ErrorType.socket_exception;
//       setState(() {});
//
//     } on HttpException {
//       isLoading = false;
//       errorType = ErrorType.http_exception;
//       setState(() {});
//
//     } on FormatException {
//       isLoading = false;
//       errorType = ErrorType.format_exception;
//       setState(() {});
//     } catch (e) {
//       isLoading = false;
//       errorType = ErrorType.other_exception;
//       setState(() {});
//       print("Error received when subscription plans: ${e.toString()}");
//     }
//   }
//
//   PlanData calculatePrice({required int amount, required double discount}) {
//     return PlanData(
//         amount: amount.round(),
//         discountPercent: (discount * 100).round(),
//     );
//   }
//
//
// }
