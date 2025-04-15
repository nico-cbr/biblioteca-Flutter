// ignore_for_file: unused_element

import 'package:adotabr/pages/login.dart';
import 'package:flutter/material.dart';

class opc extends StatefulWidget {
  const opc({super.key});

  @override
  State<opc> createState() => _opcState();
}

class _opcState extends State<opc> {
  bool isNotificationOn = true; // Estado do switch

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildSectionTitle("Geral"),
          _buildSettingsTile(
            icon: Icons.color_lens,
            title: "Alterar tema",
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.accessibility,
            title: "Acessibilidade",
            onTap: () {},
          ),
          _buildSwitchTile(
            icon: Icons.notifications_active,
            title: "Notificações",
            value: isNotificationOn,
            onChanged: (value) {
              setState(() {
                isNotificationOn = value;
              });
            },
          ),
          _buildSectionTitle("Ajuda"),
          _buildSettingsTile(
            icon: Icons.feedback_outlined,
            title: "Enviar feedback",
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.support_agent,
            title: "Contatar suporte",
            onTap: () {},
          ),
          _buildSectionTitle("Conta"),
          _buildSettingsTile(
            icon: Icons.privacy_tip,
            title: "Termos de uso e privacidade",
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: "Alterar senha",
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.exit_to_app,
            title: "Sair deste aparelho",
            titleColor: Colors.redAccent,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.indigo.shade900,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo.shade900),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.black87,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.indigo.shade900),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.indigo,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}


Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.indigo.shade900,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo.shade900),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.black87,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }