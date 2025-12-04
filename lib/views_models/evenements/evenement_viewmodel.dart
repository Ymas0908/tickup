




import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tickup/models/enum/type_evenement.dart';
import 'package:tickup/models/enum/type_ticket.dart';
import 'package:tickup/models/evenement_model.dart';
import 'package:tickup/web_services/services/evenements/evenements_service.dart';

class EvenementViewModel extends ChangeNotifier {
  final EvenementService evenementService;
  // final TickesService ticketService;

  EvenementViewModel({required this.evenementService,});

  bool _isEventLoading = false;

  bool get isEventLoading => _isEventLoading;




  final TextEditingController searchEventController = TextEditingController();
  final TextEditingController prixTicketController = TextEditingController();
  List<EvenementModel> evenements = [];
  List<TypeEvenement> listTypeEvenement = [
    TypeEvenement.MATCH,
    TypeEvenement.THEATRE,
    TypeEvenement.CINEMA,
    TypeEvenement.EXPOSITION,
    TypeEvenement.CONCERT,
    TypeEvenement.FESTIVAL,
    TypeEvenement.RELEASE_PARTY
  ];
  List<TypeTicket> listTypeTicket = [
    TypeTicket.GP,
    TypeTicket.VIP,
    TypeTicket.VVIP
  ];
  // List<TicketModel> tickets = [];



  EvenementModel? selectedEvenement;
  // TicketModel? selectedTicket;
  TypeEvenement? selectedTypeEvenement;
  TypeTicket? selectedTypeTicket;


  /**
   * Cette méthode permet de collecter le prix d'un ticket en fonction du type de ticket sélectionné.
   */
  void setSelectedTypeTicket(TypeTicket typeTicket) {
    selectedTypeTicket = typeTicket;
    if (selectedEvenement != null) {
      switch (typeTicket) {
        case TypeTicket.GP:
          prixTicketController.text = selectedEvenement!.prixTicketGP ?? '';
          break;
        case TypeTicket.VIP:
          prixTicketController.text = selectedEvenement!.prixTicketVIP ?? '';
          break;
        case TypeTicket.VVIP:
          prixTicketController.text = selectedEvenement!.prixTicketVVIP ?? '';
          break;
      }
    }

    notifyListeners();
  }


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

  /**
   * Cette méthode permet de récupérer tous les événements disponibles.
   */
  Future<void> getAllEvenements() async {

    try {
      _isEventLoading = true;
      notifyListeners();
      evenements = await evenementService.getAllEvenements();
      print('${evenements.length} événements récupérés avec succès');
    } catch (e) {
      if (kDebugMode) {
        print("Une erreur s'est produite: $e");
      }
    } finally {
      _isEventLoading = false;
      notifyListeners();
    }
  }



}
