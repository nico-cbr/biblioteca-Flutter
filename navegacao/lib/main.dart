import 'package:flutter/material.dart';
import 'package:navegacao/tela1.dart';
import 'package:navegacao/tela2.dart';
import 'package:navegacao/tela3.dart';
import 'package:navegacao/tela4.dart';

// Classe principal inicia o projeto
void main() => runApp(Aplicativo());

// Classe pai que confura todo nosso app herda tipo stateless
class Aplicativo extends StatelessWidget {
  final List<Pessoa> pessoas = [];
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Menu Principal',
      theme: ThemeData.light(),
      home: Menu(),
      debugShowCheckedModeBanner: false,
      routes: {
       '/tela1': (context) => Cadastro(pessoas:pessoas),
        '/tela2': (context) => Tela2(),
        '/tela3': (context) => Tela3(),
        '/tela4': (context) => Tela4(),
      },
    );
      
  }

}

class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Principal", style: TextStyle(color: Colors.amber[50]),), 
        backgroundColor: Colors.indigo[900],

      ),
    body: Center(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          Botao(texto: 'Cadastrar', rota:'/tela1', icone: Icons.ac_unit, cor:  Colors.amber.shade50),
          Botao(texto: 'Listar', rota:'/tela2', icone: Icons.ac_unit, cor: Colors.amber.shade50),
          Botao(texto: 'Sobre', rota:'/tela3', icone: Icons.ac_unit, cor: Colors.amber.shade50),
          Botao(texto: 'Contato', rota:'/tela4', icone: Icons.ac_unit, cor: Colors.amber.shade50),
        ],
      ),
    ),
    );
  }
}

class Botao extends StatelessWidget {
  // variaveis que configuram um botao novo érsonalizado
  final String texto;
  final String rota;
  final IconData icone;
  final Color cor;

  Botao({Key? key, required this.texto, required this.rota, required this.icone, required this.cor});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child:  ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        onPressed: () { Navigator.pushNamed(context, rota);  },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, color: cor, size: 70),
            Text(texto, style: TextStyle(color: cor, fontSize: 20.0),)
          ],
        ),

      ),
      );
  }}