// ignore_for_file: file_names

import 'package:adotabr/pages/notiPage.dart';
import 'package:adotabr/pages/userPage.dart';
import 'package:flutter/material.dart';


// ignore: camel_case_types
class app_bar extends StatelessWidget implements PreferredSizeWidget  {
    final String nomeUsuario; // Adiciona o parâmetro nomeUsuario

  const app_bar({super.key, required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: 10),
    child: Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.indigo.shade900,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), // Raio na parte inferior esquerda
            bottomRight: Radius.circular(20), // Raio na parte inferior direita
          ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage())),
          child: const CircleAvatar(
            backgroundImage: AssetImage('assets/cara.png'),
            radius: 25,
          ),
           ),
           const SizedBox(width: 10,),
           Expanded(child: Text('Olá $nomeUsuario', style: TextStyle(color: Colors.amber.shade50, fontSize: 24),)),
          IconButton(onPressed: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => GovNotificationsPage()))
          }, icon: Icon(Icons.notifications_outlined, color: Colors.amber.shade50, size: 30,)),
          ],
        ),
      ),
    ),
    );
  }
  @override
    Size get preferredSize => const Size.fromHeight(90);
}