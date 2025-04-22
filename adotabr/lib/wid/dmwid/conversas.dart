// ignore_for_file: camel_case_types, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:adotabr/wid/dmwid/dmDetalhes.dart';

// ignore: use_key_in_widget_constructors
class conversarDm extends StatelessWidget {
    final List<Map<String, dynamic>> chats = [
    {
      "name": "Lar da Luz",
      "message": "vou providenciar e te trago um...",
      "time": "16:05",
      "unread": 2,
      "image": "assets/lar1.png"
    },
    {
      "name": "Casa Esperança",
      "message": "Claro, tenha um bom dia",
      "time": "15:20",
      "unread": 0,
      "image": "assets/lar2.png"
    },
    {
      "name": "Abrigo Nova Vida",
      "message": "Nós que agradecemos!",
      "time": "14:10",
      "unread": 1,
      "image": "assets/lar3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 600,
        child: ListView.separated(
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
      ),
    );
  }
}

