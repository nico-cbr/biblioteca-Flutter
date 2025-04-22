// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:adotabr/wid/navBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final String firebaseUrl = 'https://adota0-001-default-rtdb.firebaseio.com/Anonimato.json';

  // Controllers para os campos de texto
  final nomeController = TextEditingController();
  final apelidoController = TextEditingController();
  final dataNascController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final logradouroController = TextEditingController();
  final numeroController = TextEditingController();

  // Preferências
  String faixaEtaria = '5 - 15 anos';
  String numeroCriancas = 'Duas';
  String necessidadesEspeciais = 'Sim';
  String preferenciasCulturais = 'Não';

  final List<String> opcoesFaixaEtaria = ['0 - 4 anos', '5 - 15 anos', '16+ anos'];
  final List<String> opcoesNumeroCriancas = ['Uma', 'Duas', 'Três ou mais'];
  final List<String> opcoesNecessidades = ['Sim', 'Não'];
  final List<String> opcoesCulturais = ['Sim', 'Não'];

  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }

  Future<void> carregarPreferencias() async {
    final response = await http.get(Uri.parse(firebaseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data != null) {
        setState(() {
          nomeController.text = data['nomeSocial'] ?? 'Anônimato';
          apelidoController.text = data['apelido'] ?? 'Anon';
          dataNascController.text = data['dataNasc'] ?? '03/02/1982';
          telefoneController.text = data['telefone'] ?? '99 99999-9999';
          emailController.text = data['email'] ?? 'Anonimato@hotmail.com';
          logradouroController.text = data['logradouro'] ?? 'Rua do Grau';
          numeroController.text = data['numero'] ?? '21';

          faixaEtaria = data['faixaEtaria'] ?? faixaEtaria;
          numeroCriancas = data['numeroCriancas'] ?? numeroCriancas;
          necessidadesEspeciais = data['necessidadesEspeciais'] ?? necessidadesEspeciais;
          preferenciasCulturais = data['preferenciasCulturais'] ?? preferenciasCulturais;
        });
      }
    }
  }

  Future<void> salvarPreferencias() async {
    final dados = {
      'nomeSocial': nomeController.text,
      'apelido': apelidoController.text,
      'dataNasc': dataNascController.text,
      'telefone': telefoneController.text,
      'email': emailController.text,
      'logradouro': logradouroController.text,
      'numero': numeroController.text,
      'faixaEtaria': faixaEtaria,
      'numeroCriancas': numeroCriancas,
      'necessidadesEspeciais': necessidadesEspeciais,
      'preferenciasCulturais': preferenciasCulturais,
    };

    final response = await http.put(Uri.parse(firebaseUrl), body: jsonEncode(dados));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferências salvas com sucesso!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar as preferências')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_outlined),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => navBar()),
              (route) => false,
            );
          },
        ),
        title: const Row(
          children: [
            Text(' Tela Inicial'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/cara.png'),
                  ),
                  const SizedBox(height: 16),
                  buildEditableField('Nome Social:', nomeController),
                  buildEditableField('Apelido ou Nome preferido:', apelidoController),
                  buildEditableField('Data de Nasc.:', dataNascController),
                  buildEditableField('Telefone:', telefoneController),
                  buildEditableField('E-mail:', emailController),
                  buildEditableField('Logradouro:', logradouroController),
                  buildEditableField('Nº:', numeroController),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preferências de adoção',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  buildDropdownField('Faixa Etária:', faixaEtaria, opcoesFaixaEtaria,
                      (value) => setState(() => faixaEtaria = value!)),
                  buildDropdownField('Número de crianças:', numeroCriancas, opcoesNumeroCriancas,
                      (value) => setState(() => numeroCriancas = value!)),
                  buildDropdownField('Aceita crianças com necessidades especiais:', necessidadesEspeciais, opcoesNecessidades,
                      (value) => setState(() => necessidadesEspeciais = value!)),
                  buildDropdownField('Preferências regionais ou culturais:', preferenciasCulturais, opcoesCulturais,
                      (value) => setState(() => preferenciasCulturais = value!)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: salvarPreferencias,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'Salvar Preferências',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                filled: true,
                fillColor: Colors.grey[300],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownField(String label, String selectedValue, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                decoration: const InputDecoration(border: InputBorder.none),
                items: options.map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
