import 'package:chat_gpt_app_using_flutter/services/chat_gpt_services.dart';
import 'package:chat_gpt_app_using_flutter/models/messages_model.dart';
import 'package:chat_gpt_app_using_flutter/widgets/chat_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController userInput = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool _isLoading = false;

  Future<void> sendMessage() async {
    final message = userInput.text;

    setState(() {
      _isLoading = true; // user
      ChatScreenBody.messages.add(
        Message(isUser: true, message: message, date: DateTime.now()),
      );
    });

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );

    userInput.clear();

    final content = [Content.text(message)]; // message ==> user message
    final response =
        await ChatGPTServices.model.generateContent(content); // gpt message

    setState(() {
      _isLoading = false; // chat gpt
      ChatScreenBody.messages.add(Message(
          isUser: false, message: response.text ?? "", date: DateTime.now()));
    });

    scrollController.animateTo(
      scrollController.position.pixels + 100,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 40,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'ChatGPT',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            ChatScreenBody(
              scrollController: scrollController,
              sendMessage: sendMessage,
              userInput: userInput,
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
