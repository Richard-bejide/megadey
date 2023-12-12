import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';
 import 'package:video_player/video_player.dart';

class VideoPlayerService with ReactiveServiceMixin {
   RxValue<VideoPlayerController?> _videoPlayerController = RxValue<VideoPlayerController?>(null);

  VideoPlayerService() {
    listenToReactiveValues([_videoPlayerController]);
  }

  VideoPlayerController? get videoPlayerController => _videoPlayerController.value;

  set setVideoPlayerController(VideoPlayerController? videoPlayerController){
    _videoPlayerController.value = videoPlayerController;
    notifyListeners();
  }


}