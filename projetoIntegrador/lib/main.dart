import 'package:flutter/material.dart';
import 'package:navegacao/tela1.dart';
import 'package:navegacao/tela2.dart';
import 'package:navegacao/tela3.dart';
import 'package:navegacao/tela4.dart';
import 'package:navegacao/postagem.dart';


// Classe principal inicia o projeto

// Classe pai que confura todo nosso app herda tipo stateless
class Aplicativo extends StatelessWidget {
  final List<Orfanato> Orfanatos = [];
  final List<Postagem> Postagens = [];
  final String nomeUsuario;
  Aplicativo({required this.nomeUsuario});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Menu Principal',
      home: Menu(),
      debugShowCheckedModeBanner: false,
      routes: {
       '/tela1': (context) => Cadastro(Orfanatos:Orfanatos),
        '/tela2': (context) => TabelaPai(),
        '/tela3': (context) => CadastrarPostagem(username:nomeUsuario, Postagens:Postagens),
        '/tela4': (context) =>  verPostagens(),
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
          Botao(texto: 'Cadastrar', rota:'/tela1', icone: Icons.person_add_alt_1_sharp, cor:  Colors.amber.shade50),
          Botao(texto: 'Listar', rota:'/tela2', icone: Icons.list_alt_rounded, cor: Colors.amber.shade50),
          Botao(texto: 'Criar postagem', rota:'/tela3', icone: Icons.add, cor: Colors.amber.shade50),
          Botao(texto: 'Notícias', rota:'/tela4', icone: Icons.newspaper_outlined, cor: Colors.amber.shade50),
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
            Icon(icone, color: cor, size: 30),
            Text(texto, style: TextStyle(color: cor, fontSize: 20.0),)
          ],
        ),

      ),
      );
  }}