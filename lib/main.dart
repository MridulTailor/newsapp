import 'export.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomepageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
