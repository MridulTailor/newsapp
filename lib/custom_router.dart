import 'package:newsapp/export.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => Scaffold(),
        );
      case SplashScreen.routeName:
        return SplashScreen.route();
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case DetailPage.routeName:
        return MaterialPageRoute(builder: (_) => const DetailPage());
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      ),
      // builder: (_) => const ErrorScreen(),
    );
  }
}
