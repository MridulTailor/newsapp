import 'config/export.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomepageProvider()),
          ChangeNotifierProvider(create: (_) => ExploreProvider()),
        ],
        builder: (context, _) {
          return const MyApp();
        }),
  );
}
