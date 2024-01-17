import 'package:flutter/material.dart';
import 'package:flutter_application_2/chat_screen.dart';
import 'package:flutter_application_2/message_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      home: ChatGPTScreen(),
    );
  }
}
