import 'package:newsapp/providers/theme_provider.dart';

import 'config/export.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomepageProvider()),
          ChangeNotifierProvider(create: (_) => ExploreProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        builder: (context, _) {
          return const MyApp();
        }),
  );
}
