import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConversationLoadingItem extends StatelessWidget {
  const ConversationLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // CircleAvatar(
        //   backgroundColor: Colors.grey[200],
        //   child: const Text(
        //     '🤖',
        //     style: TextStyle(fontSize: 26),
        //   ),
        // ),
        Lottie.asset(
          'assets/animations/typing.json',
          width: 100,
          // height: 80,
          fit: BoxFit.cover,
          repeat: true,
        ),
      ],
    );
  }
}
