import 'package:newsapp/config/export.dart';

class ExploreScreen extends StatefulWidget {
  static const String routeName = '/search';
  const ExploreScreen({super.key});
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => const ExploreScreen(),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ExploreProvider? _exploreProvider;
  final PagingController<int, Articles> _searchPagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _exploreProvider = Provider.of<ExploreProvider>(context, listen: false);
    _searchPagingController.addPageRequestListener((pageKey) {
      fetchSearchNews(pageKey + 1);
    });
    super.initState();
  }

  Future<void> fetchSearchNews(int page) async {
    try {
      final Response response = await NewsService()
          .getSearchNews("${_exploreProvider?.searchQuery}", page);
      final resArticles = NewsResponse.fromJson(response.data).articles;
      final isLastPage = resArticles!.length < 7;
      if (isLastPage) {
        _searchPagingController.appendLastPage(resArticles);
      } else {
        final nextPageKey = page + resArticles.length;
        _searchPagingController.appendPage(resArticles, nextPageKey);
      }
    } catch (e) {
      _searchPagingController.error = e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomepageProvider>(context);
    return Consumer<ExploreProvider>(
      builder: (_, __, ___) {
        return Scaffold(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () => _homeProvider.scaffoldKey.currentState
                              ?.openDrawer(),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.2)),
                            child: const Icon(Icons.menu),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "News from all around the world",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors
                        .grey[300], // Set your desired background color here
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    onChanged: (value) {
                      __.changeSearchQuery(value);
                      _searchPagingController.refresh();
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusColor: Colors.black,
                      prefixIconColor: Colors.black,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: PagedListView<int, Articles>.separated(
                    pagingController: _searchPagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      itemBuilder: (context, item, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                DetailPage.routeName,
                                arguments: DetailPageArgs(article: item));
                          },
                          child: Container(
                            height: 120,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                      imageUrl: "${item.urlToImage}",
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          item.title ?? "Loading...",
                                          softWrap: true,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  item.author ??
                                                      "Not Available",
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              const Text(
                                                " · ",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  item.publishedAt != null
                                                      ?
                                                      //format date
                                                      DateFormat('dd MMMM yyyy')
                                                          .format(DateTime.parse(
                                                              item.publishedAt ??
                                                                  ""))
                                                      : "Not Available",
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                        );
                      },
                    ),
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
      },
    );
  }
}
