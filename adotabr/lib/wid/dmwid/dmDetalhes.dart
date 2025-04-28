// ignore_for_file: avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class dmDetalhes extends StatefulWidget {
  @override
  _dmDetalhesState createState() => _dmDetalhesState();
}

class _dmDetalhesState extends State<dmDetalhes> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = []; // ✅ dynamic para aceitar bool
  bool isLoading = true;
  bool isMe = true; // ✅ controle do switch

  final String firebaseUrl = 'https://adota0-001-default-rtdb.firebaseio.com/Anonimato/Mensagens1.json';

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      final response = await http.get(Uri.parse(firebaseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<Map<String, dynamic>> loadedMessages = [];

        data.forEach((key, value) {
          loadedMessages.add({
            "from": value["from"] ?? "unknown",
            "text": value["text"] ?? "No text",
            "time": value["time"] ?? "Unknown time",
            "read": value["read"] ?? false, // ✅ carrega read também
          });
        });

        setState(() {
          messages = loadedMessages;
          isLoading = false;
        });
      } else {
        print('Erro ao buscar mensagens: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } catch (e) {
      print('Erro na requisição: $e');
      setState(() => isLoading = false);
    }
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final now = TimeOfDay.now();
    final formattedTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    final Map<String, dynamic> newMessage = {
      "from": isMe ? "me" : "them",
      "text": text,
      "time": formattedTime,
      if (!isMe) "read": true, // ✅ apenas se for "them"
    };

    setState(() {
      messages.add(newMessage);
    });

    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse(firebaseUrl),
        body: jsonEncode(newMessage),
        headers: {'Content-Type': 'application/json'}, // ✅ importante
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Mensagem enviada com sucesso');
      } else {
        print('Erro ao enviar mensagem: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro na requisição: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber.shade50),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/lar1.png'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Lar da Luz",
                style: TextStyle(
                  color: Colors.amber.shade50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Switch(
              value: isMe,
              onChanged: (value) {
                setState(() {
                  isMe = value;
                });
              },
              activeColor: Colors.indigo.shade900,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        final isMeMessage = msg['from'] == 'me';

                        return Align(
                          alignment: isMeMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                            margin: isMeMessage
                                ? EdgeInsets.only(left: 100, top: 15)
                                : EdgeInsets.only(right: 100, top: 15),
                            decoration: BoxDecoration(
                              color: isMeMessage
                                  ? Colors.indigo.shade900
                                  : Colors.indigo.shade900.withAlpha(20),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  msg['text'] ?? '',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: isMeMessage
                                        ? Colors.amber.shade50
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  msg['time'] ?? '',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Divider(color: Colors.grey.shade300),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade50,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: Colors.indigo.shade900),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Digite uma mensagem...",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: CircleAvatar(
                      backgroundColor: Colors.indigo.shade900,
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
