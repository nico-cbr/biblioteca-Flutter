// ignore_for_file: camel_case_types
import 'package:adotabr/wid/appBar.dart';
import 'package:adotabr/wid/iniciowid/postagens.dart';
import 'package:adotabr/wid/iniciowid/progresso.dart';
import 'package:flutter/material.dart';
import '/wid/iniciowid/posicao.dart';

class inicioPg extends StatefulWidget {
  final String nomeUsuario;
  const inicioPg({super.key, required this.nomeUsuario});

  @override
  _inicioPgState createState() => _inicioPgState();
}

class _inicioPgState extends State<inicioPg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_bar(nomeUsuario: widget.nomeUsuario),
      
      // CORPO COM SLIVERS
      body: CustomScrollView(
        slivers: [
          // seu card de posição
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: verPosicao(),
            ),
          ),
          
          // seu card de progresso
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: verProgresso(),
            ),
          ),
          
          // botão de espaçamento extra, se quiser
          SliverToBoxAdapter(child: SizedBox(height: 16)),
          
          // lista de postagens preenchendo o resto
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: verPostagens(),
            ),
          ),
        ],
      ),
    );
  }
}
