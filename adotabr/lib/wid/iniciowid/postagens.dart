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
            itemBuilder: (context, index){
              final post = posts[index];
              return Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                shadowColor: Colors.black87,
                margin: EdgeInsets.symmetric(vertical: 40, horizontal: 35),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                  post['imagem'] == null || post['imagem'].isEmpty ? SizedBox() : Image.network(post['imagem'], height: 200,),
                    Padding(padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post['titulo']),
                        SizedBox(height: 8,),
                        Text(post['conteudo']),
                        Text("Autor: ${post['autor']}")
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