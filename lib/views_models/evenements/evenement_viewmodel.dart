import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tickup/models/enum/type_evenement.dart';
import 'package:tickup/models/enum/type_ticket.dart';
import 'package:tickup/models/evenement_model.dart';
import 'package:tickup/ressources/utils/log_config.dart';
import 'package:tickup/web_services/services/evenements/evenements_service.dart';

class EvenementViewModel extends ChangeNotifier {
  final EvenementService evenementService;
  // final TickesService ticketService;

  EvenementViewModel({required this.evenementService});

  bool isEventLoading = false;
  String? searchQuery;

  final TextEditingController searchEventController = TextEditingController();
  final TextEditingController prixTicketController = TextEditingController();
  List<EvenementModel> evenements = [];
  List<EvenementModel> filteredEvenements = [];
  List<TypeEvenement> listTypeEvenement = [
    TypeEvenement.MATCH,
    TypeEvenement.THEATRE,
    TypeEvenement.CINEMA,
    TypeEvenement.EXPOSITION,
    TypeEvenement.CONCERT,
    TypeEvenement.FESTIVAL,
    TypeEvenement.RELEASE_PARTY,
  ];
  List<TypeTicket> listTypeTicket = [
    TypeTicket.GP,
    TypeTicket.VIP,
    TypeTicket.VVIP,
  ];
  // List<TicketModel> tickets = [];

  // void clearFilters() {
  //   selectedTypeEvenement = null;
  //   filterEvenementByType();
  // }
  // void filterByType(TypeEvenement? typeEvenement) {
  //   selectedTypeEvenement = typeEvenement;
  //   filterEvenementByType();
  // }
  EvenementModel? selectedEvenement;
  // TicketModel? selectedTicket;
  TypeEvenement? selectedTypeEvenement;
  TypeTicket? selectedTypeTicket;

  // void filterEvenementByType() {
  //   print('Filtering transactions with type: $selectedTypeEvenement');
  //   filteredEvenements = evenements.where((evenement) {
  //     return selectedTypeEvenement == null || evenement.typeEvenement == selectedTypeEvenement;
  //   }).toList();
  //   print("Filtered demandes count: ${filteredEvenements.length}");
  //
  //   notifyListeners();
  // }

  /**
   * Cette méthode permet de collecter le prix d'un ticket en fonction du type de ticket sélectionné.
   */
  // void setSelectedTypeTicket(TypeTicket typeTicket) {
  //   selectedTypeTicket = typeTicket;
  //   if (selectedEvenement != null) {
  //     switch (typeTicket) {
  //       case TypeTicket.GP:
  //         prixTicketController.text = selectedEvenement!.prixTicketGP ?? '';
  //         break;
  //       case TypeTicket.VIP:
  //         prixTicketController.text = selectedEvenement!.prixTicketVIP ?? '';
  //         break;
  //       case TypeTicket.VVIP:
  //         prixTicketController.text = selectedEvenement!.prixTicketVVIP ?? '';
  //         break;
  //     }
  //   }
  //
  //   notifyListeners();
  // }

  void setSelectedEvenement(EvenementModel evenement) {
    selectedEvenement = evenement;
    selectedTypeTicket = null;
    prixTicketController.clear();

    notifyListeners();
  }

  /**
   * Cette méthode permet de récupérer tous les tickets disponibles.
   */

  // Future<void> getAllTickets(BuildContext context) async {
  //   try {
  //     tickets = await ticketService.getAllTickets();
  //     notifyListeners();
  //     print(tickets.length.toString() + " tickets récupérés avec succès");
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print("Une erreur s'est produite: $e");
  //     }
  //   }
  // }

