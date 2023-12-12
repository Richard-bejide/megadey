// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:photo_view/photo_view.dart';
// import '../enums.dart';
// import 'loading_widget.dart';
// import 'package:path_provider/path_provider.dart';
//
// class Photoview extends StatefulWidget {
//   String? imageUrl;
//   PhotoType? photoType;
//
//   Photoview({Key? key, required this.imageUrl, required this.photoType}) : super(key: key);
//
//   @override
//   State<Photoview> createState() => _PhotoviewState();
// }
//
// class _PhotoviewState extends State<Photoview> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Stack(
//         children: [
//           Container(
//               color: Palette.black,
//               child: Center(
//                 child: CachedNetworkImage(
//                   placeholder: (context, url) => const Center(
//                       child: SizedBox(
//                           height: 50,
//                           width: 50,
//                           child: CircularProgressIndicator(color: Palette.white))),
//                   errorWidget: (context, url, error) =>
//                       const Icon(Icons.add_a_photo_outlined, size: 60.0, color: Palette.white),
//                   fit: BoxFit.cover,
//                   imageUrl: widget.imageUrl ?? '',
//                   imageBuilder: (context, imageProvider) {
//                     return PhotoView(
//                       imageProvider: imageProvider,
//                     );
//                   },
//                 ),
//               )),
//           Positioned(
//               top: 20.0,
//               left: 10.0,
//               child: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     color: Palette.white,
//                     size: 24.0,
//                   ))),
//           Positioned(
//               bottom: 20.0,
//               right: 0.0,
//               left: 0.0,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 120.0),
//                 child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                   InkWell(
//                     onTap: () {
//                       _editView(context);
//                     },
//                     child: Container(
//                         padding: const EdgeInsets.all(5.0),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(2.0),
//                           border: Border.all(width: 1, color: Palette.white),
//                         ),
//                         child: const Icon(Icons.edit, size: 20, color: Palette.white)),
//                   ),
//                   const SizedBox(width: 10),
//                   //don't delete profile photo
//                   (widget.photoType != PhotoType.profile_photo && widget.imageUrl != null)
//                       ? InkWell(
//                           onTap: () {
//                             _deleteView(context);
//                           },
//                           child: Container(
//                               padding: const EdgeInsets.all(5.0),
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(2.0),
//                                 border: Border.all(width: 1, color: Palette.white),
//                               ),
//                               child: isDeletingPhoto
//                                   ? const SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: CircularProgressIndicator(
//                                           color: Palette.white, strokeWidth: 2))
//                                   : const Icon(Icons.delete, size: 20, color: Palette.white)),
//                         )
//                       : const SizedBox(),
//                 ]),
//               ))
//         ],
//       ),
//     ));
//   }
//
//   //edit photo
//   Future _editView(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               backgroundColor: Colors.black38,
//               contentTextStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
//               elevation: 1.0,
//               titlePadding: const EdgeInsets.only(right: 12.0, top: 8.0),
//               content: SizedBox(
//                 height:size.height * 0.30,
//                 width: size.width * 0.2,
//                 child: isDownloadingSocialPhoto
//                     ? LoadingWidget(iconColor: Palette.primaryColor, size: 30)
//                     : Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           InkWell(
//                             onTap: () async {
//                               await [Permission.photos].request();
//                               final pickedImage = await ImagePicker()
//                                   .pickImage(source: ImageSource.camera, imageQuality: 70);
//                               if (pickedImage != null) {
//                                 print('image path $pickedImage');
//                                 if (widget.photoType == PhotoType.profile_photo) {
//                                   //crop and update profile photo
//                                   Navigator.push(context, MaterialPageRoute(builder: (_) {
//                                     return ImageCrop(
//                                         path: pickedImage.path,
//                                         context: context,
//                                         photoType: PhotoType.profile_photo);
//                                   }));
//                                 } else if (widget.photoType == PhotoType.add_other_gallery_photo) {
//                                   //crop and upload new gallery photo
//                                   Navigator.push(context, MaterialPageRoute(builder: (_) {
//                                     return ImageCrop(
//                                         path: pickedImage.path,
//                                         context: context,
//                                         photoType: PhotoType.add_other_gallery_photo);
//                                   }));
//                                 } else if (widget.photoType ==
//                                     PhotoType.replace_other_gallery_photo) {
//                                   //crop and update existing gallery photo
//                                   Navigator.push(context, MaterialPageRoute(builder: (_) {
//                                     return ImageCrop(
//                                         path: pickedImage.path,
//                                         context: context,
//                                         photoType: PhotoType.replace_other_gallery_photo,
//                                         formerImageUrl: widget.imageUrl);
//                                   }));
//                                 }
//                               }
//                             },
//                             child: Container(
//                                 padding: const EdgeInsets.all(5.0),
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15.0),
//                                   border: Border.all(width: 1, color: Palette.white),
//                                 ),
//                                 child: const Text(
//                                   'Take Photo',
//                                   style: TextStyle(
//                                       fontFamily: 'sk-modernist',
//                                       color: Colors.white,
//                                       fontSize: 17.0,
//                                       fontWeight: FontWeight.w500),
//                                 )),
//                           ),
//                           const SizedBox(height: 20.0),
//                           InkWell(
//                               onTap: () async {
//                                 await [Permission.photos].request();
//                                 final pickedImage = await ImagePicker()
//                                     .pickImage(source: ImageSource.gallery, imageQuality: 70);
//                                 if (pickedImage != null) {
//                                   print('image path $pickedImage');
//                                   if (widget.photoType == PhotoType.profile_photo) {
//                                     //crop and update profile photo
//                                     Navigator.push(context, MaterialPageRoute(builder: (_) {
//                                       return ImageCrop(
//                                           path: pickedImage.path,
//                                           context: context,
//                                           photoType: PhotoType.profile_photo);
//                                     }));
//                                   } else if (widget.photoType ==
//                                       PhotoType.add_other_gallery_photo) {
//                                     //crop and upload new gallery photo
//                                     Navigator.push(context, MaterialPageRoute(builder: (_) {
//                                       return ImageCrop(
//                                           path: pickedImage.path,
//                                           context: context,
//                                           photoType: PhotoType.add_other_gallery_photo);
//                                     }));
//                                   } else if (widget.photoType ==
//                                       PhotoType.replace_other_gallery_photo) {
//                                     //crop and update existing gallery photo
//                                     Navigator.push(context, MaterialPageRoute(builder: (_) {
//                                       return ImageCrop(
//                                           path: pickedImage.path,
//                                           context: context,
//                                           photoType: PhotoType.replace_other_gallery_photo,
//                                           formerImageUrl: widget.imageUrl);
//                                     }));
//                                   }
//                                 }
//                               },
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.all(5.0),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                     border: Border.all(width: 1, color: Palette.white),
//                                   ),
//                                   child: const Text(
//                                     'Choose Existing Photo',
//                                     style: TextStyle(
//                                         fontFamily: 'sk-modernist',
//                                         color: Colors.white,
//                                         fontSize: 17.0,
//                                         fontWeight: FontWeight.w500),
//                                   ))),
//                           const SizedBox(height: 20.0),
//                           InkWell(
//                               onTap: () async {
//                                 pickUserPhotosFromFacebook(context);
//                               },
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.all(5.0),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                     border: Border.all(width: 1, color: Palette.white),
//                                   ),
//                                   child: const Text(
//                                     'From Facebook',
//                                     style: TextStyle(
//                                         fontFamily: 'sk-modernist',
//                                         color: Colors.white,
//                                         fontSize: 17.0,
//                                         fontWeight: FontWeight.w500),
//                                   ))),
//                           const SizedBox(height: 20.0),
//                           InkWell(
//                               onTap: () async {
//                                 pickUserPhotosFromInstagram(context);
//                               },
//                               child: Container(
//                                   alignment: Alignment.center,
//                                   padding: const EdgeInsets.all(5.0),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                     border: Border.all(width: 1, color: Palette.white),
//                                   ),
//                                   child: const Text(
//                                     'From Instagram',
//                                     style: TextStyle(
//                                         fontFamily: 'sk-modernist',
//                                         color: Colors.white,
//                                         fontSize: 17.0,
//                                         fontWeight: FontWeight.w500),
//                                   ))),
//                         ],
//                       ),
//               ));
//         });
//   }
//
//   Future _deleteView(BuildContext context1) {
//     final Size _size = MediaQuery.of(context).size;
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               backgroundColor: Colors.black38,
//               contentTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0),
//               elevation: 1.0,
//               titlePadding: const EdgeInsets.only(right: 12.0, top: 8.0),
//               content: Container(
//                 height: _size.height * 0.2,
//                 width: _size.width * 0.2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Delete Photo?',
//                       style: TextStyle(
//                           fontFamily: 'sk-modernist',
//                           color: Colors.white,
//                           fontSize: 17.0,
//                           fontWeight: FontWeight.w700),
//                     ),
//                     const SizedBox(height: 20.0),
//                     InkWell(
//                         onTap: () async {
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.all(5.0),
//                             decoration: BoxDecoration(
//                               color: Palette.white,
//                               borderRadius: BorderRadius.circular(15.0),
//                               border: Border.all(width: 1, color: Palette.white),
//                             ),
//                             child: const Text(
//                               'No',
//                               style: TextStyle(
//                                   fontFamily: 'sk-modernist',
//                                   color: Colors.black,
//                                   fontSize: 17.0,
//                                   fontWeight: FontWeight.w500),
//                             ))),
//                     const SizedBox(height: 20.0),
//                     InkWell(
//                         onTap: () async {
//                           Navigator.pop(context);
//                           _deletePhoto(url: widget.imageUrl ?? '', context: context1);
//                         },
//                         child: Container(
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.all(5.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                               border: Border.all(width: 1, color: Palette.white),
//                             ),
//                             child: const Text(
//                               'Yes',
//                               style: TextStyle(
//                                   fontFamily: 'sk-modernist',
//                                   color: Colors.white,
//                                   fontSize: 17.0,
//                                   fontWeight: FontWeight.w500),
//                             ))),
//                   ],
//                 ),
//               ));
//         });
//   }
//
//   //delete photo
//   bool isDeletingPhoto = false;
//
//   Future<void> _deletePhoto({required String url, required BuildContext context}) async {
//     try {
//       isDeletingPhoto = true;
//       setState(() {});
//       //get firebase auth token
//       IdTokenResult? tokenResult = await FirebaseAuth.instance.currentUser?.getIdTokenResult();
//       String? firebaseAuthToken = await tokenResult?.token;
//
//       var response = await http.delete(Uri.parse(Apis.baseUrl + Apis.delete_photo), headers: {
//         "FirebaseAuthToken": firebaseAuthToken!,
//         "Accept": "application/json",
//       }, body: {
//         "image_url": url
//       });
//
//       print('statusCode::: ${response.statusCode}');
//       print('response::: ${response.body}');
//
//       //success
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print('gallery photo has been deleted successfully::: ');
//         Login temp = Login.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//         locator<StorageService>()
//             .addString('profileDetails', jsonEncode(temp.user)); //update saved local data
//         locator<ProfileDetailsService>().clearProfileData();
//         locator<ProfileDetailsService>().setProfileDetails = temp.user; //notify all listeners
//         isDeletingPhoto = false;
//         setState(() {});
//         Navigator.pop(context);
//         showToast(
//             context: context,
//             message: 'Your photo has been deleted successfully',
//             iconType: IconType.success);
//       }
//       //failure
//       else {
//         isDeletingPhoto = false;
//         setState(() {});
//
//         showToast(
//             context: context,
//             message: 'An unexpected error has occurred, try again later',
//             iconType: IconType.error);
//         print('error ${response.body}');
//       }
//     } on SocketException {
//       isDeletingPhoto = false;
//       setState(() {});
//       showToast(
//           context: context,
//           message: 'You\'re not connected to the internet',
//           iconType: IconType.error);
//     } on HttpException {
//       isDeletingPhoto = false;
//       setState(() {});
//
//       showToast(context: context, message: 'Couldn\'t find the resource', iconType: IconType.error);
//     } on FormatException {
//       isDeletingPhoto = false;
//       setState(() {});
//
//       showToast(context: context, message: 'Bad response format', iconType: IconType.error);
//     } catch (e) {
//       isDeletingPhoto = false;
//       setState(() {});
//       showToast(
//           context: context,
//           message: 'An unexpected error has occurred, try again later',
//           iconType: IconType.error);
//       print("Error received when deleting user's gallery photo: ${e.toString()}");
//     }
//   }
//
//   final Dio _dio = Dio();
//   bool isDownloadingSocialPhoto = false;
//
//   Future<void> pickUserPhotosFromFacebook(BuildContext context) async {
//     // final FacebookLoginResult result =
//     //     await FacebookLogin().logIn(permissions: [FacebookPermission.userPhotos]);
//     // String? _accessToken;
//     // switch (result.status) {
//     //   case FacebookLoginStatus.success:
//     //     final FacebookAccessToken? accessToken = result.accessToken;
//     //     _accessToken = accessToken?.token;
//     //     Navigator.of(context).push(
//     //       MaterialPageRoute(
//     //         builder: (_) => FacebookImagePicker(
//     //           _accessToken!,
//     //           onDone: (items) async {
//     //             Navigator.pop(context);
//     //             if (items != null) {
//     //              onFacebookImagesPicked(items,context);
//     //             }
//     //           },
//     //           onCancel: () => Navigator.pop(context),
//     //         ),
//     //       ),
//     //     );
//     //     return;
//     //   case FacebookLoginStatus.cancel:
//     //     showToast(
//     //         context: context, message: 'Login cancelled by the user.', iconType: IconType.error);
//     //     return;
//     //   case FacebookLoginStatus.error:
//     //     showToast(context: context, message: '${result.error}', iconType: IconType.error);
//     //     return;
//     // }
//   }
//
// //called when photos have been picked from facebook
// //   Future<void> onFacebookImagesPicked(List<FacebookPhoto.Photo> photos,BuildContext context) async {
// //     try {
// //       var status = await Permission.storage.request();
// //       if (status == PermissionStatus.granted) {
// //         isDownloadingSocialPhoto = true;
// //         setState(() {});
// //         final Directory? directory = await getExternalStorageDirectory();
// //         Directory _facebookPhotosDirectory =
// //             await Directory(directory!.path + '/FacebookPhotos/').create();
// //
// //         //for (int i = 0; i < items.length; i++) {
// //         String fbPhoto = "${_facebookPhotosDirectory.path}${DateTime.now().toString().split(" ").join("")}.jpg";
// //         //download the facebook photo
// //         await _dio.download(photos[0].source!, fbPhoto).then((value) {
// //           debugPrint('downloaded facebook image path is: $fbPhoto');
// //           isDownloadingSocialPhoto = false;
// //           setState(() {});
// //            //download the first photo only
// //           if (widget.photoType == PhotoType.profile_photo) {
// //             //crop and update profile photo
// //             Navigator.push(context, MaterialPageRoute(builder: (_) {
// //               return ImageCrop(
// //                   path: fbPhoto,
// //                   context: context,
// //                   photoType: PhotoType.profile_photo);
// //             }));
// //           } else if (widget.photoType ==
// //               PhotoType.add_other_gallery_photo) {
// //             //crop and upload new gallery photo
// //             Navigator.push(context, MaterialPageRoute(builder: (_) {
// //               return ImageCrop(
// //                   path: fbPhoto,
// //                   context: context,
// //                   photoType: PhotoType.add_other_gallery_photo);
// //             }));
// //           } else if (widget.photoType ==
// //               PhotoType.replace_other_gallery_photo) {
// //             //crop and update existing gallery photo
// //             Navigator.push(context, MaterialPageRoute(builder: (_) {
// //               return ImageCrop(
// //                   path: fbPhoto,
// //                   context: context,
// //                   photoType: PhotoType.replace_other_gallery_photo,
// //                   formerImageUrl: widget.imageUrl);
// //             }));
// //           }
// //           return;
// //         });
// //         // }
// //       } else {
// //         showToast(
// //             context: context,
// //             message: 'Permission to save photos was denied',
// //             iconType: IconType.info);
// //         return;
// //       }
// //     } catch (e) {
// //       isDownloadingSocialPhoto = false;
// //       setState(() {});
// //       showToast(
// //           context: context,
// //           message: 'An unexpected error has occurred!, please try again later',
// //           iconType: IconType.error);
// //       print('error received when getting facebook images: ${e.toString()}');
// //       return;
// //     }
// //     return;
// //   }
//
//   Future<void> pickUserPhotosFromInstagram(BuildContext context) async {
//     bool isLogged = await InstagramAuth().isLogged;
//     // check if user already logged in, if not log the user
//     if (!isLogged) {
//       bool loginStatus = await InstagramAuth().signUserIn(context);
//       // if user canceled the operation
//       if (!loginStatus)
//         showToast(context: context, message: 'Login failed!!', iconType: IconType.error);
//       return;
//     }
//     //login successful
//     else {
//       final accessMapData = await InstagramAuth().accessData;
//       if (accessMapData == null) {
//         return;
//       }
//       //user has data
//       else {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => InstagramImagePicker(
//               accessMapData,
//               showLogoutButton: true,
//               onDone: (photos) async {
//                 Navigator.pop(context);
//                 onInstagramImagesPicked(photos, context);
//               },
//               onCancel: () {
//                 Navigator.pop(context);
//                 showToast(context: context, message: 'Cancelled!!', iconType: IconType.error);
//               },
//             ),
//           ),
//         );
//       }
//     }
//     return;
//   }
//
// //called when photos have been picked from instagram
//   Future<void> onInstagramImagesPicked(List photos,BuildContext context) async {
//     try {
//       var status = await Permission.storage.request();
//       if (status == PermissionStatus.granted) {
//         isDownloadingSocialPhoto = true;
//         setState(() {});
//         final Directory? directory = await getExternalStorageDirectory();
//         Directory _instagramPhotosDirectory =
//             await Directory(directory!.path + '/InstagramPhotos/').create();
//
//         //for (int i = 0; i < items.length; i++) {
//           String instaPhoto =
//               "${_instagramPhotosDirectory.path}${DateTime.now().toString().split(" ").join("")}.jpg";
//           //download the first photo only
//           await _dio.download(photos[0].url, instaPhoto).then((value) {
//             isDownloadingSocialPhoto = false;
//             setState(() {});
//             if (widget.photoType == PhotoType.profile_photo) {
//               //crop and update profile photo
//               Navigator.push(context, MaterialPageRoute(builder: (_) {
//                 return ImageCrop(
//                     path: instaPhoto,
//                     context: context,
//                     photoType: PhotoType.profile_photo);
//               }));
//             } else if (widget.photoType ==
//                 PhotoType.add_other_gallery_photo) {
//               //crop and upload new gallery photo
//               Navigator.push(context, MaterialPageRoute(builder: (_) {
//                 return ImageCrop(
//                     path: instaPhoto,
//                     context: context,
//                     photoType: PhotoType.add_other_gallery_photo);
//               }));
//             } else if (widget.photoType ==
//                 PhotoType.replace_other_gallery_photo) {
//               //crop and update existing gallery photo
//               Navigator.push(context, MaterialPageRoute(builder: (_) {
//                 return ImageCrop(
//                     path: instaPhoto,
//                     context: context,
//                     photoType: PhotoType.replace_other_gallery_photo,
//                     formerImageUrl: widget.imageUrl);
//               }));
//             }
//             return;
//           });
//        // }
//       } else {
//         showToast(
//             context: context,
//             message: 'Permission to save photos was denied',
//             iconType: IconType.info);
//         return;
//       }
//     } catch (e) {
//       isDownloadingSocialPhoto = false;
//       setState(() {});
//       showToast(
//           context: context,
//           message: 'An unexpected error has occurred!, please try again later',
//           iconType: IconType.error);
//       print('error received when getting instagram images: ${e.toString()}');
//       return;
//     }
//     return;
//   }
// }
//
// class ImageCrop extends StatefulWidget {
//   final String path;
//   final BuildContext context;
//   final PhotoType photoType;
//   final formerImageUrl; //to replace former image url when an existing gallery is tapped
//
//   const ImageCrop(
//       {Key? key,
//       required this.path,
//       required this.context,
//       required this.photoType,
//       this.formerImageUrl})
//       : super(key: key);
//
//   @override
//   State<ImageCrop> createState() => _ImageCropState();
// }
//
// class _ImageCropState extends State<ImageCrop> {
//   // CroppedFile? _croppedFile;
//   // void _initCropper() async {
//   //   _croppedFile = await ImageCropper().cropImage(
//   //     sourcePath: widget.path,
//   //     compressFormat: ImageCompressFormat.jpg,
//   //     compressQuality: 90,
//   //     aspectRatioPresets: [
//   //       CropAspectRatioPreset.square,
//   //       CropAspectRatioPreset.ratio3x2,
//   //       CropAspectRatioPreset.original,
//   //       CropAspectRatioPreset.ratio4x3,
//   //       CropAspectRatioPreset.ratio16x9
//   //     ],
//   //     uiSettings: [
//   //       AndroidUiSettings(
//   //           toolbarTitle: '',
//   //           toolbarColor: Palette.black,
//   //           toolbarWidgetColor: Colors.white,
//   //           initAspectRatio: CropAspectRatioPreset.original,
//   //           lockAspectRatio: false),
//   //       IOSUiSettings(
//   //         title: '',
//   //       ),
//   //     ],
//   //   );
//   //
//   //   if (_croppedFile != null) {
//   //     setState(() {
//   //       _croppedFile = _croppedFile;
//   //     });
//   //   }
//   // }
//   CroppedFile? cropImg;
//
//    void initImageCrop() async{
//     cropImg = await ImageCropper().cropImage(
//        sourcePath: widget.path,
//        aspectRatioPresets: [CropAspectRatioPreset.square],
//        uiSettings: [
//          AndroidUiSettings(
//              toolbarTitle: 'Edit image',
//              toolbarColor: Palette.primaryColor,
//              toolbarWidgetColor: Colors.white,
//              initAspectRatio: CropAspectRatioPreset.original,
//              lockAspectRatio: false),
//          IOSUiSettings(
//            title: 'Edit image',
//          ),
//          WebUiSettings(
//            context: context,
//          ),
//        ],
//      );
//     setState(() {});
//    }
//
//   @override
//   void initState() {
//   //  _initCropper();
//     initImageCrop();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final Size _size = MediaQuery.of(context).size;
//     return LoadingOverlay(
//         isLoading: isLoading,
//         color: Palette.primaryColor.withOpacity(0.5),
//         progressIndicator: LoadingWidget(iconColor: Palette.primaryColor, size: 70),
//         child: Scaffold(
//             backgroundColor: Palette.black,
//             appBar: AppBar(
//               backgroundColor: Palette.black,
//               leading: IconButton(
//                 icon: Icon(Icons.arrow_back_ios, color: Palette.white, size: 20.0),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 15.0),
//                   child: Center(
//                     child: InkWell(
//                         onTap: () {
//                           if (cropImg != null) {
//                             if (widget.photoType == PhotoType.profile_photo) {
//                               _updateProfilePhoto(path: cropImg!.path, context: context);
//                             } else if (widget.photoType == PhotoType.add_other_gallery_photo) {
//                               _uploadNewGalleryPhoto(path: cropImg!.path, context: context);
//                             } else if (widget.photoType == PhotoType.replace_other_gallery_photo) {
//                               _changeExistingGalleryPhoto(
//                                   path: cropImg!.path, context: context);
//                             }
//                           }
//                         },
//                         child: const Text('Done',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 color: Palette.white,
//                                 fontSize: 20.0,
//                                 letterSpacing: 1.0))),
//                   ),
//                 ),
//               ],
//             ),
//             body: SizedBox(
//                 height: _size.height,
//                 width: _size.width,
//                 child: cropImg != null ? Image.file(File(cropImg!.path)) : Container())));
//   }
//
//   bool isLoading = false;
//
//   Future<void> _updateProfilePhoto({required String path, required BuildContext context}) async {
//     try {
//       isLoading = true;
//       setState(() {});
//       //get firebase auth token
//       IdTokenResult? tokenResult = await FirebaseAuth.instance.currentUser?.getIdTokenResult();
//       String? firebaseAuthToken = await tokenResult?.token;
//
//       var request = http.MultipartRequest('PUT', Uri.parse(Apis.baseUrl + Apis.edit_profile_photo));
//
//       //header
//       request.headers.addAll({
//         'FirebaseAuthToken': firebaseAuthToken ?? '',
//         "Content-Type": 'multipart/form-data',
//         "Accept": 'application/json'
//       });
//
//       //add image
//       request.files.add(await http.MultipartFile.fromPath('image', path,
//           contentType: MediaType('image', path.split(".").last), filename: path.split('/').last));
//
//       http.StreamedResponse streamedResponse = await request.send();
//       http.Response response = await http.Response.fromStream(streamedResponse);
//
//       print('statusCode::: ${response.statusCode}');
//       print('response::: ${response.body}');
//       //success
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print('profile photo has been updated successfully::: ');
//           Login temp = Login.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//           locator<StorageService>()
//               .addString('profileDetails', jsonEncode(temp.user)); //update saved local data
//           locator<ProfileDetailsService>().setProfileDetails = temp.user; //notify all listeners
//         isLoading = false;
//         setState(() {});
//         Navigator.pop(context);
//         Navigator.pop(context);
//         Navigator.pop(context);
//         showToast(
//             context: context,
//             message: 'Profile photo has been updated successfully',
//             iconType: IconType.success);
//       }
//       //failure
//       else {
//         isLoading = false;
//         setState(() {});
//
//         showToast(
//             context: context,
//             message: 'An unexpected error has occurred, try again later',
//             iconType: IconType.error);
//         print('error ${response.body}');
//       }
//     } on SocketException {
//       isLoading = false;
//       setState(() {});
//       showToast(
//           context: context,
//           message: 'You\'re not connected to the internet',
//           iconType: IconType.error);
//     } on HttpException {
//       isLoading = false;
//       setState(() {});
//
//       showToast(context: context, message: 'Couldn\'t find the resource', iconType: IconType.error);
//     } on FormatException {
//       isLoading = false;
//       setState(() {});
//
//       showToast(context: context, message: 'Bad response format', iconType: IconType.error);
//     } catch (e) {
//       isLoading = false;
//       setState(() {});
//       showToast(
//           context: context,
//           message: 'An unexpected error has occurred, try again later',
//           iconType: IconType.error);
//       print("Error received when updating user profile photo: ${e.toString()}");
//     }
//   }
//
//   Future<void> _uploadNewGalleryPhoto({required String path, required BuildContext context}) async {
//     try {
//       isLoading = true;
//       setState(() {});
//       //get firebase auth token
//       IdTokenResult? tokenResult = await FirebaseAuth.instance.currentUser?.getIdTokenResult();
//       String? firebaseAuthToken = await tokenResult?.token;
//
//       var request = http.MultipartRequest('POST', Uri.parse(Apis.baseUrl + Apis.add_other_photo));
//
//       //header
//       request.headers.addAll({
//         'FirebaseAuthToken': firebaseAuthToken ?? '',
//         "Content-Type": 'multipart/form-data',
//         "Accept": 'application/json'
//       });
//
//       //add image
//       request.files.add(await http.MultipartFile.fromPath('image', path,
//           contentType: MediaType('image', path.split(".").last), filename: path.split('/').last));
//
//       http.StreamedResponse streamedResponse = await request.send();
//       http.Response response = await http.Response.fromStream(streamedResponse);
//
//       print('statusCode::: ${response.statusCode}');
//       print('response::: ${response.body}');
//       //success
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print('gallery photo has been updated successfully::: ');
//
//           Login temp = Login.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//           locator<StorageService>()
//               .addString('profileDetails', jsonEncode(temp.user)); //update saved local data
//           locator<ProfileDetailsService>().setProfileDetails = temp.user; //notify all listeners
//         isLoading = false;
//         setState(() {});
//         Navigator.pop(context);
//         Navigator.pop(context);
//         Navigator.pop(context);
//         showToast(
//             context: context,
//             message: 'Photo has been uploaded successfully',
//             iconType: IconType.success);
//       }
//       //failure
//       else {
//         isLoading = false;
//         setState(() {});
//
//         showToast(
//             context: context,
//             message: 'An unexpected error has occurred, try again later',
//             iconType: IconType.error);
//         print('error ${response.body}');
//       }
//     } on SocketException {
//       isLoading = false;
//       setState(() {});
//       showToast(
//           context: context,
//           message: 'You\'re not connected to the internet',
//           iconType: IconType.error);
//     } on HttpException {
//       isLoading = false;
//       setState(() {});
//
//       showToast(context: context, message: 'Couldn\'t find the resource', iconType: IconType.error);
//     } on FormatException {
//       isLoading = false;
//       setState(() {});
//
//       showToast(context: context, message: 'Bad response format', iconType: IconType.error);
//     } catch (e) {
//       isLoading = false;
//       setState(() {});
//       showToast(
//           context: context,
//           message: 'An unexpected error has occurred, try again later',
//           iconType: IconType.error);
//       print("Error received when updating user's gallery photo: ${e.toString()}");
//     }
//   }
//
//   Future<void> _changeExistingGalleryPhoto(
//       {required String path, required BuildContext context}) async {
//     try {
//       isLoading = true;
//       setState(() {});
//       //get firebase auth token
//       IdTokenResult? tokenResult = await FirebaseAuth.instance.currentUser?.getIdTokenResult();
//       String? firebaseAuthToken = await tokenResult?.token;
//
//       var request =
//           http.MultipartRequest('PUT', Uri.parse(Apis.baseUrl + Apis.replace_other_photo));
//
//       //header
//       request.headers.addAll({
//         'FirebaseAuthToken': firebaseAuthToken ?? '',
//         "Content-Type": 'multipart/form-data',
//         "Accept": 'application/json'
//       });
//
//       //field to replace image
//       request.fields['image_url'] = widget.formerImageUrl!;
//
//       //add image
//       request.files.add(await http.MultipartFile.fromPath('new_image', path,
//           contentType: MediaType('image', path.split(".").last), filename: path.split('/').last));
//
//       http.StreamedResponse streamedResponse = await request.send();
//       http.Response response = await http.Response.fromStream(streamedResponse);
//
//       print('statusCode::: ${response.statusCode}');
//       print('response::: ${response.body}');
//       //success
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print('gallery photo has been updated successfully::: ');
//
//           Login temp = Login.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//           locator<StorageService>()
//               .addString('profileDetails', jsonEncode(temp.user)); //update saved local data
//           locator<ProfileDetailsService>().setProfileDetails = temp.user; //notify all listeners
//
//         isLoading = false;
//         setState(() {});
//         Navigator.pop(context);
//         Navigator.pop(context);
//         Navigator.pop(context);
//         showToast(
//             context: context,
//             message: 'Photo has been changed successfully',
//             iconType: IconType.success);
//       }
//       //failure
//       else {
//         isLoading = false;
//         setState(() {});
//
//         showToast(
//             context: context,
//             message: 'An unexpected error has occurred, try again later',
//             iconType: IconType.error);
//         print('error ${response.body}');
//       }
//     } on SocketException {
//       isLoading = false;
//       setState(() {});
//       showToast(
//           context: context,
//           message: 'You\'re not connected to the internet',
//           iconType: IconType.error);
//     } on HttpException {
//       isLoading = false;
//       setState(() {});
//
//       showToast(context: context, message: 'Couldn\'t find the resource', iconType: IconType.error);
//     } on FormatException {
//       isLoading = false;
//       setState(() {});
//
//       showToast(context: context, message: 'Bad response format', iconType: IconType.error);
//     } catch (e) {
//       isLoading = false;
//       setState(() {});
//       showToast(
//           context: context,
//           message: 'An unexpected error has occurred, try again later',
//           iconType: IconType.error);
//       print("Error received when updating user's gallery photo: ${e.toString()}");
//     }
//   }
// }
