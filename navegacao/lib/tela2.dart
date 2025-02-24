import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:navegacao/tela1.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class TabelaPai extends StatefulWidget{

  @override
  Tabela createState() => Tabela();
}

class Tabela extends State<TabelaPai>{
  final List<Pessoa> pessoas = [];

@override  
void initState(){
  super.initState();
  buscarPessoas();
  }
  // Tabela({required this.pessoas})

  Future<void> buscarPessoas() async {
     final url = Uri.parse("https://adota0-001-default-rtdb.firebaseio.com/pessoa.json");
    final resposta = await http.get(url);
    final Map<String, dynamic> ? dados = jsonDecode(resposta.body);
    print(dados);
  }

 Future<void> abrirWhats(String telefone) async {
  final Uri url = Uri.parse('https://wa.me/$telefone');
  if (!await launchUrl(url)){
    throw Exception('Não pode iniciar $url');
  }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de contatos", style: TextStyle(color: Colors.amber[50]),), 
        backgroundColor: Colors.indigo[900],

      ),
      body: Padding(padding: EdgeInsets.all(16.0),
       child: 
       ListView.builder(
        itemCount: pessoas.length, // quantidade de itens na lista
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.people_alt),
            title: Text(pessoas[index].nome),
            subtitle: Text(
              "Tel: " + pessoas[index].telefone +
              "\n email: " + pessoas[index].email +
              "\n endereco: " + pessoas[index].endereco +
              "\n cidade: " + pessoas[index].cidade
            ),
            trailing: IconButton(onPressed: () => abrirWhats(pessoas[index].telefone), icon: Icon(Icons.message_rounded))
          );
        },
       )
       )
    );
  }
}