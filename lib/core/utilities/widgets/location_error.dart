// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:megadey_mobile/core/enums/toast_type.dart';
// import 'package:stacked_services/stacked_services.dart';
// import 'package:permission_handler/permission_handler.dart' as permissionHandler;
//
// import '../../../app/locator.dart';
// import '../../../views/dashboard/dashboard_view.dart';
// import '../../../views/onboarding/onboarding_view.dart';
// import '../../constants/colors.dart';
// import '../../services/location_service.dart';
// import '../../services/utility_storage_service.dart';
// import '../functions/toast.dart';
//
// class LocationError extends StatelessWidget {
//   static const routeName = 'LocationError';
//   Location location = Location();
//   bool? _serviceEnabled;
//   PermissionStatus? _permissionGranted;
//   LocationData? _locationData;
//   final StorageService? _storageService = locator<StorageService>();
//   final NavigationService? _navigationService = locator<NavigationService>();
//   final LocationService _locationService = locator<LocationService>();
//
//   bool get isLoggedIn => _storageService!.getBool('isLoggedIn') ?? false;
//   bool get skipOnBoarding => _storageService!.getBool('isOnBoarding') ?? false;
//
//   int permissionDeniedCount = 0;
//
//   void navigateToView() {
//     Future.delayed(Duration(milliseconds: 210), () async {
//       if (!skipOnBoarding && !isLoggedIn) {
//         Future.delayed(Duration(milliseconds: 210),
//             () => _navigationService!.replaceWith(OnboardingView.routeName));
//       } else if (skipOnBoarding && !isLoggedIn) {
//         Future.delayed(
//             Duration(milliseconds: 210), () => _navigationService!.replaceWith(DashboardView.routeName));
//       } else if (skipOnBoarding && isLoggedIn) {
//         Future.delayed(
//             Duration(milliseconds: 210), () => _navigationService!.replaceWith(DashboardView.routeName));
//       } else {
//         Future.delayed(Duration(milliseconds: 210),
//             () => _navigationService!.replaceWith(OnboardingView.routeName));
//       }
//     });
//   }
//
//   Future<void> checkPermissions(BuildContext context) async {
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled!) {
//       _serviceEnabled = await location.requestService();
//       //when user has location service turned on
//       if (_serviceEnabled!) {
//         _permissionGranted = await location.hasPermission();
//         if (_permissionGranted == PermissionStatus.denied || _permissionGranted == PermissionStatus.deniedForever) {
//           _permissionGranted = await location.requestPermission();
//           //if permission is granted
//           if (_permissionGranted == PermissionStatus.granted) {
//             _locationData = await location.getLocation();
//             print('longitude: ${_locationData!.longitude}\n latitude: ${_locationData!.latitude}');
//             _locationService.setLongitude = _locationData!.longitude;
//             _locationService.setLatitude = _locationData!.latitude;
//             navigateToView();
//           } else {
//             permissionDeniedCount++;
//             //when permissions have been denied twice the user will have to manually enable it in app settings
//             if(permissionDeniedCount ==2){
//               showToast(context: context, message: 'You\'ll need to allow location usage permission in app settings to continue', messageType: ToastMessageType.info);
//               Future.delayed(Duration(seconds: 2),
//                       () =>  permissionHandler.openAppSettings());
//             }
//             return;
//           }
//         }
//         else if (_permissionGranted == PermissionStatus.granted) {
//           _locationData = await location.getLocation();
//           print('longitude: ${_locationData!.longitude}\n latitude: ${_locationData!.latitude}');
//           _locationService.setLongitude = _locationData!.longitude;
//           _locationService.setLatitude = _locationData!.latitude;
//           navigateToView();
//         }
//       } else {
//         return;
//       }
//     } else {
//       _permissionGranted = await location.hasPermission();
//       if (_permissionGranted == PermissionStatus.denied ||  _permissionGranted == PermissionStatus.deniedForever) {
//         _permissionGranted = await location.requestPermission();
//         //if permission is granted
//         if (_permissionGranted == PermissionStatus.granted) {
//           _locationData = await location.getLocation();
//           print('longitude: ${_locationData!.longitude}\n latitude: ${_locationData!.latitude}');
//           _locationService.setLongitude = _locationData!.longitude;
//           _locationService.setLatitude = _locationData!.latitude;
//           navigateToView();
//         } else {
//           permissionDeniedCount++;
//           //when permissions have been denied twice the user will have to manually enable it in app settings
//           if(permissionDeniedCount ==2){
//             showToast(context: context, message: 'You\'ll need to allow permission in app settings to continue', messageType: ToastMessageType.info);
//             Future.delayed(Duration(seconds: 2), () =>  permissionHandler.openAppSettings());
//           }
//           return;
//         }
//       }
//       else if (_permissionGranted == PermissionStatus.granted) {
//         _locationData = await location.getLocation();
//         print('longitude: ${_locationData!.longitude}\n latitude: ${_locationData!.latitude}');
//         _locationService.setLongitude = _locationData!.longitude;
//         _locationService.setLatitude = _locationData!.latitude;
//         navigateToView();
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           padding: const EdgeInsets.only(bottom: 30.0),
//           alignment: Alignment.center,
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(
//                   padding: const EdgeInsets.all(30.0),
//                   decoration:
//                       BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.1)),
//                   child: Icon(
//                     Icons.location_on_outlined,
//                     size: 30.0,
//                     color: Colors.grey,
//                   )),
//               const SizedBox(height: 60.0),
//               SizedBox(
//                 width: 200,
//                 child: const Text('Location needs to be enabled in order to use megadey',
//                     textAlign: TextAlign.center,
//                     style:
//                         TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400)),
//               ),
//               const SizedBox(height: 30.0),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: InkWell(
//                     onTap: () async {
//                       await checkPermissions(context);
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30.0), color: Colors.transparent),
//                       child: Text('ENABLE PERMISSION',
//                           style: TextStyle(
//                               color: Palette.primaryColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w900)),
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
