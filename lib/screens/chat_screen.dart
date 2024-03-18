import 'dart:async';
import 'package:chatbotapp/modles/messagemodle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbotapp/provider/chatprovider.dart';
import 'package:chatbotapp/utils/util.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _promptController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 33, 33),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 33, 33),

        title: Text(
          'Chat to Bot',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title horizontally
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<chatprovider>(
                builder: (_, provider, child) {
                  var listMessages = provider.getAllmsg();
                  return ListView.builder(
                    reverse: true,
                    itemCount: listMessages.length,
                    itemBuilder: (_, index) {
                      var message = listMessages[index];
                      return buildMessageBubble(message);
                    },
                  );
                },
              ),
            ),
          ),
          buildTextField(),
        ],
      ),
    );
  }

  Widget buildMessageBubble(messagemodle message) {
    final isSentByCurrentUser = message.snederid == 0;
    final alignment =
        isSentByCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final backgroundColor = 
        isSentByCurrentUser ? Colors.blue[300] : Colors.grey[300];
    final textColor = isSentByCurrentUser ? Colors.white : const Color.fromARGB(255, 255, 255, 255);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Row(
            mainAxisAlignment: isSentByCurrentUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                
                child: Text(
                  message.mesg,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Text(
            getTimeString(message.sendAt),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  String getTimeString(int millisecondsSinceEpoch) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Widget buildTextField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 55, 53, 53),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promptController,
                  decoration: InputDecoration(
                    hintText: 'Enter your prompt',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Provider.of<chatprovider>(context, listen: false)
                      .sendmyprompt(propmt: _promptController.text);
                  _promptController.clear();
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 253, 253),
                    shape: BoxShape.circle,
                    
                  ),
                  child: Icon(
                    Icons.send,
                    color: Color.fromARGB(255, 14, 14, 14),
                    size: 18.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
