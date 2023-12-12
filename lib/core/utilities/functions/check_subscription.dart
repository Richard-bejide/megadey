// import 'dart:convert';
// import 'package:stacked_services/stacked_services.dart';
// import '../enums.dart';
// import '../widgets/subscribe_for_boom.dart';
//
// checkWhetherUserCanUseFeature({required PlanType? featurePlanType, required Function() callBackOnSuccess}) {
//   String? subscriptionPlan = getUserSubPlan();
//   if (getSubValue(getSubType(subscriptionPlan)) >= getSubValue(featurePlanType)) {
//      callBackOnSuccess();
//   } else {
//     if (featurePlanType == PlanType.wax) {
//       locator<NavigationService>().navigateTo(SubscribeForWaxView.routeName);
//     } else {
//       locator<NavigationService>().navigateTo(SubscribeForBoomView.routeName);
//     }
//   }
// }
//
// String? getUserSubPlan(){
//   var decodedData = jsonDecode('${locator<StorageService>().getString('profileDetails')}');
//   UserData? userData = UserData.fromJson(decodedData as Map<String, dynamic>);
//   return  userData.subscriptionPlan;
// }
//
//
// int getSubValue(PlanType? planType) {
//   if (planType == PlanType.boom) {
//     return 2;
//   } else if (planType == PlanType.wax) {
//     return 1;
//   } else {
//     return 0;
//   }
// }
//
// PlanType getSubType(String? planType) {
//   if (planType?.toLowerCase() == 'boom') {
//     return PlanType.boom;
//   } else if (planType?.toLowerCase() == 'wax') {
//     return PlanType.wax;
//   } else {
//     return PlanType.free;
//   }
// }
