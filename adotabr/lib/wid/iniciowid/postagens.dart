// ignore_for_file: camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      body: FutureBuilder<List<Map<String,dynamic>>>(
        future: buscarPostagem(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.indigo.shade900,));
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
  itemBuilder: (context, index) {
    final post = posts[index];
    return Card(
      color: Colors.white, // Fundo cinza claro
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem no topo
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            child: post['imagem'] == null || post['imagem'].isEmpty
                ? SizedBox(height: 200, child: Center(child: Icon(Icons.image, size: 50)))
                : Image.network(
                    post['imagem'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: 12),
          // Título e data
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Título
                Expanded(
                  child: Text(
                    post['titulo'] ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22, // Título maior
                      color: Colors.black, // Cor preta
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Bolinha amarela com data
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    post['data'] ?? '28/04', // Aqui mostra a data
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          // Conteúdo
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              post['conteudo'] ?? '',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Autor: ${post['autor'] ?? ''}",
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  },
);

        },
      )
    );}}