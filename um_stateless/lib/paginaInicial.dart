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

           Text("Conteúdo da página inicial")
         ],
        ),
      ),
      )
    );
  }
}