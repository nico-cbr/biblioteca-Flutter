// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class dmDetalhes extends StatefulWidget {
  @override
  _dmDetalhesState createState() => _dmDetalhesState();
}

class _dmDetalhesState extends State<dmDetalhes> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  bool isLoading = true; // Flag de carregamento

  // 🔗 URL do banco Firebase
  final String firebaseUrl = 'https://adota0-001-default-rtdb.firebaseio.com/Anonimato/Mensagens1.json';

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  // Função para buscar mensagens do Firebase
  Future<void> fetchMessages() async {
  try {
    final response = await http.get(Uri.parse(firebaseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>; // Mudança aqui: use List<dynamic>

      final List<Map<String, String>> loadedMessages = [];

      // Iterar sobre a lista de mensagens
      for (var mensagem in data) {
        loadedMessages.add({
          "from": mensagem["from"] ?? "unknown",
          "text": mensagem["text"] ?? "No text",
          "time": mensagem["time"] ?? "Unknown time",
        });
      }

      setState(() {
        messages = loadedMessages;
        isLoading = false; // Finaliza o carregamento
      });
    } else {
      print('Erro ao buscar mensagens: ${response.statusCode}');
      setState(() {
        isLoading = false; // Finaliza o carregamento mesmo em caso de erro
      });
    }
  } catch (e) {
    print('Erro na requisição: $e');
    setState(() {
      isLoading = false; // Finaliza o carregamento em caso de erro
    });
  }
}

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final now = TimeOfDay.now();
    final formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    final newMessage = {
      "from": "me",
      "text": text,
      "time": formattedTime,
    };

    setState(() {
      messages.add(newMessage);
    });

    _controller.clear();

    // Envio para o Firebase
    try {
      final response = await http.post(
        Uri.parse(firebaseUrl),
        body: jsonEncode(newMessage),
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
            Text(
              "Lar da Luz",
              style: TextStyle(
                color: Colors.amber.shade50,
                fontWeight: FontWeight.bold,
              ),
            )
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
                        final isMe = msg['from'] == 'me';
        
                        return Align(
                          alignment: isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                            margin: isMe
                                ? EdgeInsets.only(left: 100, top: 15)
                                : EdgeInsets.only(right: 100, top: 15),
                            decoration: BoxDecoration(
                              color: isMe
                                  ? Colors.indigo.shade900
                                  : Colors.indigo.shade900.withAlpha(20),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  msg['text']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: isMe
                                        ? Colors.amber.shade50
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  msg['time']!,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
