import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickup/ressources/const/app_colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();

  // CHIP
  static Widget _buildChip(String label, {bool selected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Chip(
          label: Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: selected ? Colors.blue : Colors.grey.shade700,
            ),
          ),
          backgroundColor:
          selected ? Colors.blue.withOpacity(.12) : Colors.grey.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    );
  }

  // EVENT ITEM
  static Widget _eventItem({
    required String category,
    required String title,
    required String date,
    required String image,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              image,
              width: 95,
              height: 95,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),

          // TEXTS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  date,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f8),

      // APPBAR
      appBar: AppBar(
        backgroundColor: const Color(0xfff6f6f8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Événements",
          style: GoogleFonts.montserrat(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.search,
                size: 26, color: Colors.grey.shade800.withOpacity(.7)),
          )
        ],
      ),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SEARCH BAR
              TextField(
                style: GoogleFonts.montserrat(fontSize: 14),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  hintText: "Rechercher un événement...",
                  hintStyle: GoogleFonts.montserrat(
                      fontSize: 14, color: Colors.grey.shade600),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // FILTER CHIPS
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Home._buildChip("Date", selected: true),
                    Home._buildChip("Catégorie"),
                    Home._buildChip("Lieu"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // SECTION TITLE
              Text(
                "Événements à venir",
                style: GoogleFonts.montserrat(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 20),

              // EVENT CARDS
              Home._eventItem(
                category: "Musique",
                title: "Concert de Clara Dubois",
                date: "15 juillet, 2024 · Théâtre Royal",
                image:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuBsg7owyK05DTvSuZ2UXZFni7gtb3SZawsnFJtWYg9GW1TZq06lnF_ymNq3KkccMQv_hsbotHtwjywO52JcNdajEIZbZGlwQDFArULLJsvA4nztUDJZsLZTklqbp6_wQiW4Gk2P3R763JFvpV-x24sxeKKIIURT43YZu--KGA7aSvo_c8eAADE_d-vY2dc-FCkfSJtp6NKy71f7-Tess7RzoXB5HW2xxvP41SM3_xfyKVq_EMh-JAnbhEJ7LjNiF1wF6J6q2BIj9baq",
              ),
              Home._eventItem(
                category: "Sport",
                title: "Paris vs Lyon - Grande rencontre",
                date: "20 juillet, 2024 · Stade de France",
                image:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuAh194KmIqnkSmqQ9NkeWxmafk8YATwaDQLSDleZm8URp2p-T-Kp_r9ziM_EV4ZbnfU1HXVsbU8R-2ItSFZduHMzkTB1qqkTvlyZObFcyfXT7f4b5wayns3iIBXKGtKg7uKQp6fCs4XCzZl4zvKrPkBmChSWSlR4wgrxL9TJQwtkxVl2LN1bzL5QjQk8WESBExkW0jKXiUjNr4llTE0qfHz-P29qMc9MEZg3UlouIvdv7-67yJsH1P4h9hPhhKIC6XbjxvzDm9YKeNI",
              ),
              Home._eventItem(
                category: "Art",
                title: "Exposition d’art contemporain",
                date: "25 juillet, 2024 · Musée d’Art Contemporain",
                image:
                "https://lh3.googleusercontent.com/aida-public/AB6AXuDGUb1xKEd3W-TbxZeP7Qs4Idkx6pMdKE1QJn1UYTyQwqQEE2SlG161lnSD47Cfrh1aiT2wgCNflMWKTb2wjQGfLuzgdNzqkr5OGkzowPjBEQbfULMoOMKnTKaIesFC9kGTe0JX4Qo-hay9YuSmsujKVGRwakCKpqcCWfvyoE2Z6L74-IFT-teBzaDslfgtSeDva98BeR69lWsPbP-cBjOcSAyNj38YejklfaJqmLLx4KNhI0RL4J1HgfGWiVFkRtZR2V47IUSgi0Mp",
              ),
            ],
          ),
        ),
      ),

      // FOOTER NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xfff6f6f8),
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: Colors.grey.shade500,
        currentIndex: 0,
        selectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Événements",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: "Mes Billets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
