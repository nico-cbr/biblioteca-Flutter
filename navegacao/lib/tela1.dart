import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    title: Text("Cadastro de Pessoas"),
    backgroundColor: Colors.green,
  ),
);
  }

  }