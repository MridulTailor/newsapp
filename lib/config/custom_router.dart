import 'package:newsapp/config/export.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
      case SplashScreen.routeName:
        return SplashScreen.route();
      case HomePage.routeName:
        return HomePage.route();
      case DetailPage.routeName:
        return DetailPage.route(args: settings.arguments as DetailPageArgs);
      case ExploreScreen.routeName:
        return ExploreScreen.route();
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
