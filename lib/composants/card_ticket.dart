import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tickup/ressources/utils/format_date.dart';

class CardTicket extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback? onTap;
  final VoidCallback? onShowQRCode;
  final bool showQRButton;

  const CardTicket({
    super.key,
    required this.ticket,
    this.onTap,
    this.onShowQRCode,
    this.showQRButton = true,
  });

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête avec statut
              // _buildHeader(isPast),

              const SizedBox(height: 12),

              // Nom de l'événement
              _buildEventName(),

              const SizedBox(height: 12),

              // Informations
              _buildInfoRow(
                icon: Icons.calendar_today_outlined,
                text: '${formatDate(ticket.date)} • ${formatDate(ticket.date)}',
              ),

              const SizedBox(height: 8),

              _buildInfoRow(
                icon: Icons.location_on_outlined,
                text: ticket.location,
              ),

              const SizedBox(height: 8),

              _buildInfoRow(
                icon: Icons.chair_outlined,
                text: ticket.seat,
              ),

              const SizedBox(height: 16),

              // Footer avec prix et actions
              // _buildFooter(isPast),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isPast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Badge de statut
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor().withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _getStatusColor().withOpacity(0.3),
            ),
          ),
          child: Text(
            ticket.status,
            style: TextStyle(
              color: _getStatusColor(),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Jours restants (seulement si futur)
        if (!isPast)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, size: 12, color: Colors.blue),
                const SizedBox(width: 4),
                Text(
                  '${ticket.date.difference(DateTime.now()).inDays} jours',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildEventName() {
    return Text(
      ticket.eventName,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(bool isPast) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Prix
        Text(
          ticket.price,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xffD9AFA0),
          ),
        ),

        // Bouton QR Code
        if (showQRButton && !isPast)
          ElevatedButton(
            onPressed: onShowQRCode,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffD9AFA0),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Row(
              children: [
                Icon(Icons.qr_code, size: 18),
                SizedBox(width: 6),
                Text('QR Code'),
              ],
            ),
          ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (ticket.status.toLowerCase()) {
      case 'confirmé':
      case 'confirmed':
        return Colors.green;
      case 'utilisé':
      case 'used':
        return Colors.blue;
      case 'annulé':
      case 'cancelled':
        return Colors.red;
      case 'en attente':
      case 'pending':
        return Colors.orange;
      case 'expiré':
      case 'expired':
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }
}

// Modèle de ticket (à mettre dans un fichier séparé si besoin)
class Ticket {
  final String id;
  final String eventName;
  final DateTime date;
  final String location;
  final String price;
  final String ticketType;
  final String status;
  final String seat;

  const Ticket({
    required this.id,
    required this.eventName,
    required this.date,
    required this.location,
    required this.price,
    required this.ticketType,
    required this.status,
    required this.seat,
  });
}