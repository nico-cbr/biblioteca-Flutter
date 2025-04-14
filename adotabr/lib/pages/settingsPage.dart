// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: ListView(
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
            onTap: () {},
          ),
          _buildSettingsTile(
            icon: Icons.delete_outline,
            title: "Apagar conta",
            onTap: () {},
            titleColor: Colors.redAccent,
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
}
