import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:http/http.dart' as http;

class ChatbotController extends GetxController {
  final ChatUser currentUser = ChatUser(id: '1', firstName: 'You');
  final ChatUser aiUser = ChatUser(id: '2', firstName: 'AI');

  var allMessages = <ChatMessage>[].obs;
  var isTyping = false.obs;

  final inputController = TextEditingController();

  final String proxyUrl = 'http://localhost:3000/chat';

  void sendMessageFromInput() {
    final text = inputController.text.trim();
    if (text.isEmpty) return;

    final msg = ChatMessage(
      text: text,
      user: currentUser,
      createdAt: DateTime.now(),
    );

    inputController.clear();
    sendMessage(msg);
  }

  Future<void> sendMessage(ChatMessage message) async {
    allMessages.insert(0, message);
    isTyping.value = true;

    final url = Uri.parse(proxyUrl);
    final body = {"prompt": message.text};

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json", "accept": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String aiText = data['reply'] ?? 'No response from AI';

        allMessages.insert(
          0,
          ChatMessage(
            text: aiText,
            user: aiUser,
            createdAt: DateTime.now(),
          ),
        );
      } else {
        allMessages.insert(
          0,
          ChatMessage(
            text: 'Server error: ${response.statusCode}',
            user: aiUser,
            createdAt: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      allMessages.insert(
        0,
        ChatMessage(
          text: 'Connection failed: $e',
          user: aiUser,
          createdAt: DateTime.now(),
        ),
      );
    } finally {
      isTyping.value = false;
    }
  }
}
