// ignore_for_file: camel_case_types

import 'package:adotabr/pages/adocPage.dart';
import 'package:adotabr/pages/dmPage.dart';
import 'package:adotabr/pages/iniciopg.dart';
import 'package:adotabr/pages/settingsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const inicioPg(nomeUsuario: 'Usuário',),
    dmPage(),
    const Adocpage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.indigo.shade900,
        ),
        child: GNav(
          tabMargin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          curve: Curves.linear,
          gap: 8,
          iconSize: 28,
          backgroundColor: Colors.grey.shade100,
          color: Colors.black,
          activeColor: Colors.black,
          tabBackgroundColor: Colors.amber.shade50,
          padding: const EdgeInsets.all(10),
          tabs: const [
            GButton(icon: Icons.home_outlined, text: "Início"),
            GButton(icon: CupertinoIcons.cube_box, text: "Mensagens"),
            GButton(icon: Icons.person_2_outlined, text: "Adoções"),
            GButton(icon: Icons.settings_outlined, text: "Configurações"),
          ],
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
