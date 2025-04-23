import 'package:flutter/material.dart';

class GovNotificationsPage extends StatelessWidget {
  const GovNotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "Atualização de Cadastro",
        "subtitle": "Seu cadastro foi atualizado com sucesso.",
        "time": "12:47",
        "icon": Icons.person,
      },
      {
        "title": "Novo Documento",
        "subtitle": "Novo termo de responsabilidade disponível.",
        "time": "11:32",
        "icon": Icons.description,
      },
      {
        "title": "Consulta Agendada",
        "subtitle": "Você tem uma nova consulta marcada.",
        "time": "09:15",
        "icon": Icons.calendar_today,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications, color: Color.fromARGB(255, 26, 35, 126)),
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔍 Campo de busca
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar notificações...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // 📥 Lista de notificações
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: Icon(notification["icon"] as IconData,
                        color: Colors.indigo.shade900),
                  ),
                  title: Text(
                    notification["title"] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(notification["subtitle"] as String),
                  trailing: Text(
                    notification["time"] as String,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
