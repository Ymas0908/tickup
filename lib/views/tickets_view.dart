// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:tickup/composants/card_ticket.dart';
// import 'package:tickup/views/tickets_view.dart';
//
// class TicketsView extends StatefulWidget {
//   const TicketsView({super.key});
//
//   @override
//   State<TicketsView> createState() => _TicketsViewState();
// }
//
// class _TicketsViewState extends State<TicketsView> {
//   final List<Ticket> _tickets = [
//     Ticket(
//       id: '1',
//       eventName: 'Concert Jazz au Théâtre de la Ville',
//       date: DateTime.now().add(const Duration(days: 3)),
//       location: 'Théâtre de la Ville, Paris',
//       price: '45.00€',
//       ticketType: 'VIP',
//       status: 'Confirmé',
//       seat: 'Rang A, Place 12',
//     ),
//     Ticket(
//       id: '2',
//       eventName: 'Festival Electro Summer',
//       date: DateTime.now().add(const Duration(days: 10)),
//       location: 'Parc des Expositions, Lyon',
//       price: '65.00€',
//       ticketType: 'Standard',
//       status: 'Confirmé',
//       seat: 'Zone B, Place 45',
//     ),
//     Ticket(
//       id: '3',
//       eventName: 'Exposition d\'Art Contemporain',
//       date: DateTime.now().subtract(const Duration(days: 15)),
//       location: 'Musée d\'Art Moderne, Marseille',
//       price: '25.00€',
//       ticketType: 'Standard',
//       status: 'Utilisé',
//       seat: 'Entrée générale',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xfff6f6f8),
//         elevation: 0,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         title: Text(
//           "Mes tickets",
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//             fontSize: 21,
//             fontWeight: FontWeight.w700,
//             color: Colors.black87,
//           ),
//         ),
//       ),
//       body: _tickets.isEmpty
//           ? _buildEmptyState()
//           : ListView.builder(
//         itemCount: _tickets.length,
//         itemBuilder: (context, index) {
//           final ticket = _tickets[index];
//           return CardTicket(
//             ticket: ticket,
//
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildEmptyState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.confirmation_number_outlined,
//               size: 80,
//               color: Colors.grey,
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'Aucun ticket',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               'Vous n\'avez pas encore acheté de tickets.\nCommencez par explorer les événements disponibles.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 32),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigation vers les événements
//                 // Navigator.push(context, MaterialPageRoute(builder: (context) => EventsView()));
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xffD9AFA0),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text(
//                 'Explorer les événements',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }