import 'dart:convert';
import 'dart:io';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:megadey_mobile/core/enums/toast_type.dart';
import 'package:megadey_mobile/core/utilities/functions/toast.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:the_apple_sign_in/apple_id_request.dart';
import 'package:the_apple_sign_in/scope.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart' as apple;
import '../../../api/apis.dart';
import '../../../app/locator.dart';
import '../../../views/dashboard/dashboard_view.dart';
import '../../models/profile_model.dart';
import '../../services/profile_service.dart';
import '../../services/signup_service.dart';
import '../../services/utility_storage_service.dart';
import '../../services/video_player_service.dart';
import 'debug_print.dart';
import 'fcm_token_generator.dart';
import 'dart:developer' as dev;

class FirebaseAuthMethods {
  final FirebaseAuth _auth;

  FirebaseAuthMethods(this._auth);

  Future<void> signupWithGoogle({required BuildContext context}) async {
    try {
      locator<SignupService>().setLoadingIndicatorForGoogle = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        //create a new credential
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

        UserCredential userCredential = await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
            bool accountCreated = await createAccount(Apis.registerWithGoogle);
            if (accountCreated) {
              //_saveUserProfileDetails();
              locator<SignupService>().setLoadingIndicatorForGoogle = false;
              locator<NavigationService>().clearStackAndShow(DashboardView.routeName); //move to dashboard
            }
            else {
              //error occurred
              //await GoogleSignIn().disconnect();
              locator<SignupService>().setLoadingIndicatorForGoogle = false;
              showToast(
                  context: context,
                  message: 'An unexpected error has occurred, please try again later',
                  messageType: ToastMessageType.error);
            }
        } else {
          locator<SignupService>().setLoadingIndicatorForGoogle = false;
          showToast(
              context: context,
              message: 'Google sign in failed!',
              messageType: ToastMessageType.error);

        }
      } else {
        //await GoogleSignIn().disconnect();
        locator<SignupService>().setLoadingIndicatorForGoogle = false;
        showToast(
            message: 'An unexpected error has occurred, please try again later',
            context: context,
            messageType: ToastMessageType.error);
      }
    } on SocketException {
    //  await GoogleSignIn().disconnect();
      locator<SignupService>().setLoadingIndicatorForGoogle = false;
      showToast(
          message: 'You\'re not connected to the Internet',
          context: context,
          messageType: ToastMessageType.error);
    } catch (e) {
      //await GoogleSignIn().disconnect();
      locator<SignupService>().setLoadingIndicatorForGoogle = false;
      showToast(
          message: 'An unexpected error has occurred, please try again later',
          context: context,
          messageType: ToastMessageType.error);
      print("Error received on google sign-in:  ${e.toString()}");
    }
  }

  Future<void> signupWithApple({required BuildContext context,List<Scope> scopes = const []}) async {
    // try {
    //   locator<SignupService>().setLoadingIndicatorForApple = true;
    //   final result = await TheAppleSignIn.performRequests([  AppleIdRequest(requestedScopes: scopes )]);
    //   if (result.status == apple.AuthorizationStatus.authorized) {
    //     final appleIdCredential = result.credential;
    //     final oAuthProvider = OAuthProvider('apple.com');
    //     final credential = oAuthProvider.credential(idToken: String.fromCharCodes(appleIdCredential!.identityToken!), accessToken: String.fromCharCodes(appleIdCredential.authorizationCode!));
    //
    //     final userCredential = await _auth.signInWithCredential(credential);
    //     final firebaseUser = userCredential.user;
    //
    //     if (scopes.contains(Scope.fullName)) {
    //       final fullName = appleIdCredential.fullName;
    //       if (fullName != null && fullName.givenName != null && fullName.familyName != null) {
    //         final displayName = '${fullName.givenName} ${fullName.familyName}';
    //         await firebaseUser?.updateDisplayName(displayName);
    //         await firebaseUser?.reload();
    //       }
    //     }
    //     if (firebaseUser != null) {
    //       if (userCredential.additionalUserInfo!.isNewUser) {
    //         //new user
    //         locator<SignupService>().setLoadingIndicatorForApple = false;
    //         locator<VideoPlayerService>().videoPlayerController!.dispose(); //stop video
    //
    //         //ProfileDetailsPageViewModel.firstNameController.text = firebaseUser.displayName?.split(' ')[0] ?? '';
    //         //ProfileDetailsPageViewModel.lastNameController.text = firebaseUser.displayName?.split(' ')[1] ?? '';
    //
    //         //locator<NavigationService>().clearStackAndShow(ProfileDetailsPage.routeName); //move to profile page
    //       }
    //       else {
    //         //existing user
    //
    //         await login(); //check if user has submitted onboarding data
    //
    //         if (loginMessage == 'Successful') {
    //           //user has submitted onboarding data
    //           _saveUserProfileDetails();
    //           locator<SignupService>().setLoadingIndicatorForApple = false;
    //           locator<VideoPlayerService>().videoPlayerController!.dispose(); //stop video
    //           locator<NavigationService>().clearStackAndShow(DashboardView.routeName); //move to dashboard
    //         } else if (loginMessage == 'User profile not found') {
    //           //user has not submitted onboarding data
    //           locator<SignupService>().setLoadingIndicatorForApple = false;
    //           locator<VideoPlayerService>().videoPlayerController!.dispose(); //stop video
    //
    //           //ProfileDetailsPageViewModel.firstNameController.text = firebaseUser.displayName?.split(' ')[0] ?? '';
    //           //ProfileDetailsPageViewModel.lastNameController.text = firebaseUser.displayName?.split(' ')[1] ?? '';
    //
    //           //locator<NavigationService>().clearStackAndShow(ProfileDetailsPage.routeName); //move to profile page
    //         } else {
    //           //error occurred
    //           await GoogleSignIn().disconnect();
    //           locator<SignupService>().setLoadingIndicatorForApple = false;
    //           showToast(
    //               context: context,
    //               message: 'An unexpected error has occurred, please try again later',
    //               messageType: ToastMessageType.error);
    //         }
    //       }
    //     }
    //
    //   } else if (result.status == apple.AuthorizationStatus.error) {
    //     locator<SignupService>().setLoadingIndicatorForApple = false;
    //     showToast(context: context, message: 'Authorization denied!',
    //         messageType: ToastMessageType.error);
    //
    //   }
    //   else if (result.status == apple.AuthorizationStatus.cancelled) {
    //     locator<SignupService>().setLoadingIndicatorForApple = false;
    //     showToast(context: context, message: 'Sign-in aborted by user',
    //         messageType: ToastMessageType.error);
    //
    //   }
    //   else {
    //     locator<SignupService>().setLoadingIndicatorForApple = false;
    //     showToast(context: context, message: 'Error occured',
    //         messageType: ToastMessageType.error);
    //   }
    // }
    // catch (e) {
    //   print(e.toString());
    //   locator<SignupService>().setLoadingIndicatorForApple = false;
    //   showToast(
    //       context: context,
    //       message: 'An unexpected error has occurred, please try again later',
    //       messageType: ToastMessageType.error);
    // }
  }

  Future<void> signupWithFacebook({required BuildContext context}) async {
    // //The total number of calls your app can make per hour is 200 times the number of users. Please note this isn't a per-user limit.
    // try {
    //   locator<SignupService>().setLoadingIndicatorForFacebook = true;
    //   final LoginResult loginResult = await FacebookAuth.instance.login();
    //   final OAuthCredential facebookAuthCredential =
    //   FacebookAuthProvider.credential(loginResult.accessToken!.token);
    //   await _auth
    //       .signInWithCredential(facebookAuthCredential)
    //       .then((UserCredential userCredential) async {
    //     if (userCredential.user != null) {
    //       if (userCredential.additionalUserInfo!.isNewUser) {
    //         //new user
    //         locator<SignupService>().setLoadingIndicatorForFacebook = false;
    //         locator<VideoPlayerService>().videoPlayerController!.dispose(); //stop video
    //         //locator<NavigationService>().clearStackAndShow(ProfileDetailsPage.routeName); //move to profile page
    //       } else {
    //         //existing user
    //
    //         await login(); //check if user has submitted onboarding data
    //
    //         if (loginMessage == 'Successful') {
    //           //user has submitted onboarding data
    //           _saveUserProfileDetails();
    //           locator<SignupService>().setLoadingIndicatorForFacebook = false;
    //           locator<VideoPlayerService>().videoPlayerController!.dispose(); //stop video
    //           locator<NavigationService>()
    //               .clearStackAndShow(DashboardView.routeName); //move to dashboard
    //         } else if (loginMessage == 'User profile not found') {
    //           //user has not submitted onboarding data
    //           locator<SignupService>().setLoadingIndicatorForFacebook = false;
    //           locator<VideoPlayerService>().videoPlayerController!.dispose(); //stop video
    //           //locator<NavigationService>().clearStackAndShow(ProfileDetailsPage.routeName); //move to profile page
    //         } else {
    //           //error occurred
    //           locator<SignupService>().setLoadingIndicatorForFacebook = false;
    //           showToast(
    //               context: context,
    //               message: 'An unexpected error has occurred, please try again later',
    //               messageType: ToastMessageType.error);
    //         }
    //       }
    //     } else {
    //       locator<SignupService>().setLoadingIndicatorForFacebook = false;
    //       showToast(
    //           context: context,
    //           message: 'Facebook sign in failed!',
    //           messageType: ToastMessageType.error);
    //     }
    //   });
    // } on SocketException {
    //   locator<SignupService>().setLoadingIndicatorForFacebook = false;
    //   showToast(
    //       message: 'You\'re not connected to the Internet',
    //       context: context,
    //       messageType: ToastMessageType.error);
    // } catch (e) {
    //   locator<SignupService>().setLoadingIndicatorForFacebook = false;
    //   showToast(
    //       message: 'An unexpected error has occurred, please try again later',
    //       context: context,
    //       messageType: ToastMessageType.error);
    //   print("Error received on facebook sign-in:  ${e.toString()}");
    // }
  }

  Future<bool> createAccount(String endpoint) async {
    try {
      //get firebase auth token
      IdTokenResult? tokenResult = await FirebaseAuth.instance.currentUser?.getIdTokenResult();
      String? firebaseAuthToken = tokenResult?.token;
      //get fcm token
      String? fcmToken = await tokenGenerator();

      dev.log('${
        'fcm_token :' '$fcmToken'
        'token :' '$firebaseAuthToken'
      }');

      var response = await http.post(Uri.parse(Apis.baseUrl + endpoint), headers: {
        "Accept": "application/json",
      }, body: {
        'fcm_token': fcmToken,
        'token':firebaseAuthToken
      });

      print('statusCode::: ${response.statusCode}');
      print('response::: ${response.body}');

       bool success = json.decode(response.body.toString())["success"] ?? false;
       int? statusCode = response.statusCode;

      String? message = json.decode(response.body.toString())["message"];
      if((statusCode == 200 || statusCode == 201) && success){
        StorageService().addString('token',jsonEncode(json.decode(response.body.toString())["token"]));
        if(await fetchProfile()){
          return true;
        }else {
          return false;
        }
      }else{
        return false;
      }
    } catch (e) {
      print("Error received when creating account with $endpoint: ${e.toString()}");
      return false;
    }
  }

  Future<bool> fetchProfile() async {
    try {

      final ProfileService _profileService = locator<ProfileService>();

      var response = await http
          .get(Uri.parse(Apis.baseUrl + Apis.profile), headers: {
        "Accept": "application/json",
        "Authorization": 'Bearer ${StorageService().getString('token')}'
      }).timeout(const Duration(seconds: 60));

      dPrint('statusCode::: ${response.statusCode}');
      dPrint('response::: ${response.body}');

      bool success = jsonDecode(response.body)['success'] ?? false;
      String? message = jsonDecode(response.body)['message'];

      //success
      if ((response.statusCode == 200 || response.statusCode == 201) && success) {
        Profile? temp = Profile.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
        _profileService.setProfileDetails = temp.data;
        StorageService().addString('userProfile', jsonEncode(temp.data));
        StorageService().addBool('isLoggedIn', true);
        dPrint('profile fetched:::');
        return true;
        // showToast(context: context,
        //     message: 'Your account has been created successfully',
        //     messageType: ToastMessageType.success);
      }
      //failure
      else {
        dPrint('error ${response.body}');
        return false;
        // showToast(context: context,
        //     message: message ?? AppStrings.unknownError,
        //     messageType: ToastMessageType.error);
      }
    } catch (e) {
      // showToast(
      //     context: context, message: AppStrings.unknownError, messageType: ToastMessageType.error);
      dPrint("Error received when fetching profile: ${e.toString()}");
      return false;
    }
  }

}
