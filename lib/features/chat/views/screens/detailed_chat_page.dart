import 'package:flutter/material.dart';
import 'package:shopsyncseller/features/chat/views/widgets/recieve_chat_widget.dart';
import 'package:shopsyncseller/features/chat/views/widgets/recieve_voice_chat_widget.dart';
import 'package:shopsyncseller/features/chat/views/widgets/send_chat_widget.dart';
import 'package:shopsyncseller/features/chat/views/widgets/send_voice_widget.dart';
import 'package:shopsyncseller/features/chat/views/widgets/typeing_bar_widget.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';

class DetailedChatPage extends StatelessWidget {
  const DetailedChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors().appWhite,
        appBar: AppBar(
          backgroundColor: AppColors().appBackgroundColor,
          title: const Text(
            "John Son",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: const Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Received Message on the Left Side
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RecieveChatWidget(
                          msg: "what can i do to confirm",
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Sent Message on the Right Side
                      Align(
                        alignment: Alignment.centerRight,
                        child: SendChatWidget(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RecieveChatWidget(
                            msg: "What is the specifications"),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SendVoiceWidget(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RecieveVoiceChatWidget(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            TypeingBarWidget()
          ],
        ),
      ),
    );
  }
}
