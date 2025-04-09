import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Postagem{
String id;
String titulo;
String data;
String conteudo;
String imagem;
String autor;


Postagem(this.id, this.titulo,this.data,this.conteudo, this.imagem, this.autor);
}

class CadastrarPostagem extends StatefulWidget{
    final List<Postagem> Postagens;
    final String username;
  // cadastro vai receber Orfanatos
  CadastrarPostagem({required this.Postagens, required this.username});
  
  @override
  CadastrarPostagemEstado createState() => CadastrarPostagemEstado();
}

class CadastrarPostagemEstado extends State<CadastrarPostagem>{

  final tituloControle = TextEditingController();
  final dataControle = TextEditingController();
  final conteudoControle = TextEditingController();
  final imagemControle = TextEditingController();

  // criando metodo de cadastro
  Future<void> cadastrarPostagem(Postagem Postagem) async {
    if(Postagem.titulo.isNotEmpty && Postagem.conteudo.isNotEmpty){
    final url = Uri.parse("https://adota0-001-default-rtdb.firebaseio.com/Postagem.json");
    final resposta = await http.post(url, body: jsonEncode({
      "titulo": Postagem.titulo,
      "data": Postagem.data,
      "conteudo": Postagem.conteudo,
      "imagem": Postagem.imagem,
      "autor": widget.username
      }));
    }else{

    };

  }

  @override
  Widget build(BuildContext context){
    // constra o formulario de cadastro de postagem

    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de postagens", style: TextStyle(color: Colors.amber[50]),),
         backgroundColor: Colors.indigo[900],
      ),
      body: Padding(padding: EdgeInsets.all(26.0),
    child: Column(
      children: [
        Text("Cadastro de postagens", style: TextStyle(fontSize: 30)),
        SizedBox(
              height: 20,
            ),
        TextField(controller: tituloControle, decoration: InputDecoration(labelText:"titulo da postagem", 
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.title_rounded),
        prefixIconColor: Colors.grey,
        ),),
        SizedBox(
              height: 20,
            ),

        TextField(controller: dataControle, decoration: InputDecoration(labelText:"data da postagem",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.calendar_month_outlined),
        prefixIconColor: Colors.grey,
        ),),
        SizedBox(
              height: 20,
            ),

        TextField(controller: conteudoControle, decoration: InputDecoration(labelText:"Conteudo da postagem",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.keyboard_alt_outlined),
        prefixIconColor: Colors.grey,
        ),
        maxLines: 4,),
        SizedBox(height: 20,),

        TextField(controller: imagemControle, decoration: InputDecoration(labelText:"Imagem da postagem",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.image_outlined),
        prefixIconColor: Colors.grey,
        ),),
        SizedBox(height: 20,),

        ElevatedButton(onPressed: (){
          setState(() {
            Postagem PostagemNova = Postagem(
              "",
              tituloControle.text,
              dataControle.text,
              conteudoControle.text,
              imagemControle.text,
              ""
            );
            widget.Postagens.add(PostagemNova);
            cadastrarPostagem(PostagemNova);
            tituloControle.clear();
            dataControle.clear();
            conteudoControle.clear();
            imagemControle.clear();
          });
        },style: ElevatedButton.styleFrom(foregroundColor: Colors.amber.shade50, backgroundColor: Colors.indigo.shade900,  ),child: Text("salvar")),
      ],
    ),
    ),
    );
  }
}

class verPostagens extends StatelessWidget{
  Future<List<Map<String, dynamic>>> buscarPostagem() async{
    final url = Uri.parse("https://adota0-001-default-rtdb.firebaseio.com/Postagem.json");
    final resposta = await http.get(url);
    final Map<String, dynamic> dados = jsonDecode(resposta.body);
  //  criando lista de objetos post
  final List<Map<String, dynamic>> posts = [];
  dados.forEach((key, valor) {
    posts.add({
      'titulo': valor['titulo'], // Adjusted to match the correct key casing
      'conteudo': valor['conteudo'], // Adjusted to match the correct key casing
      'autor': valor['autor'], // Assuming 'autor' casing is correct
      'imagem': valor['imagem'], // Adjusted to match the correct key casing
    });
  });
  return posts;
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Notícias"),
      backgroundColor: Colors.indigo.shade900,
      foregroundColor: Colors.amber.shade50,
      ),
      body: FutureBuilder<List<Map<String,dynamic>>>(
        future: buscarPostagem(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Center(child: Text("Erro ao caregaar as postagens!"),);
          }
          if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text("Sem postagens para exibir"),);
          }
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index){
              final post = posts[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  children: [
                  post['imagem'] == null || post['imagem'].isEmpty ? SizedBox() : Image.network(post['imagem'], height: 200,),
                    Padding(padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post['titulo']),
                        SizedBox(height: 8,),
                        Text(post['conteudo']),
                        Text(post['autor'])
                      ],
                    ),
                    )
                  ],
                ),
              );
            },
          );
        },
      )
    );}}