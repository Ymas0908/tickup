# TickUp - SuperApp

> Application mobile de billetterie développée avec Flutter permettant la vente, la gestion de tickets pour des événements.

---

# Présentation

**TickUp** est une application mobile développée avec **Flutter** permettant aux utilisateurs de consulter des événements, d'acheter des billets en ligne et de gérer leurs tickets depuis leur smartphone.

L'application a été conçue pour offrir une expérience utilisateur fluide, moderne et sécurisée, aussi bien pour les participants que pour les organisateurs.

Son architecture repose sur plusieurs services backend indépendants afin de garantir une meilleure évolutivité, une maintenance simplifiée et une séparation claire des responsabilités.

---

# Fonctionnalités

* Consultation des événements
* Vente de billets en ligne
* Achat sécurisé de tickets
* Gestion du profil utilisateur
* Gestion des tickets numériques
* Historique des achats
* Notifications liées aux événements
* Authentification sécurisée

---

# Stack technique

| Élément                    | Technologie                    |
| -------------------------- | ------------------------------ |
| Framework                  | Flutter 3.x                    |
| Langage                    | Dart                           |
| Architecture               | MVVM (Model - View -ViewModel) |
| State Management           | Provider                       |
| Client HTTP                | Dio                            |
| Internationalisation       | Intl                           |
| Gestion de la connectivité | connectivity_plus              |
| Journalisation             | Logger                         |
| Typographie                | Montserrat                     |

---

# Dépendances principales

* provider
* dio
* intl
* connectivity_plus
* logger

---

# Prérequis

Avant de lancer le projet, assurez-vous de disposer des éléments suivants :

* Flutter SDK 3.x ou supérieur
* Dart SDK (fourni avec Flutter)
* Android Studio ou Visual Studio Code
* Android SDK ou Xcode (pour iOS)
* Un émulateur Android/iOS ou un appareil physique

---



# Architecture du projet

Le projet est organisé selon une architecture **MVVM** afin de favoriser la séparation des responsabilités et de faciliter la maintenance.

```text
lib/
├── composants/
│   ├── exception/
│   ├── models/
│   ├── ressources/
│   ├── views/
│   ├── views-models/
│   ├── web-services/
│   └── utils/
└── main.dart
```

---

# Architecture des services

L'application communique avec plusieurs services backend.

| Service       | Description                                                          |
| ------------- | -------------------------------------------------------------------- |
| TickUp-Subs   | Gestion des utilisateurs, de l'authentification et des autorisations |
| TickUp-Notify | Gestion de l'envoi des emails et des notifications                   |

---



# Objectif

TickUp a pour objectif de proposer une plateforme de billetterie numérique complète permettant :

* de simplifier l'organisation des événements ;
* de faciliter l'achat de billets en ligne ;
* de dématérialiser les tickets ;
* de garantir un contrôle sécurisé des accès ;
* de s'appuyer sur une architecture évolutive basée sur des services indépendants.

---

# Auteur

Projet développé par Samuel Kébé. 
