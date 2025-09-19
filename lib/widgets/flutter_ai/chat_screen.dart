import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LlmChatView(
        style: LlmChatViewStyle.defaultStyle(),
        suggestions: [],
        // speechToText: ,
        // responseBuilder: (context, msg) {},
      //     Stream<String> Function(
      //     String prompt, {
      //   required Iterable<Attachment> attachments,
      // });
      //   messageSender: (prompt, {attachments}) => ,
        enableVoiceNotes: true,
        enableAttachments: true,
        errorMessage: '',
        welcomeMessage: '',
        onCancelCallback: (context) {},
        onErrorCallback: (context, e) {},
        provider: FirebaseProvider( // use FirebaseProvider and googleAI()
          model: FirebaseAI.googleAI().generativeModel(model: 'gemini-2.0-flash'),
        ),
      ),
    );
  }
}
