import 'package:flutter/material.dart';
import 'package:navegacao/tela1.dart';

class Detalhes extends StatelessWidget{
  final Pessoa pessoa;

  // passando parâmetro da pessoa especifica
  Detalhes({required this.pessoa});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes do contato", style: TextStyle(color: Colors.amber.shade50),),
      backgroundColor: Colors.indigo.shade900,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Icon(Icons.person, size: 100, color: Colors.indigo.shade600 ),
              SizedBox(height: 20),
              Text(pessoa.nome, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("Nome: ${pessoa.nome}", style: TextStyle(fontSize: 18)),
              Text("Email: ${pessoa.email}", style: TextStyle(fontSize: 18)),
              Text("Telefone: ${pessoa.telefone}", style: TextStyle(fontSize: 18)),
              Text("Endereço: ${pessoa.endereco}", style: TextStyle(fontSize: 18)),
              Text("Cidade: ${pessoa.cidade}", style: TextStyle(fontSize: 18)),

            ],
          ),
        ),
      )
    );
  }}