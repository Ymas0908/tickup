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
      //   backgroundColor: AppColors.primaryBlue,
      //   foregroundColor: Colors.white,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 0),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == 0 ? AppColors.primaryBlue.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: _currentIndex == 0 ? AppColors.primaryBlue : Colors.grey.shade500,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Evènements",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _currentIndex == 0 ? AppColors.primaryBlue : Colors.grey.shade600,
                          fontWeight: _currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 1),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == 1 ? AppColors.primaryBlue.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.confirmation_num,
                        color: _currentIndex == 1 ? AppColors.primaryBlue : Colors.grey.shade500,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tickets",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _currentIndex == 1 ? AppColors.primaryBlue : Colors.grey.shade600,
                          fontWeight: _currentIndex == 1 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 2),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == 2 ? AppColors.primaryBlue.withOpacity(0.1) : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.grid_view_outlined,
                        color: _currentIndex == 2 ? AppColors.primaryBlue : Colors.grey.shade500,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Menu",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _currentIndex == 2 ? AppColors.primaryBlue : Colors.grey.shade600,
                          fontWeight: _currentIndex == 2 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
