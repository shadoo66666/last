import 'package:flutter/material.dart';
import 'package:task_app/chat%20(2)/chat/message.dart';

import 'package:task_app/constants/constants.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: kPrimaryColor,
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class ChatBuble2 extends StatelessWidget {
  const ChatBuble2({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006488),
        ),
        child: Text(
          message.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
