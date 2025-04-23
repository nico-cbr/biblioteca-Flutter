// ignore_for_file: camel_case_types, sized_box_for_whitespace, avoid_print, use_super_parameters, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:adotabr/wid/dmwid/dmDetalhes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class conversarDm extends StatefulWidget {
  const conversarDm({Key? key}) : super(key: key);

  @override
  State<conversarDm> createState() => _conversarDmState();
}

class _conversarDmState extends State<conversarDm> {
  List<Map<String, dynamic>> chats = [];
  List<Map<String, String>> messages = [];
  bool isLoading = true;

  final String firebaseUrl = 'https://adota0-001-default-rtdb.firebaseio.com/Anonimato/Mensagens1.json';

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

 Future<void> marcarMensagensComoLidas() async {
  try {
    final response = await http.get(Uri.parse(firebaseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final Map<String, dynamic> updates = {};

      data.forEach((key, value) {
        if (value["from"] == "them" && value["read"] == false) {
          // Atualiza apenas o campo "read" do nó específico
          updates["$key/read"] = true;
        }
      });

      if (updates.isNotEmpty) {
        await http.patch(
          Uri.parse(firebaseUrl),
          body: jsonEncode(updates),
        );
      }
    }
  } catch (e) {
    print("Erro ao marcar mensagens como lidas: $e");
  }
}

  Future<void> fetchMessages() async {
    try {
      final response = await http.get(Uri.parse(firebaseUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<Map<String, String>> loadedMessages = [];
        int unreadCount = 0;

        data.forEach((key, value) {
          final isRead = value["read"] ?? false;
          if (value["from"] == "them" && isRead == false) {
            unreadCount++;
          }
          loadedMessages.add({
            "from": value["from"] ?? "unknown",
            "text": value["text"] ?? "No text",
            "time": value["time"] ?? "Unknown time",
          });
        });

        final List<Map<String, dynamic>> fixedChats = [
          {
            "name": "Abrigo Nova Vida",
            "message": "Nós que agradecemos!",
            "time": "14:10",
            "unread": 1,
            "image": "assets/lar3.png"
          },
          {
            "name": "Lar Esperança",
            "message": "Vamos marcar uma visita!",
            "time": "11:05",
            "unread": 0,
            "image": "assets/lar2.png"
          },
        ];

        setState(() {
          messages = loadedMessages;
          isLoading = false;

          chats = [];

          if (messages.isNotEmpty) {
            final lastMessage = messages.last;
            chats.add({
              "name": "Lar da Luz",
              "message": lastMessage["text"] ?? "Sem mensagem",
              "time": lastMessage["time"] ?? "--:--",
              "unread": unreadCount,
              "image": "assets/lar1.png",
            });
          }

          chats.addAll(fixedChats);
        });
      } else {
        print('Erro ao buscar mensagens: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Erro na requisição: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      alignment: Alignment.center,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                height: 600,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: chats.length,
                  separatorBuilder: (_, __) => const Divider(indent: 70, endIndent: 20),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ListTile(
                      onTap: index == 0
                          ? () async {
                              await marcarMensagensComoLidas();
                              setState(() {
                                chats[index]["unread"] = 0;
                              });
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => dmDetalhes(),
                                ),
                              );
                              fetchMessages();
                            }
                          : null,
                      leading: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(chat["image"]),
                      ),
                      title: Text(
                        chat["name"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      subtitle: Text(
                        chat["message"],
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            chat["time"],
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          if (chat["unread"] > 0)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.indigo.shade900,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${chat["unread"]}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}