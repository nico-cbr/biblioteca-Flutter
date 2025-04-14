// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

// ignore: c amel_case_types, camel_case_types
class dmPage extends StatelessWidget{
    final List<Map<String, dynamic>> chats = [
    {
      "name": "Lar da Luz",
      "message": "Estamos com pouca fralda e leite 😢",
      "time": "16:05",
      "unread": 2,
      "image": "assets/lar_luz.png"
    },
    {
      "name": "Casa Esperança",
      "message": "Obrigada pela visita de ontem!",
      "time": "15:20",
      "unread": 0,
      "image": "assets/casa_esperanca.png"
    },
    {
      "name": "Abrigo Nova Vida",
      "message": "As crianças amaram os brinquedos 🎁",
      "time": "14:10",
      "unread": 5,
      "image": "assets/nova_vida.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Conversas",
          style: TextStyle(
            color: Colors.indigo.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.indigo.shade900),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 12),
        itemCount: chats.length,
        separatorBuilder: (_, __) => Divider(indent: 70, endIndent: 20),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
           onTap: index == 0 // Verifica se é o primeiro chat
        ? () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => dmDetalhes(), // Passa os dados do chat
              ),
            );
          }
        : null, // Não faz nada para os outros chats
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
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (chat["unread"] > 0)
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${chat["unread"]}',
                      style: TextStyle(
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
    );
  }
  
}
class dmDetalhes extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {"from": "them", "text": "Olá! As crianças estão bem hoje 😊", "time": "16:02"},
    {"from": "me", "text": "Que ótimo saber! Precisam de algo por aí?", "time": "16:03"},
    {"from": "them", "text": "Estamos com pouca fralda e leite 😢", "time": "16:05"},
    {"from": "me", "text": "Beleza, vou providenciar!", "time": "16:06"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber.shade50),
    onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/lar_luz.png'), // imagem fictícia
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg['from'] == 'me';

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.indigo.shade900
                          : Colors.indigo.shade900.withOpacity(0.1),
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
                      style: TextStyle(color: Colors.indigo.shade900),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Digite uma mensagem...",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.indigo.shade900,
                  child: Icon(Icons.send, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  }
