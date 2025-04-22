// ignore_for_file: camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class dmDetalhes extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {"from": "me", "text": "Bom dia, eu vi sobre a *** ***** e gostaria de saber como posso proceder.", "time": "16:01"},
    {"from": "them", "text": "Olá! nós podemos fazer uma visita presencial ou uma ligação antes. 😊", "time": "16:02"},
    {"from": "me", "text": "Olha se ela nao se incomodar gostaria de conhece-la pessoalmente", "time": "16:03"},
    {"from": "them", "text": "haha ela é bem extrovertida e vai adora", "time": "16:05"},
    {"from": "them", "text": "vou providenciar e te trago um retorno", "time": "16:06"},
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
                    margin: isMe ? EdgeInsets.only(left: 100, top: 15) : EdgeInsets.only(right: 100, top: 15),
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
