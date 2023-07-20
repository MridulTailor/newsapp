import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  static const String routeName = '/detail';
  const DetailPage({super.key});
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => DetailPage(),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
