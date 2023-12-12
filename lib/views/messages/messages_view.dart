import 'package:flutter/material.dart';
import 'package:megadey_mobile/views/messages/messages_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import '../chat/chat_view.dart';

class MessagesView extends StatelessWidget {
  static const routeName = 'messagesView';

  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessagesViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => MessagesViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Color(0xFFF6F6F6),
                appBar: appBar(model, context),
                body: messagesList(model))));
  }

  AppBar appBar(MessagesViewModel model, BuildContext context) {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      title: Text(
        'Messages',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          // fontFamily: 'Circular Std',
          fontWeight: FontWeight.w700,
          letterSpacing: -0.40,
        ),
      ),
    );
  }

  Widget messagesList(MessagesViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: model.messages != null && model.messages!.isNotEmpty
          ? ListView(children: [
        SizedBox(height: 15.0),
        ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: model.messages?.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              Map? message = model.messages?[index];
              return InkWell(
                highlightColor: Palette.primaryColor.withOpacity(0.1),
                onTap: () {
                  NavigationService().navigateTo(ChatView.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey.withOpacity(0.1),
                            backgroundImage: AssetImage(message?["image"] ?? ''),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 160,
                                    child: Text(
                                      message?["title"] ?? '',
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Palette.primaryColor,
                                        fontSize: 16,
                                        // fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: 160,
                                    child: Text("${message?["subtitle"]}",
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Color(0xFF9F9F9F),
                                          fontSize: 14,
                                          // fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    message?["time"] ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      // fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  message?["unread"] != 0
                                      ?  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Palette.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text("${message?["unread"]}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          // fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                        )),
                                  )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })
      ])
          :  Center(
        child: Text(
          'No new messages',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            // fontFamily: 'Circular Std',
            fontWeight: FontWeight.w700,
            letterSpacing: -0.24,
          ),
        ),
      ),
    );
  }
}
