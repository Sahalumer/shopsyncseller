import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class RecieveVoiceChatWidget extends StatefulWidget {
  const RecieveVoiceChatWidget({super.key});

  @override
  State<RecieveVoiceChatWidget> createState() => _RecieveVoiceChatWidgetState();
}

class _RecieveVoiceChatWidgetState extends State<RecieveVoiceChatWidget> {
  bool isPalaying = false;
  Duration _position = const Duration();
  @override
  Widget build(BuildContext context) {
    final size = CustomMediaQuery(context);
    return Container(
      padding: const EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxWidth: size.scaledWidth(80),
        minHeight: size.scaledHeight(7),
      ),
      decoration: BoxDecoration(
        color: AppColors().recieveBgc,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("John Son"),
              Text("03:59"),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isPalaying ? Icons.pause : Icons.play_arrow,
                  size: 36,
                ),
                onPressed: () => setState(() {
                  isPalaying = !isPalaying;
                }),
              ),
              Expanded(
                child: Slider(
                  value: _position.inSeconds.toDouble(),
                  min: 0,
                  onChanged: (double value) {},
                ),
              )
            ],
          ),
          const Row(
            children: [
              SizedBox(
                width: 70,
              ),
              Text("01:07"),
            ],
          )
        ],
      ),
    );
  }
}
