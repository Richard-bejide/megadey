import 'package:flutter/material.dart';
import 'package:megadey_mobile/views/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../core/constants/colors.dart';
import 'package:video_player/video_player.dart';
import '../../core/services/utility_storage_service.dart';
import '../../core/utilities/widgets/rounded_button.dart';

class StartupView extends StatelessWidget {
  static const routeName = 'startupView';

  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => StartupViewModel(),
        builder: (context, model, child) => Material(
                child: model.currentPage == 1
          ? Scaffold(
              backgroundColor: Palette.backgroundColor,
              body: SafeArea(
                child: Center(
                  child: Image.asset('assets/images/logo_full.png',height: 200,width: 300),
                ),
              ),
            )
          : Scaffold(
                    backgroundColor: Colors.black,
                    body: Stack(
                        children: [
                          SizedBox.expand(
                              child: FittedBox(
                                // If your background video doesn't look right, try changing the BoxFit property.
                                // BoxFit.cover created the look I was going for.
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                      width: model.videoPlayerController!.value.size.width,
                                      height: model.videoPlayerController!.value.size.height,
                                      child: model.videoPlayerController!.value.isInitialized
                                          ? VideoPlayer(model.videoPlayerController!)
                                          : Container()))),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          //   height: MediaQuery.of(context).size.height,
                          //   color: Colors.black.withOpacity(0.4),
                          // )
                        ]))
        ));
  }
}
