import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/views/authentification/connexion_view.dart';
import 'package:tickup/views_models/authentification/authentification_viewmodel.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  final Color _primaryColor = const Color(0xffD9AFA0);
  final Color _backgroundColor = Colors.white;
  final Color _textColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Consumer<AuthViewModel>(
        builder: (context, authVm, child) {
          final user = authVm.user;
          final userEmail = user?.email ?? 'Non connecté';
          final displayName = user?.displayName ?? 'Utilisateur';
          final isEmailVerified = user?.emailVerified ?? false;
          final photoUrl = user?.photoURL;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header avec photo de profil
                _buildProfileHeader(
                  context,
                  displayName,
                  userEmail,
                  isEmailVerified,
                  photoUrl,
                  authVm,
                ),

                const SizedBox(height: 24),

                // Informations personnelles
                _buildPersonalInfoSection(user, authVm),

                const SizedBox(height: 24),

                // Préférences
                _buildPreferencesSection(),

                const SizedBox(height: 24),

                // Actions
                _buildActionsSection(context, authVm),

                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context,
      String displayName,
      String userEmail,
      bool isEmailVerified,
      String? photoUrl,
      AuthViewModel authVm,
      ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _primaryColor.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          // Photo de profil
          Stack(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _primaryColor,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: photoUrl != null && photoUrl.isNotEmpty
                      ? Image.network(
                    photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildDefaultAvatar(displayName),
                  )
                      : _buildDefaultAvatar(displayName),
                ),
              ),

              // Badge pour changer la photo
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    onPressed: () => _changeProfilePicture(context, authVm),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Nom d'utilisateur
          Text(
            displayName,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: _textColor,
            ),
          ),

          const SizedBox(height: 8),

          // Email avec badge de vérification
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userEmail,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 8),
              if (isEmailVerified)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.verified, size: 14, color: Colors.green.shade600),
                      const SizedBox(width: 4),
                      Text(
                        'Vérifié',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // Bouton pour vérifier l'email si non vérifié
          if (!isEmailVerified) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // await authVm.sendEmailVerification(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade50,
                foregroundColor: Colors.orange.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.orange.shade200),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.warning_amber, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Vérifier mon email',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(String displayName) {
    return Container(
      color: _primaryColor.withOpacity(0.2),
      child: Center(
        child: Text(
          displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U',
          style: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: _primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection(User? user, AuthViewModel authVm) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informations personnelles',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _textColor,
            ),
          ),
          const SizedBox(height: 20),

          _buildInfoItem(
            icon: Icons.person_outline,
            title: 'Nom complet',
            value: user?.displayName ?? 'Non renseigné',
            // onTap: () => _editDisplayName(context, authVm),
          ),

          const Divider(height: 32,),

          _buildInfoItem(
            icon: Icons.email_outlined,
            title: 'Adresse email',
            value: user?.email ?? 'Non renseigné',
            // onTap: () => _editEmail(context, authVm),
          ),

          // const Divider(height: 32, color: Colors.grey.shade200),

          // _buildInfoItem(
          //   icon: Icons.phone_outlined,
          //   title: 'Téléphone',
          //   value: user?.phoneNumber ?? 'Non renseigné',
          //   onTap: () => _editPhoneNumber(context, authVm),
          // ),

          // const Divider(height: 32, color: Colors.grey.shade200),

          _buildInfoItem(
            icon: Icons.calendar_today_outlined,
            title: 'Compte créé le',
            value: user?.metadata.creationTime != null
                ? '${user!.metadata.creationTime!.day}/${user.metadata.creationTime!.month}/${user.metadata.creationTime!.year}'
                : 'Non disponible',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: _primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _textColor,
                  ),
                ),
              ],
            ),
          ),
          if (onTap != null)
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Préférences',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _textColor,
            ),
          ),
          const SizedBox(height: 20),

          _buildSwitchPreference(
            title: 'Notifications',
            subtitle: 'Recevoir des notifications push',
            value: true,
            onChanged: (value) {},
          ),

          // const Divider(height: 32, color: Colors.grey.shade200),

          _buildSwitchPreference(
            title: 'Newsletter',
            subtitle: 'Recevoir les actualités par email',
            value: true,
            onChanged: (value) {},
          ),

          // const Divider(height: 32, color: Colors.grey.shade200),

          // _buildListPreference(
          //   title: 'Thème',
          //   subtitle: 'Mode sombre ou clair',
          //   value: 'Clair',
          //   onTap: () => _changeTheme(context),
          // ),
        ],
      ),
    );
  }

  Widget _buildSwitchPreference({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: _primaryColor,
        ),
      ],
    );
  }

  Widget _buildListPreference({
    required String title,
    required String subtitle,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context, AuthViewModel authVm) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Actions',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: _textColor,
            ),
          ),
          const SizedBox(height: 16),

          _buildActionButton(
            icon: Icons.lock_outline,
            title: 'Changer le mot de passe',
            color: Colors.blue,
            onTap: () => _changePassword(context, authVm),
          ),

          const SizedBox(height: 12),

          _buildActionButton(
            icon: Icons.help_outline,
            title: 'Centre d\'aide',
            color: Colors.purple,
            onTap: () => _showHelpCenter(context),
          ),

          const SizedBox(height: 12),

          _buildActionButton(
            icon: Icons.privacy_tip_outlined,
            title: 'Politique de confidentialité',
            color: Colors.green,
            onTap: () => _showPrivacyPolicy(context),
          ),

          const SizedBox(height: 12),

          // _buildActionButton(
          //   icon: Icons.delete_outline,
          //   title: 'Supprimer mon compte',
          //   color: Colors.red,
          //   onTap: () => _deleteAccount(context, authVm),
          // ),

          const SizedBox(height: 24),

          // Bouton de déconnexion
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _confirmLogout(context, authVm),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.red.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Se déconnecter',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _textColor,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthodes pour les actions
  void _changeProfilePicture(BuildContext context, AuthViewModel authVm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Changer la photo de profil',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            _buildOptionButton(
              icon: Icons.photo_library,
              title: 'Choisir depuis la galerie',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implémenter la sélection depuis la galerie
              },
            ),
            const SizedBox(height: 12),
            _buildOptionButton(
              icon: Icons.camera_alt,
              title: 'Prendre une photo',
              onTap: () {
                Navigator.pop(context);
                // TODO: Implémenter la prise de photo
              },
            ),
            const SizedBox(height: 12),
            _buildOptionButton(
              icon: Icons.delete,
              title: 'Supprimer la photo',
              color: Colors.red,
              onTap: () {
                Navigator.pop(context);
                // TODO: Implémenter la suppression de photo
              },
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String title,
    Color? color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: color ?? _primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }





  void _changePassword(BuildContext context, AuthViewModel authVm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Changer le mot de passe'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: authVm.passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nouveau mot de passe',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmer le mot de passe',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              // TODO: Implémenter la validation et le changement de mot de passe
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Changer'),
          ),
        ],
      ),
    );
  }

  void _showHelpCenter(BuildContext context) {
    // TODO: Implémenter le centre d'aide
  }

  void _showPrivacyPolicy(BuildContext context) {
    // TODO: Implémenter la politique de confidentialité
  }

  // void _deleteAccount(BuildContext context, AuthViewModel authVm) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Supprimer le compte'),
  //       content: const Text(
  //         'Êtes-vous sûr de vouloir supprimer votre compte? '
  //             'Cette action est irréversible et toutes vos données seront perdues.',
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Annuler'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () async {
  //             await authVm.deleteAccount(context: context);
  //             Navigator.pop(context);
  //           },
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: Colors.red,
  //             foregroundColor: Colors.white,
  //           ),
  //           child: const Text('Supprimer'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _confirmLogout(BuildContext context, AuthViewModel authVm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Se déconnecter'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await authVm.signout(context);
              // Rediriger vers la page de connexion
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ConnexionView()),
                    (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Se déconnecter'),
          ),
        ],
      ),
    );
  }
}