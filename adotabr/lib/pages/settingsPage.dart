// ignore_for_file: file_names
import 'package:adotabr/wid/settingswid/opcoes.dart';
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
      ),
      body: ListView(
        children: [
          opc(),
        ],
      ),
    );
  }
  }
