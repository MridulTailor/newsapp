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
              drawer: new Drawer(
                  child: Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Text(
                        "News App",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: Image.asset(
                          "assets/splash.gif",
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Spacer(),
                      Text("Version 1.0.0",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              )),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: __.currentIndex,
                  onTap: (index) {
                    __.changeIndex(index);
                  },
                  type: BottomNavigationBarType.shifting,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
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
