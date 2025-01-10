import 'package:flutter/material.dart';
import 'package:spa_client_app/screens/landing/views/announcements/announcements.dart';
import 'package:spa_client_app/screens/landing/views/home/home.dart';
import 'package:spa_client_app/screens/landing/views/messages/messages.dart';
import 'package:spa_client_app/screens/landing/views/profile/profile.dart';

class LandingPagesModel {
  final String name;
  final Widget route;
  final IconData icon;

  LandingPagesModel({
    required this.name,
    required this.route,
    required this.icon,
  });

  static List<LandingPagesModel> list = [
    LandingPagesModel(name: 'Home', route: const Home(), icon: Icons.home),
    LandingPagesModel(
        name: 'Home', route: const Messages(), icon: Icons.message),
    LandingPagesModel(
        name: 'Home', route: const Announcements(), icon: Icons.notifications),
    LandingPagesModel(name: 'Home', route: const Profile(), icon: Icons.person),
  ];
}
