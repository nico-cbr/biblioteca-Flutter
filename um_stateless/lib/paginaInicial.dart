import 'package:flutter/material.dart';

// Metodo principal que inicia o app
void main(){
  // roda o que tiver dentro de PaginaInicial
  runApp(PaginaInicial());  
}

// A classe paginaInicial vai se referir a todo contexto do App classe vai hgerdar o comportamento do
// StatelessWidget, isso quer dizer o o app é estático. nao muda nada na tela 
class PaginaInicial extends StatelessWidget{
  const PaginaInicial({super.key});
  // Funçao que vai constuir as telas do app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 30, 36, 39),
          title: Text("Pagina Inicial", style: TextStyle(color: Colors.amber[50], fontSize: 30)),
        ),

      body: Center(
        child: Column(
         children: [
           Image.network('https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png', width: 300, height: 300,),

           SizedBox(height: 20,),
          Text("O que é Flutter?"),

          Text('''Flutter é um framework do Google para criar aplicativos multiplataformas.
          Serve para ndroid, IOS, Web e desktop com suporte para outros, usando a linguagem DART
          Possui Widgets, que são blocos de construção da interface no flutter, toda tela é 
          um widget, desde botões e textos até layouts mais complexos. Eles podem ser:
          ''', textAlign: TextAlign.center,),

          ListTile(leading: Icon(Icons.arrow_circle_right),
          title: Text("Statefull: com estado dinâmico, a tela muda!")),

          ListTile(leading: Icon(Icons.arrow_circle_right),
          title: Text("Stateless: Imutável, a tela sempre é a mesma!")),
         ],
        ),
      ),
      )
    );
  }
}