  // void getEvents() {
  //   evenements = [
  //     EvenementModel(
  //       nom: "Concert de Clara Dubois",
  //       urlImage: "https://lh3.googleusercontent.com/aida-public/AB6AXuBsg7owyK05DTvSuZ2UXZFni7gtb3SZawsnFJtWYg9GW1TZq06lnF_ymNq3KkccMQv_hsbotHtwjywO52JcNdajEIZbZGlwQDFArULLJsvA4nztUDJZsLZTklqbp6_wQiW4Gk2P3R763JFvpV-x24sxeKKIIURT43YZu--KGA7aSvo_c8eAADE_d-vY2dc-FCkfSJtp6NKy71f7-Tess7RzoXB5HW2xxvP41SM3_xfyKVq_EMh-JAnbhEJ7LjNiF1wF6J6q2BIj9baq",
  //       libelle: "Concert exclusif",
  //       description: "Vivez une expérience musicale unique avec Clara Dubois, l'une des artistes les plus prometteuses de sa génération.",
  //       lieu: "Théâtre Royal",
  //       prixTicketGP: "45€",
  //       prixTicketVIP: "75€",
  //       prixTicketVVIP: "120€",
  //       dateHeureEvenement: DateTime(2024, 7, 15, 20, 0), // 15 juillet 2024, 20h00
  //       // dateHeureCreation: DateTime(2024, 1, 15, 10, 0), // 15 janvier 2024, 10h00
  //       typeEvenement: TypeEvenement.CONCERT,
  //     ),
  //
  //     EvenementModel(
  //       nom: "Paris vs Lyon - Grande rencontre",
  //       urlImage: "https://lh3.googleusercontent.com/aida-public/AB6AXuAh194KmIqnkSmqQ9NkeWxmafk8YATwaDQLSDleZm8URp2p-T-Kp_r9ziM_EV4ZbnfU1HXVsbU8R-2ItSFZduHMzkTB1qqkTvlyZObFcyfXT7f4b5wayns3iIBXKGtKg7uKQp6fCs4XCzZl4zvKrPkBmChSWSlR4wgrxL9TJQwtkxVl2LN1bzL5QjQk8WESBExkW0jKXiUjNr4llTE0qfHz-P29qMc9MEZg3UlouIvdv7-67yJsH1P4h9hPhhKIC6XbjxvzDm9YKeNI",
  //       libelle: "Match de championnat",
  //       description: "Assistez à l'affrontement tant attendu entre Paris et Lyon.",
  //       lieu: "Stade de France",
  //       prixTicketGP: "65€",
  //       prixTicketVIP: "120€",
  //       prixTicketVVIP: "250€",
  //       dateHeureEvenement: DateTime(2024, 7, 20, 21, 0), // 20 juillet 2024, 21h00
  //      // dateHeureCreation: DateTime(2024, 2, 1, 15, 0), // 1 février 2024, 15h00
  //       typeEvenement: TypeEvenement.MATCH,
  //     ),
  //
  //     EvenementModel(
  //       nom: "Exposition d'art contemporain",
  //       urlImage: "https://lh3.googleusercontent.com/aida-public/AB6AXuDGUb1xKEd3W-TbxZeP7Qs4Idkx6pMdKE1QJn1UYTyQwqQEE2SlG161lnSD47Cfrh1aiT2wgCNflMWKTb2wjQGfLuzgdNzqkr5OGkzowPjBEQbfULMoOMKnTKaIesFC9kGTe0JX4Qo-hay9YuSmsujKVGRwakCKpqcCWfvyoE2Z6L74-IFT-teBzaDslfgtSeDva98BeR69lWsPbP-cBjOcSAyNj38YejklfaJqmLLx4KNhI0RL4J1HgfGWiVFkRtZR2V47IUSgi0Mp",
  //       libelle: "Exposition d'art moderne",
  //       description: "Découvrez une collection exceptionnelle d'œuvres d'art contemporain.",
  //       lieu: "Musée d'Art Contemporain",
  //       prixTicketGP: "18€",
  //       prixTicketVIP: "35€",
  //       prixTicketVVIP: "60€",
  //       dateHeureEvenement: DateTime(2024, 7, 25, 10, 0), // 25 juillet 2024, 10h00
  //      // dateHeureCreation: DateTime(2024, 2, 1, 15, 0), // 1 février 2024, 15h00
  //       typeEvenement: TypeEvenement.EXPOSITION,
  //     ),
  //
  //     EvenementModel(
  //       nom: "Le Misanthrope",
  //       urlImage: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
  //       libelle: "Comédie classique",
  //       description: "Mise en scène moderne de la célèbre pièce de Molière.",
  //       lieu: "Théâtre National",
  //       prixTicketGP: "35€",
  //       prixTicketVIP: "65€",
  //       prixTicketVVIP: "95€",
  //       dateHeureEvenement: DateTime(2024, 7, 28, 19, 30), // 28 juillet 2024, 19h30
  //      // dateHeureCreation: DateTime(2024, 2, 1, 15, 0), // 1 février 2024, 15h00
  //       typeEvenement: TypeEvenement.THEATRE,
  //     ),
  //
  //     EvenementModel(
  //       nom: "Festival de Jazz International",
  //       urlImage: "https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
  //       libelle: "Festival musical",
  //       description: "3 jours de concerts avec les plus grands noms du jazz mondial.",
  //       lieu: "Parc des Expositions",
  //       prixTicketGP: "85€",
  //       prixTicketVIP: "150€",
  //       prixTicketVVIP: "280€",
  //       dateHeureEvenement: DateTime(2024, 8, 5, 18, 0), // 5 août 2024, 18h00 (début)
  //      // dateHeureCreation: DateTime(2024, 2, 1, 15, 0), // 1 février 2024, 15h00
  //       typeEvenement: TypeEvenement.FESTIVAL,
  //     ),
  //
  //
  //
  //     EvenementModel(
  //       nom: "Première du film 'Renaissance'",
  //       urlImage: "https://images.unsplash.com/photo-1489599809516-9827b6d1cf13?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
  //       libelle: "Première cinématographique",
  //       description: "Première mondiale du nouveau film du réalisateur primé aux Oscars.",
  //       lieu: "Grand Palais",
  //       prixTicketGP: "25€",
  //       prixTicketVIP: "45€",
  //       prixTicketVVIP: "80€",
  //       dateHeureEvenement: DateTime(2024, 9, 5, 19, 0), // 5 septembre 2024, 19h00
  //       // dateHeureCreation: DateTime(2024, 3, 1, 10, 0), // 1 mars 2024, 10h00
  //       typeEvenement: TypeEvenement.CINEMA,
  //     ),
  //   ];
  //   filteredEvenements = evenements;
  //
  // }*
  /**
   * Cette méthode permet de rechercher un evenement selon le libellé
   */

  void updateSearchQueryEvenement(String query) {
    searchQuery = query;

    if (query.isEmpty) {
      filteredEvenements = evenements;
    } else {
      filteredEvenements = evenements.where((evenenemet) {
        final fullName = "${evenenemet.title}".toLowerCase();
        return fullName.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  /**
   * Cette méthode permet de récupérer tous les événements disponibles.
   */
  Future<void> getAllEvenements() async {
    try {
      isEventLoading = true;
      notifyListeners();
      evenements = await evenementService.getAllEvenements();
      filteredEvenements = evenements;
      customLogger.i('${evenements.length} événements récupérés avec succès');
    } catch (e) {
      if (kDebugMode) {
        customLogger.e("Une erreur s'est produite: $e");
      }
    } finally {
      isEventLoading = false;
      notifyListeners();
    }
  }
  // Future<void> getAllEvenements() async {
  //   try {
  //     evenements = await evenementService.getAllEvenements();
  //     filteredEvenements = evenements;
  //     customLogger.i("evenements collectés : ${evenements.length}");
  //   } catch (e) {
  //     customLogger.e("Une erreur est survenue : $e");
  //   } finally {
  //     notifyListeners();
  //   }
  // }
}
