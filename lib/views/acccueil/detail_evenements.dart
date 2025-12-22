import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/composants/showDetailTicket.dart';
import 'package:tickup/models/enum/type_evenement.dart';
import 'package:tickup/models/evenement_model.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/ressources/utils/format_date.dart';
import 'package:tickup/views_models/evenements/evenement_viewmodel.dart';

class DetailEvenements extends StatefulWidget {
  const DetailEvenements({super.key});

  @override
  State<DetailEvenements> createState() => _DetailEvenementsState();
}

class _DetailEvenementsState extends State<DetailEvenements> {
  late ScrollController _scrollController;
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final newOpacity = min(1.0, offset / 100);
    if (newOpacity != _appBarOpacity) {
      setState(() {
        _appBarOpacity = newOpacity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EvenementViewModel>(
      builder: (context, viewModel, child) {
        final evenement = viewModel.selectedEvenement;
        if (evenement == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // AppBar avec effet de parallaxe
              SliverAppBar(
                expandedHeight: 350,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Image de l'événement
                      Hero(
                        tag: 'event-image-${evenement.id}',
                        child: Image.network(
                          evenement.urlImage ?? "",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              child: Center(
                                child: Icon(
                                  Icons.event,
                                  size: 100,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      // Informations sur l'image
                      Positioned(
                        bottom: 30,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badge catégorie
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getCategoryColor(evenement.typeEvenement),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                evenement.typeEvenement.name.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            // Titre
                            Text(
                              evenement.nom ?? "",
                              style: GoogleFonts.montserrat(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            // Lieu et date
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  evenement.lieu,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                pinned: true,
                backgroundColor: Colors.white.withOpacity(_appBarOpacity),
                elevation: _appBarOpacity > 0 ? 4 : 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.black87,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.share_outlined),
                        color: Colors.black87,
                        onPressed: _shareEvent,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white.withOpacity(0.9),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: IconButton(
                  //       // icon: Icon(
                  //       //   viewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                  //       //   color: viewModel.isFavorite ? Colors.red : Colors.black87,
                  //       // ),
                  //       onPressed: () {
                  //         // viewModel.toggleFavorite();
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              // Contenu principal
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Section Date et Heure
                      _buildSection(
                        context,
                        title: "Date & Heure",
                        icon: Icons.calendar_today_outlined,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 20,
                                  color: AppColors.primaryBlue,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    formatDateTime(evenement.dateHeureEvenement),
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section Description
                      _buildSection(
                        context,
                        title: "Description",
                        icon: Icons.description_outlined,
                        child: Text(
                          evenement.description,
                          style: GoogleFonts.montserrat(
                            fontSize: 15,
                            height: 1.6,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section Prix
                      _buildSection(
                        context,
                        title: "Options de billets",
                        icon: Icons.confirmation_number_outlined,
                        child: Column(
                          children: [
                            if (evenement.prixTicketGP != null)
                              _buildTicketOption(
                                "Ticket Général",
                                evenement.prixTicketGP!,
                                Icons.star_border_outlined,
                              ),
                            if (evenement.prixTicketVIP != null)
                              _buildTicketOption(
                                "Ticket VIP",
                                evenement.prixTicketVIP!,
                                Icons.star_half_outlined,
                                isPopular: true,
                              ),
                            if (evenement.prixTicketVVIP != null)
                              _buildTicketOption(
                                "Ticket VVIP",
                                evenement.prixTicketVVIP!,
                                Icons.star_outlined,
                                isPremium: true,
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Section Organisateur
                      _buildSection(
                        context,
                        title: "Informations pratiques",
                        icon: Icons.info_outline,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoItem(
                              Icons.accessibility_new,
                              "Accessibilité",
                              "Accessible aux personnes à mobilité réduite",
                            ),
                            const SizedBox(height: 12),
                            _buildInfoItem(
                              Icons.child_care,
                              "Âge minimum",
                              "Tout public",
                            ),
                            const SizedBox(height: 12),
                            _buildInfoItem(
                              Icons.language,
                              "Langue",
                              "Français",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Bouton de réservation sticky
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Prix minimum
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "À partir de",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Text(
                                    evenement.prixTicketGP ?? "Gratuit",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Bouton réserver
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _showTicketBottomSheet(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBlue,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 24,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.shopping_cart_outlined, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Réserver",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildTicketOption(String title, String price, IconData icon, {
    bool isPopular = false,
    bool isPremium = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isPopular
              ? Colors.orange.shade100
              : isPremium
              ? Colors.purple.shade100
              : Colors.grey.shade200,
          width: isPopular || isPremium ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isPopular
                  ? Colors.orange.shade50
                  : isPremium
                  ? Colors.purple.shade50
                  : Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isPopular
                  ? Colors.orange
                  : isPremium
                  ? Colors.purple
                  : AppColors.primaryBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (isPopular)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Plus populaire",
                      style: GoogleFonts.montserrat(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange.shade800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Text(
            price,
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.montserrat(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }



  Color _getCategoryColor(TypeEvenement type) {
    final colors = {
      TypeEvenement.CONCERT: Colors.purple,
      TypeEvenement.MATCH: Colors.green,
      TypeEvenement.EXPOSITION: Colors.orange,
      TypeEvenement.THEATRE: Colors.blue,
      TypeEvenement.FESTIVAL: Colors.pink,

      TypeEvenement.CINEMA: Colors.deepPurple,
    };
    return colors[type] ?? AppColors.primaryBlue;
  }

  void _shareEvent() {
    // Logique de partage
  }

  void _showTicketBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const ShowDetailTicket(),
    );
  }
}