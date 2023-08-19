import 'package:flutter/material.dart';
import 'package:smartnote/models/chat_model.dart';

import '../../../common/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final ChatModel chat;
  final String profileInitial;
  const ChatBubble(
      {super.key, required this.chat, required this.profileInitial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                chat.prompt,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Material(
                  elevation: 8.0,
                  shape: const CircleBorder(
                      side: BorderSide(color: kcButtonColor, width: 2)),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 20.0,
                    child: Text(profileInitial,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: kcButtonColor,
                              fontWeight: FontWeight.bold,
                            )),
                  )),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Material(
                  elevation: 8.0,
                  shape: const CircleBorder(
                      side: BorderSide(color: kcButtonColor, width: 2)),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 20.0,
                    child: Text('AI',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: kcButtonColor,
                              fontWeight: FontWeight.bold,
                            )),
                  )),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  chat.response,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
