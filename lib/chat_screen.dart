import 'package:flutter/material.dart';
import 'package:flutter_application_2/message_provider.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'message.dart';

class ChatGPTScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  void onSendMessage(BuildContext context) async {
    String text = _textEditingController.text;
    if (text.isNotEmpty) {
      Message message = Message(text: text, isMe: true);
      _textEditingController.clear();

      Provider.of<MessageProvider>(context, listen: false).addMessage(message);

      String response = await ApiService.sendMessageToChatGpt(text);

      Message chatGpt = Message(text: response, isMe: false);

      Provider.of<MessageProvider>(context, listen: false).addMessage(chatGpt);
    }
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.isMe ? 'You' : 'GPT',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(message.text),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<MessageProvider>(
              builder: (context, messageProvider, child) {
                return ListView.builder(
                  reverse: true,
                  itemCount: messageProvider.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildMessage(messageProvider.messages[index]);
                  },
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => onSendMessage(context),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
          )
        ],
      ),
    );
  }
}
