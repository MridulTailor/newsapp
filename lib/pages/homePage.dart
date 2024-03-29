import 'package:newsapp/providers/theme_provider.dart';

import '../config/export.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => const HomePage(),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final _homeProvider = Provider.of<HomepageProvider>(context, listen: false);
    final _exploreProvider =
        Provider.of<ExploreProvider>(context, listen: false);
    _homeProvider.fetchRecommendedNews();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    //carousel controller

    List<Widget> screens = [
      const Home(),
      const ExploreScreen(),
    ];

    return Consumer<HomepageProvider>(
      builder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              key: __.scaffoldKey,
              drawer: Drawer(
                  child: SafeArea(
                child: Column(
                  children: [
                    ListTile(
                        title: const Text("Night Mode",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        trailing: Switch(
                          value: themeProvider.themeMode == ThemeMode.dark,
                          onChanged: (value) {
                            themeProvider.toggleTheme(value);
                          },
                        )),
                    const Spacer(),
                    const Text("Version 1.0.0",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: __.currentIndex,
                  onTap: (index) {
                    __.changeIndex(index);
                  },
                  type: BottomNavigationBarType.shifting,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  selectedItemColor: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                  unselectedItemColor: themeProvider.themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
                  selectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  // ignore: prefer_const_literals_to_create_immutables
                  items: [
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.explore), label: "Explore"),
                  ]),
              body: SafeArea(
                child: screens[__.currentIndex],
              )),
        );
      },
    );
  }
}
