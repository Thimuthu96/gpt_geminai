import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:gpt_geminai/src/widgets/conversation_loading_item.dart';
import 'package:gpt_geminai/src/widgets/user_input_field.dart';

import '../models/message.dart';
import '../widgets/conversation_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController userInputController = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  ScrollController scrollController = ScrollController();
  final List<Message> messages = [];
  bool isLoading = false;
  bool isListening = false;

  _callGeminiModel(TextEditingController value, {String? imgUrl}) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: dotenv.env['GOOGLE_API_KEY']!,
      );
      final prompt = imgUrl != null
          ? "${value.text.trim()}\nImage URL: $imgUrl"
          : value.text.trim();
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        isLoading = false;
        messages.add(Message(
          text: response.text!,
          isUser: false,
        ));
      });

      if (isListening == true) {
        await flutterTts.speak(response.text!);
      }

      // Automatically scroll to the bottom after adding a new message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } catch (err) {
      debugPrint('*******Exception******');
      debugPrint('Something went wrong: ${err.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Row(
          children: [
            // Image(
            //   image: NetworkImage(
            //       "https://img.freepik.com/free-vector/cartoon-style-robot-vectorart_78370-4103.jpg?t=st=1732791466~exp=1732795066~hmac=4e06a505105297c7970a1ad55ea3dca780a2398cd1ec36505720c1280b98c8d5&w=996",
            //       scale: 22),
            // ),
            Text(
              "GPT Geminai",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          isListening
              ? IconButton(
                  icon: const Icon(Icons.volume_up_rounded),
                  onPressed: () {
                    setState(() {
                      isListening = false;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.volume_off_rounded),
                  onPressed: () {
                    setState(() {
                      isListening = true;
                    });
                  },
                ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController, // Attach ScrollController
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ConversationItem(message: message);
              },
            ),
          ),
          Container(
            child: isLoading ? const ConversationLoadingItem() : null,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 45),
            child: UserInputField(
              userInputController: userInputController,
              onSend: handleUserChat,
              isLoading: isLoading,
            ),
          ),
        ],
      ),
    );
  }

  void handleUserChat(TextEditingController value) {
    setState(() {
      messages.add(Message(text: value.text.trim(), isUser: true));
      isLoading = true;
    });
    _callGeminiModel(value);

    // Automatically scroll to the bottom after adding a new message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    userInputController.dispose();
    scrollController.dispose(); // Dispose ScrollController
    super.dispose();
  }
}
