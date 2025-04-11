import 'package:flutter/material.dart';
import '/wid/navBar.dart';
import '/wid/iniciowid/posicao.dart';

class inicioPg extends StatefulWidget{
  const inicioPg({Key? key, required String nomeUsuario}) : super(key : key);

  @override 
  _inicioPgState createState() => _inicioPgState();
}

class _inicioPgState extends State<inicioPg>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // posição wid
          Padding(padding: EdgeInsets.all(10),
          child: Text("Posição"),
          ),
          verPosicao(),
        ],
      ),
      
      // navbar 
        bottomNavigationBar: Container(
          height: 150,
          child: navBar(),
        ),
    );
  }
}