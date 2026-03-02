import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/composants/primary_button.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/authentification/connexion_view.dart';
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
      body: Consumer<AuthentificationViewmodel>(
        builder: (context, authVm, child) {
          // final userConnected = authVm.userConnected;
          // final userConnectedEmail = userConnected?.email ?? 'Non connecté';
          // final displayName = userConnected?.displayName ?? 'Utilisateur';
          // final isEmailVerified = userConnected?.emailVerified ?? false;
          // final photoUrl = userConnected?.photoURL;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header avec photo de profil

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.primaryBlue,
                      child: Text(
                        getUserInitials(authVm.userConnected?.nom ?? authVm.userConnected?.prenom),
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authVm.userConnected?.nom ?? authVm.userConnected?.prenom ?? "N/A",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            authVm.userConnected?.email ?? "email",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ConnexionView(),
                          ),
                              (route) => false,
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                        child: Icon(Icons.logout, color: AppColors.red),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              /// ======================
              /// CONTENU SCROLLABLE
              /// ======================
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Card(
                        elevation: 0,
                        color: AppColors.fourthBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Informations personnelles",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle:  Text("Gérer vos informations",
                                style: Theme.of(context,).textTheme.bodySmall?.copyWith(),

                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ProfilView()),
                                );
                              },
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: Text(
                                "Historique d’abonnements",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle:  Text("Consultez vos abonnements",
                                style: Theme.of(context,).textTheme.bodySmall?.copyWith(),
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {},
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      /// ======================
                      /// SECTION : SERVICES
                      /// ======================
                      Card(
                        elevation: 0,
                        color: AppColors.fourthBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Renouvellement d’abonnement",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Gérer votre abonnement",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(),
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {},
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: Text(
                                "Afficher mon code QR",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Encaissement rapide via QR Code",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(),
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (_) => QrCodeView()),
                                // );
                              },
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      /// ======================
                      /// SECTION : SUPPORT
                      /// ======================
                      Card(
                        elevation: 0,
                        color: AppColors.fourthBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Noter l’application",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Donnez votre avis",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(),
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {},
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: Text(
                                "Assistance",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: Text(
                                "Contactez notre service support",
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.copyWith(),
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      /// ======================
                      /// SECTION : DANGER
                      /// ======================
                      Card(
                        elevation: 0,
                        color: AppColors.fourthBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          title: Text(
                            "Se désinscrire",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                          subtitle: Text(
                            "Supprimer définitivement le compte",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // showDialog(
                            //   context: context,
                            //   barrierDismissible: true,
                            //   builder: (context) {
                            //     final formKey = GlobalKey<FormState>();
                            //     final marchandVm = Provider.of<AuthViewModel>(context, listen: false);
                            //
                            //     return AlertDialog(
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(12),
                            //       ),
                            //       title: Text(
                            //         'Prière rentrez un commentaire.',
                            //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            //           fontWeight: FontWeight.bold,
                            //           color: AppColors.black,
                            //         ),
                            //       ),
                            //       content: SizedBox(
                            //         width: MediaQuery.of(context).size.width * 0.8, // largeur élargie
                            //         child: Form(
                            //           key: formKey,
                            //           child: Column(
                            //             mainAxisSize: MainAxisSize.min,
                            //             children: [
                            //               TextFormField(
                            //                 controller: marchandVm.commentaireController,
                            //                 maxLines: 5,
                            //                 decoration: InputDecoration(
                            //                   hintText: "",
                            //                   hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            //                     color: Colors.black.withOpacity(0.6),
                            //                   ),
                            //                   labelText: "Votre commentaire",
                            //                   labelStyle: Theme.of(context).textTheme.bodyMedium,
                            //                   border: OutlineInputBorder(
                            //                     borderRadius: BorderRadius.circular(10),
                            //                     borderSide: BorderSide(color: AppColors.primaryBlue),
                            //                   ),
                            //                   focusedBorder: OutlineInputBorder(
                            //                     borderRadius: BorderRadius.circular(10),
                            //                     borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
                            //                   ),
                            //                 ),
                            //                 validator: (value) {
                            //                   if (value == null || value.trim().isEmpty) {
                            //                     return "Le commentaire est requis";
                            //                   }
                            //                   return null;
                            //                 },
                            //               ),
                            //               const SizedBox(height: 20),
                            //               SizedBox(
                            //                 width: double.infinity,
                            //                 child: PrimaryButton(
                            //                   onPressed: () async {
                            //                     // Vérifier acceptation des conditions
                            //
                            //
                            //                     // Valider le formulaire
                            //                     if (formKey.currentState!.validate()) {
                            //                       // Navigator.push(
                            //                       //   context,
                            //                       //   MaterialPageRoute(
                            //                       //     builder: (context) => const OnBoardingView(),
                            //                       //   ),
                            //                       // );
                            //                     }
                            //                   },
                            //                   title: 'Valider',
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }



  String getUserInitials(String? userConnectedName) {
    if (userConnectedName == null || userConnectedName.isEmpty) return "";

    // Découper le nom par les espaces
    final words = userConnectedName.split(' ');

    // Prendre la première lettre de chaque mot
    final initials = words.map((word) => word.isNotEmpty ? word[0].toUpperCase() : '').join();

    // Si tu veux seulement les deux premières lettres (deux premiers mots)
    return initials.length > 2 ? initials.substring(0, 2) : initials;
  }




}