import 'export.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({super.key});
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => HomePage(),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return Consumer<HomepageProvider>(
      builder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              key: _scaffoldKey,
              drawer: new Drawer(),
              bottomNavigationBar: BottomNavigationBar(
                  currentIndex: __.currentIndex,
                  onTap: (index) {
                    __.changeIndex(index);
                  },
                  type: BottomNavigationBarType.shifting,
                  backgroundColor: Colors.white,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: "Home"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.explore), label: "Explore"),
                  ]),
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () =>
                                    _scaffoldKey.currentState?.openDrawer(),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.withOpacity(0.2)),
                                  child: Icon(Icons.menu),
                                )),
                            Spacer(),
                            InkWell(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.2)),
                                child: Icon(Icons.search),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.withOpacity(0.2)),
                                child: Icon(Icons.notifications),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text("Breaking News",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Spacer(),
                            TextButton(onPressed: () {}, child: Text("See All"))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
