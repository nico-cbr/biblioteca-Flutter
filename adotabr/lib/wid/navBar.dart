import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class navBar extends StatefulWidget{
  const navBar({Key? key}) : super(key : key);

  @override 
  _navBarState createState() => _navBarState();
}

class _navBarState extends State<navBar>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: Container(
      decoration: BoxDecoration(
        color: Colors.indigo.shade900
      ),
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
         child: GNav(
          gap: 8,
          iconSize: 28,
          backgroundColor: Colors.indigo.shade900,
          color: Colors.amber.shade50,
          activeColor: Colors.amber.shade50,
          tabBackgroundColor: Colors.indigo.shade800,
          padding: EdgeInsets.all(16),
          tabs: const[
          GButton(icon: Icons.home_outlined, text: "Inicio",),
          GButton(icon: Icons.person_2_outlined, text: "Adoções",),
          GButton(icon: Icons.people_alt_outlined, text: "Usuário",),
          GButton(icon: Icons.settings_outlined, text: "Configurações")
         ]
         ),
       ),
     ),
    );
  }
}