import 'package:flutter/material.dart';
import 'package:navegacao/tela1.dart';

class Detalhes extends StatelessWidget{
  final Pessoa pessoa;

  // passando parâmetro da pessoa especifica
  Detalhes({required this.pessoa});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes do contato"),
      backgroundColor: Colors.amber.shade50,
      )
    );
  }}