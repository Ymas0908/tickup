import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/authentification/connexion_view2.dart';
import 'package:tickup/views_models/authentification/authentification_viewmodel.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final Color _primaryBlue = const Color(0xffD9AFA0);
  final Color _backgroundColor = Colors.white;
  final Color _textColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        title: Text(
          'Profil',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const ConnexionView2(),
                ),
                (route) => false,
              );
            },
            icon: Icon(Icons.logout, color: AppColors.red),
          ),
        ],
      ),
      body: Consumer<AuthentificationViewmodel>(
        builder: (context, authVm, child) {
          final user = authVm.userConnected;

          if (user == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun utilisateur connecté',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Photo de profil et informations principales
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.primaryBlue,
                        child: Text(
                          getUserInitials(user.nom, user.prenom),
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${user.prenom ?? ''} ${user.nom ?? ''}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user.email ?? 'Email non disponible',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Informations personnelles
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informations personnelles',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 16),

                        _buildInfoRow(
                          context,
                          'Nom complet',
                          '${user.prenom ?? ''} ${user.nom ?? ''}',
                          Icons.person,
                        ),

                        _buildInfoRow(
                          context,
                          'Email',
                          user.email ?? 'Non renseigné',
                          Icons.email,
                        ),

                        _buildInfoRow(
                          context,
                          'Téléphone',
                          user.telephone ?? 'Non renseigné',
                          Icons.phone,
                        ),

                        _buildInfoRow(
                          context,
                          'Date de naissance',
                          user.dateNaissance ?? 'Non renseignée',
                          Icons.cake,
                        ),

                        _buildInfoRow(
                          context,
                          'Référence utilisateur',
                          user.refUsager ?? 'Non disponible',
                          Icons.fingerprint,
                        ),

                        if (user.terminalId != null)
                          _buildInfoRow(
                            context,
                            'ID Terminal',
                            user.terminalId!,
                            Icons.devices,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.primaryBlue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getUserInitials(String? nom, String? prenom) {
    String initials = '';

    if (prenom != null && prenom.isNotEmpty) {
      initials += prenom[0].toUpperCase();
    }

    if (nom != null && nom.isNotEmpty) {
      initials += nom[0].toUpperCase();
    }

    return initials.isEmpty ? 'U' : initials;
  }
}
