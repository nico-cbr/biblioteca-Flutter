import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Criando a classe pessoa que vai fabricar pessoas
class Pessoa {
  String nome;
  String email;
  String telefone;
  String endereco;
  String cidade;

  Pessoa(this.nome, this.email, this.telefone, this.endereco, this.cidade);
}

class Cadastro extends StatefulWidget{
  final List<Pessoa> pessoas;
  // cadastro vai receber pessoas
  Cadastro({required this.pessoas});

  @override
  // ignore: library_private_types_in_public_api
  _CadastroState createState() => _CadastroState();

}
  class _CadastroState extends State<Cadastro>{
    // controles do forms
  final nomeControle = TextEditingController();
  final emailControle = TextEditingController();
  final telefoneControle = TextEditingController();
  final enderecoControle = TextEditingController();
  final cidadeControle = TextEditingController();

  // criando metodo de cadastro
  Future<void> cadastrarPessoa() async {
    final url = Uri.parse("Link do banco");
    final resposta = await http.post(url, body:"");
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: Text("Cadastro de Pessoas", style: TextStyle(color: Colors.amber[50]),),
    backgroundColor: Colors.indigo[900],
  ),

  body: Padding(padding: EdgeInsets.all(16.0),
  child: Column(
    children: [
      Text("Cadastro de contato", style: TextStyle(fontSize: 30),),
      TextField(controller: nomeControle, decoration: InputDecoration(labelText: "Nome"),),
      TextField(controller: emailControle, decoration: InputDecoration(labelText: "email"),),
      TextField(controller: telefoneControle, decoration: InputDecoration(labelText: "telefone"),),
      TextField(controller: enderecoControle, decoration: InputDecoration(labelText: "endereco"),),
      TextField(controller: cidadeControle, decoration: InputDecoration(labelText: "cidade"),),
      SizedBox(height: 20,),

      ElevatedButton(onPressed: () 
      // setState atualiza toda tela na hora
      {setState(() {
        // criação de um novo objeto pessoa "Ex: seu airlindo"
        Pessoa pessoaNova = Pessoa(
          nomeControle.text,
          emailControle.text,
          telefoneControle.text,
          enderecoControle.text,
          cidadeControle.text,
        );
        // adicionando pessoa "ex:Seu arlindo"
        widget.pessoas.add(pessoaNova);
        print(widget.pessoas.length);
        // Limpar campos
          nomeControle.clear();
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