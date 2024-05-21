import 'package:chat_gpt_app_using_flutter/models/messages_model.dart';
import 'package:chat_gpt_app_using_flutter/widgets/messages_views.dart';
import 'package:chat_gpt_app_using_flutter/widgets/text_form_field_and_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreenBody extends StatelessWidget {
  const ChatScreenBody(
      {required this.userInput,
      required this.scrollController,
      required this.sendMessage});

  final TextEditingController userInput;
  final ScrollController scrollController;
  final VoidCallback sendMessage;

  static List<Message> messages = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Messages(
                  isUser: message.isUser,
                  message: message.message,
                  date: DateFormat('hh:mm a').format(message.date),
                );
              },
            ),
          ),
          TextFormFieldAndIconAndIcon(
            userInput: userInput,
            label: 'Enter Your Message',
            sendMessage: sendMessage,
          ),
        ],
      ),
    );
  }
}
