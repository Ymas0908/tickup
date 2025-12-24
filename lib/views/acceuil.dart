import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/acccueil/home.dart';
import 'package:tickup/views/profil_view.dart';
import 'package:tickup/views/tickets_view.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  int _currentIndex = 0;




  // Les différentes pages correspondant à chaque onglet
  final List<Widget> _pages = [
    const Home(),
    const TicketsView(),
    const ProfilView(),

  ];
  // final List<String> _appBarTitles = [
  //   "Accueil",
  //   "Services",
  //   "Clients",
  //   "Compte",
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(_appBarTitles[_currentIndex]),
      //   backgroundColor: AppColors.primaryColor,
      //   foregroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: Colors.grey.shade600,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryBlue,
            icon: Icon(Icons.calendar_month),
            label: "Événements",
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryBlue,

            icon: Icon(Icons.confirmation_num),
            label: "Mes Tickets",
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.primaryBlue,
            icon: Icon(Icons.person),
            label: "Profil",
          ),

        ],
      ),
    );
  }
}
