// ignore_for_file: camel_case_types
import 'package:adotabr/wid/appBar.dart';
import 'package:adotabr/wid/iniciowid/postagens.dart';
import 'package:adotabr/wid/iniciowid/progresso.dart';
import 'package:flutter/material.dart';
import '/wid/iniciowid/posicao.dart';

class inicioPg extends StatefulWidget{
  final String nomeUsuario;
  const inicioPg({super.key, required this.nomeUsuario});
  @override 
  // ignore: library_private_types_in_public_api
  _inicioPgState createState() => _inicioPgState();
}

class _inicioPgState extends State<inicioPg>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(nomeUsuario: widget.nomeUsuario),
      body: Column(
        children: [
  // ! posição wid
          verPosicao(),
          verProgresso(),
          Expanded(child: verPostagens())
        ],
      ),
    );
  }
}