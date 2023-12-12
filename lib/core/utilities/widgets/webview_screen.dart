import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constants/colors.dart';
import '../../enums/error_type.dart';
import 'loading_widget.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {

          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            Navigator.pop(context);
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  bool isLoading = true;
  ErrorType? errorType;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      color: Palette.primaryColor.withOpacity(0.3),
      progressIndicator: LoadingWidget(color: Palette.primaryColor),
      child: controller != null
          ? Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:5.0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Colors.black)),
                  ),
                  Expanded(child: WebViewWidget(controller: controller!)),
                ],
              )))
          : Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.9,
                    child: const Text('Loading...',
                        style: TextStyle(color: Colors.black, fontSize: 17)),
                  ),
                ),
              ),
            ),
    );
  }
}
