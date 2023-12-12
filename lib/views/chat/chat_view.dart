import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megadey_mobile/core/utilities/enums.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/constants/colors.dart';
import '../../core/utilities/widgets/chat_bubble.dart';
import '../seller_page/seller_page_view.dart';
import 'chat_viewmodel.dart';

class ChatView extends StatelessWidget {
  static const routeName = 'chatView';

  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return ViewModelBuilder<ChatViewModel>.reactive(
        onModelReady: (model) => model.setup(context),
        viewModelBuilder: () => ChatViewModel(),
        builder: (context, model, child) => Material(
            child: Scaffold(
                backgroundColor: Color(0xFFF6F6F6),
                body: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      const SizedBox(height: 20),
                      appBar(model, context),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(children: [
                              const SizedBox(height: 15),
                              productCard(),
                              const SizedBox(height: 25),
                              Center(
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                    color: Color(0xFF171717),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              messages(model),
                        ])),
                      ),
                          Container(
                            width: size.width,
                            color: Palette.backgroundColor,
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0,top: 5.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Expanded(
                                child: Container(
                                    padding: const EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                        //border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
                                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              if (model.chatBoxHeight !=
                                                  MediaQuery.of(context).size.height - 175 - 250) {
                                                model.chatBoxHeight -= 250.0;
                                              } else {
                                                model.chatBoxHeight += 250.0;
                                              }
                                              model.showEmojiPicker = !model.showEmojiPicker;
                                            },
                                            child: SvgPicture.asset('assets/icons/send_files.svg',height: 17,color: Colors.black54)),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: TextFormField(
                                            onTap: () {
                                              model.showEmojiPicker = false;
                                              model.notifyListeners();
                                            },
                                            textInputAction: TextInputAction.newline,
                                            minLines: 1,
                                            maxLines: 4,
                                            controller: model.messageController,
                                            cursorColor: Colors.black,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                            keyboardType: TextInputType.multiline,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.all(2.0),
                                              hintText: model.messageHintText,
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              //
                                            },
                                            child: SvgPicture.asset('assets/icons/emoji.svg',height: 17,color: Colors.black54))                                      ],
                                    )),
                              ),
                              const SizedBox(width: 8.0),
                              GestureDetector(
                                onTap: () {
                                  model.messageController.clear();
                                  model.showEmojiPicker = false;
                                  FocusScope.of(context).unfocus();
                                  model.notifyListeners();
                                },
                                child: Icon(Icons.send,color: Colors.black54,size: 30),
                              )
                            ]),
                          ),
                          model.showEmojiPicker ? _showEmoji(context, model) : const SizedBox()
                    ])))));
  }

  Widget appBar(ChatViewModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_outlined, color: Colors.black, size: 20)),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: (){
                    NavigationService().navigateTo(SellerPageView.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 22,
                          backgroundColor: Palette.primaryColor.withOpacity(0.1),
                          backgroundImage: AssetImage('assets/images/messages4.png')),
                      const SizedBox(width: 8),
                      Text(
                        'Sarah Ayo',
                        style: TextStyle(
                          color: Color(0xFF222121),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.27,
                        ),
                      )
                    ],
                  ),
                ),

              ]),
          GestureDetector(
              onTap: () {},
              child: SvgPicture.asset('assets/icons/phone.svg',
                  color: Palette.primaryColor, height: 20))
        ],
      ),
    );
  }

  Widget productCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/speaker.png', height: 56, width: 56),
                const SizedBox(width: 8),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'JBL Speakers',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.28,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Is this still available?',
                        style: TextStyle(
                          color: Color(0xFF7B7B7B),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.26,
                        ),
                      )
                    ])
              ],
            ),
            Text(
              'N32,000.00',
              style: TextStyle(
                color: Palette.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.24,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget messages(ChatViewModel model) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
          child: ListView.builder(
              itemCount: model.messages.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                Map message = model.messages[index];
                return ChatBubble(
                  messageType: ChatMessageType.text,
                  sender: message['isSender']
                      ? Sender.me
                      : Sender.match,
                  isRead: false,
                  message: message['message'],
                  currentIndex: index,
                );
              }),
        ));
  }

  //show emoji
  Widget _showEmoji(BuildContext context, ChatViewModel model) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: 250,
        width: size.width,
        child: EmojiPicker(
          onEmojiSelected: (category, emoji) {
            model.messageController.text += emoji.emoji;
            model.notifyListeners();
          },
          onBackspacePressed: () {},
          config: const Config(
              columns: 7,
              emojiSizeMax: 28.0,
              verticalSpacing: 0,
              horizontalSpacing: 0.0,
              initCategory: Category.RECENT,
              recentsLimit: 28,
              categoryIcons: CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL),
        ));
  }

}
