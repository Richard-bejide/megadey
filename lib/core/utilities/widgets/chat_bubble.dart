import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../enums.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatBubble extends StatefulWidget {
  final Sender? sender;
  final Color? bgColor;
  final Color? textColor;
  final dynamic time;
  final bool? showTime;
  final double? maxWidth;
  final double? minWidth;
  final bool isRead;
  final String? message;
  final ChatMessageType messageType;
  final String? contactType;
  final String? contact;
  final String? photo;
  final String? video;
  final String? voiceNote;
  final String? videoThumbnail;
  final int? currentIndex;

  const ChatBubble(
      {Key? key,
      this.sender,
      this.bgColor,
      this.textColor,
      this.time,
      this.showTime,
      this.minWidth,
      required this.isRead,
      this.maxWidth,
      this.message,
      required this.messageType,
      this.contact,
      this.contactType,
      this.photo,
      this.voiceNote,
      this.video,
      this.videoThumbnail,
      this.currentIndex})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  CrossAxisAlignment messageAlignment() {
    if (widget.sender == null || widget.sender == Sender.match) {
      return CrossAxisAlignment.start;
    } else {
      return CrossAxisAlignment.end;
    }
  }

  double bottomLeftRadius() {
    if (widget.sender == null || widget.sender == Sender.match) {
      return 0.0;
    } else {
      return 12.0;
    }
  }

  double bottomRightRadius() {
    if (widget.sender == null || widget.sender == Sender.match) {
      return 12.0;
    } else {
      return 0.0;
    }
  }

  Color messageBgColor(BuildContext context) {
    if (widget.sender == null || widget.sender == Sender.match) {
      return Palette.backgroundColor;
    } else {
      return Palette.primaryColor;
    }
  }

  Color messageTextColor(BuildContext context) {
    if (widget.sender == null || widget.sender == Sender.match) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  Widget messageTime() {
    if (widget.showTime != null && widget.showTime == true) {
      return Text(
          (widget.time != null && widget.time is String) ? timeago.format(DateTime.parse(widget.time!)) : '',
        style: const TextStyle(
          fontSize: 12.0,
          color: Color(0xFF666666),
        ),
      );
    }
    return const Text('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: messageAlignment(),
        children: [
          Container(
              constraints: BoxConstraints(
                  minWidth: widget.minWidth ?? 100.0, maxWidth: widget.maxWidth ?? 270.0),
              decoration: BoxDecoration(
                color: widget.bgColor ?? messageBgColor(context),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(bottomLeftRadius()),
                  bottomRight: Radius.circular(bottomRightRadius()),
                  topLeft: const Radius.circular(12.0),
                  topRight: const Radius.circular(12.0),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 16.0,
              ),
              child: showView(context)),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 12.0,
            ),
            child:
                //Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // children: [
                messageTime(),
            // const SizedBox(width: 3.0),
            // SvgPicture.asset(
            //   'assets/images/icons/read.svg',
            //   color: isRead ? Palette.red : Palette.grey,
            // )
            //  ]),
          ),
        ],
      ),
    );
  }

  //text Message
  Widget _textMessage(BuildContext context) {
    return Text(
      widget.message ?? "Message here...",
      style: TextStyle(
        fontSize: 16.0,
        color: widget.textColor ?? messageTextColor(context),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget showView(BuildContext context) {
      return _textMessage(context);
  }

}
