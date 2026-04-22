import 'package:flutter/material.dart';

class BotaoVoltarMenu extends StatelessWidget {
  const BotaoVoltarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Início",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: "Resumo",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: "Carteira",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: "Conversas",
        ),
      ],
    );
  }
}