// ignore_for_file: camel_case_types, unnecessary_to_list_in_spreads

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class adocPage extends StatefulWidget {
  const adocPage({super.key});

  @override
  State<adocPage> createState() => _adocPageState();
}

class _adocPageState extends State<adocPage> {
  bool reconhecimentoFeito = false;

  Future<List<Map<String, dynamic>>> buscarCriancas() async {
    final url = Uri.parse(
      "https://adota0-001-default-rtdb.firebaseio.com/Crianca.json",
    );
    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      final Map<String, dynamic> dados = jsonDecode(resposta.body);
      final List<Map<String, dynamic>> criancas = [];

      dados.forEach((key, valor) {
        criancas.add({
          'nome': valor['nome'] ?? 'Sem nome',
          'idade': valor['idade'] ?? 0,
          'irmaos': valor['irmaos'] ?? 0,
          'local': valor['local'] ?? 'Desconhecido',
          'descricao': valor['descricao'] ?? '',
        });
      });

      return criancas;
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoção"),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: buscarCriancas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Nenhuma criança encontrada."));
            }

            final criancas = snapshot.data!;

            if (!reconhecimentoFeito) {
              return Center(
                child: SingleChildScrollView(
                  child: _buildReconhecimentoFacialCard(),
                ),
              );
            } else {
              return ListView(
                children: [
                  const SizedBox(height: 20),
                  ...criancas.map((c) => _buildCriancaCard(c)).toList(),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton.icon(
                      onPressed: () {
                        // suporte
                      },
                      icon: const Icon(
                        Icons.support_agent,
                        color: Colors.indigo,
                      ),
                      label: const Text(
                        'Contatar Suporte',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildReconhecimentoFacialCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Crianças com perfil compatível",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  "Atenção",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Realize o reconhecimento facial para prosseguir.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      reconhecimentoFeito = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Prosseguir",
                    style: TextStyle(color: Colors.amber.shade50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCriancaCard(Map<String, dynamic> crianca) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            crianca['nome'],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text("Idade: ${crianca['idade']}"),
              const SizedBox(width: 16),
              Text("Irmãos: ${crianca['irmaos']}"),
            ],
          ),
          const SizedBox(height: 4),
          Text("Local: ${crianca['local']}"),
          const SizedBox(height: 8),
          Text(crianca['descricao']),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                // entrar em contato
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Entrar em contato",
                style: TextStyle(color: Color.fromRGBO(255, 248, 225, 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 2),
          blurRadius: 2,
          spreadRadius: 2,
        ),
      ],
    );
  }
}
