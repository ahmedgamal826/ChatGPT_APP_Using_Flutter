import 'package:flutter/material.dart';

class TextFormFieldAndIconAndIcon extends StatelessWidget {
  const TextFormFieldAndIconAndIcon(
      {required this.userInput,
      required this.sendMessage,
      required this.label});

  final TextEditingController userInput;
  final VoidCallback sendMessage;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 15,
            child: TextFormField(
              style: const TextStyle(color: Colors.black),
              controller: userInput,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: Text('$label')),
            ),
          ),
          const Spacer(),
          IconButton(
            padding: const EdgeInsets.all(12),
            iconSize: 30,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(const CircleBorder()),
            ),
            onPressed: sendMessage,
            icon: const Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
