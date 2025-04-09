import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Criando a classe Orfanato que vai fabricar Orfanatos
class Orfanato {
  String id;
  String nome; 
  String cnpj; 
  String email;
  String telefone;
  String endereco;
  String cidade;

  Orfanato(this.id, this.nome,this.cnpj, this.email, this.telefone, this.endereco, this.cidade);
}

class Cadastro extends StatefulWidget{
  final List<Orfanato> Orfanatos;
  // cadastro vai receber Orfanatos
  Cadastro({required this.Orfanatos});

  @override
  // ignore: library_private_types_in_public_api
  _CadastroState createState() => _CadastroState();

}
  class _CadastroState extends State<Cadastro>{
    // controles do forms
  final nomeControle = TextEditingController();
  final cnpjControle = TextEditingController();
  final emailControle = TextEditingController();
  final telefoneControle = TextEditingController();
  final enderecoControle = TextEditingController();
  final cidadeControle = TextEditingController();

  // criando metodo de cadastro
  Future<void> cadastrarOrfanato(Orfanato Orfanato) async {
    final url = Uri.parse("https://adota0-001-default-rtdb.firebaseio.com/Orfanato.json");
    final resposta = await http.post(url, body: jsonEncode({
      "nome": Orfanato.nome,
      "cnpj": Orfanato.cnpj,
      "email": Orfanato.email,
      "telefone": Orfanato.telefone,
      "endereco": Orfanato.endereco,
      "cidade": Orfanato.cidade,
      }));
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: Text("Cadastro de estabelecimentos", style: TextStyle(color: Colors.amber[50]),),
    backgroundColor: Colors.indigo[900],
  ),

  body: Padding(padding: EdgeInsets.all(16.0),
  child: Column(
    children: [
      Text("Cadastro de estabelecimentos", style: TextStyle(fontSize: 30),),
      TextField(controller: nomeControle, decoration: InputDecoration(labelText: "Nome do estabelecimento"),),
      TextField(controller: cnpjControle, decoration: InputDecoration(labelText: "cnpj"),),
      TextField(controller: emailControle, decoration: InputDecoration(labelText: "email"),),
      TextField(controller: telefoneControle, decoration: InputDecoration(labelText: "telefone"),),
      TextField(controller: enderecoControle, decoration: InputDecoration(labelText: "endereco"),),
      TextField(controller: cidadeControle, decoration: InputDecoration(labelText: "cidade"),),
      SizedBox(height: 20,),

      ElevatedButton(onPressed: () 
      // setState atualiza toda tela na hora
      {setState(() {
        // criação de um novo objeto Orfanato "Ex: seu airlindo"
        Orfanato OrfanatoNova = Orfanato(
          "",
          nomeControle.text,
          cnpjControle.text,
          emailControle.text,
          telefoneControle.text,
          enderecoControle.text,
          cidadeControle.text,
        );
        // cadastrarOrfanato();
        // adicionando Orfanato "ex:Seu arlindo"
        widget.Orfanatos.add(OrfanatoNova);
        cadastrarOrfanato(OrfanatoNova);
        // Limpar campos
          nomeControle.clear();
          cnpjControle.clear();
          emailControle.clear();
          telefoneControle.clear();
          enderecoControle.clear();
          cidadeControle.clear();
        
      });}, style: ElevatedButton.styleFrom(foregroundColor: Colors.amber.shade50, backgroundColor: Colors.indigo.shade900,  ), 
      child: Text("salvar")
      ),

      ListTile(),
    ],
  ),),
);
  }

  }