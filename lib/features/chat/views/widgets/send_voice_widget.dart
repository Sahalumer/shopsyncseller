import 'package:flutter/material.dart';
import 'package:shopsyncseller/utils/constants/application_colors.dart';
import 'package:shopsyncseller/utils/media_query/media_query.dart';

class SendVoiceWidget extends StatefulWidget {
  const SendVoiceWidget({super.key});

  @override
  State<SendVoiceWidget> createState() => _SendVoiceWidgetState();
}

class _SendVoiceWidgetState extends State<SendVoiceWidget> {
  bool isPalaying = false;
  final Duration _position = const Duration();
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
        color: AppColors().sendBgc,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
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
              Text("You"),
              Text("03:54"),
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
              Text("02:00"),
            ],
          )
        ],
      ),
    );
  }
}
