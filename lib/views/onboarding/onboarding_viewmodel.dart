import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';
import '../../app/locator.dart';
import '../../core/services/utility_storage_service.dart';
import '../../core/services/video_player_service.dart';
import '../auth/sign_in_with_email/sign_in_with_email_view.dart';
import '../auth/signup/signup_view.dart';

class OnboardingViewModel extends ReactiveViewModel {
  final NavigationService? _navigationService = locator<NavigationService>();
  final StorageService? _storageService = locator<StorageService>();
  final VideoPlayerService _videoPlayerService = locator<VideoPlayerService>();

  VideoPlayerController? videoPlayerController;

  void setup(BuildContext context) async {
    _initVideoPlayer();
    videoPlayerController = _videoPlayerService.videoPlayerController;
    notifyListeners();
  }

  Future<void> _initVideoPlayer() async {
    _videoPlayerService.setVideoPlayerController = VideoPlayerController.asset('assets/videos/bg_video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        notifyListeners();
      });
    _videoPlayerService.videoPlayerController!.play();
    _videoPlayerService.videoPlayerController!.setLooping(true);
  }

  void navigateToSignIn() {
    _navigationService?.navigateTo(SignInWithEmailView.routeName);
    _storageService!.addBool('isOnBoarding', true);

  }

  void navigateToSignup() {
    _navigationService?.navigateTo(SignupView.routeName);
    _storageService!.addBool('isOnBoarding', true);

  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [];
}
