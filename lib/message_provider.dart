import 'package:flutter/material.dart';
import 'package:flutter_application_2/message.dart';

class MessageProvider extends ChangeNotifier {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
