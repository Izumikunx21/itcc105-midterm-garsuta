import 'package:flutter/material.dart';
import 'copilot_engine.dart';

void main() {
  runApp(AICopilotApp());
}

class AICopilotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CopilotScreen(),
    );
  }
}

class CopilotScreen extends StatefulWidget {
  @override
  _CopilotScreenState createState() => _CopilotScreenState();
}

class _CopilotScreenState extends State<CopilotScreen> {
  TextEditingController controller = TextEditingController();
  List<String> messages = [];

  bool isInternetConnected = true;

  void sendMessage() {
    String userText = controller.text;
    if (userText.isEmpty) return;

    // Use the copilot_engine
    String response = copilotResponse(
      userText,
      isInternetConnected: isInternetConnected,
    );

    setState(() {
      messages.add("You: $userText");
      messages.add("AI: $response");
    });

    controller.clear();
  }

  Widget buildMessage(String text) {
    return Container(
      alignment: text.startsWith("You")
          ? Alignment.centerRight
          : Alignment.centerLeft,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: text.startsWith("You") ? Colors.blue[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text),
      ),
    );
  }

  Widget suggestionButton(String text) {
    return ElevatedButton(
      onPressed: () {
        controller.text = text;
        sendMessage();
      },
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ASSCAT AI Copilot"),
        actions: [
          IconButton(
            icon: Icon(Icons.wifi),
            onPressed: () {
              setState(() {
                isInternetConnected = !isInternetConnected;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text("Hi! What do you need today?", style: TextStyle(fontSize: 18)),

            // Message list
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 8),
                children: messages.map((msg) => buildMessage(msg)).toList(),
              ),
            ),

            // Input field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.send), onPressed: sendMessage),
                ],
              ),
            ),

            // Suggestion buttons
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  suggestionButton("Check clearance"),
                  suggestionButton("View schedule"),
                  suggestionButton("Check grades"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
