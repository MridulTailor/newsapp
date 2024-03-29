import 'package:newsapp/config/export.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //hompage provider
    final __ = Provider.of<HomepageProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () => __.scaffoldKey.currentState?.openDrawer(),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.2)),
                        child: const Icon(Icons.menu),
                      )),
                  // const Spacer(),
                  // InkWell(
                  //   onTap: () {
                  //     __.changeIndex(1);
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     width: 50,
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Colors.grey.withOpacity(0.2)),
                  //     child: const Icon(Icons.search),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  // InkWell(
                  //   child: Container(
                  //     height: 40,
                  //     width: 40,
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: Colors.grey.withOpacity(0.2)),
                  //     child: const Icon(Icons.notifications),
                  //   ),
                  // )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text("Breaking News",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text("See All"))
              ],
            ),
            CarouselSlider(
              carouselController: __.carouselController,
              options: CarouselOptions(
                height: 220.0,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  __.changeCarouselIndex(index);
                },
              ),
              items: //map for 7 times
                  __.recommendedNewsResponse?.articles?.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(DetailPage.routeName,
                                        arguments: DetailPageArgs(
                                          article: item as Articles,
                                        ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        height: 200,
                                        width: double.infinity,
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
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Colors.black.withOpacity(0.9),
                                                Colors.black.withOpacity(0.0)
                                              ])),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        "${item.title}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }).toList() ??
                      [],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: __.recommendedNewsResponse?.articles?.map((item) {
                    int index =
                        __.recommendedNewsResponse?.articles?.indexOf(item) ??
                            0;
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: __.carouselIndex == index
                              ? Colors.blueAccent
                              : Colors.grey),
                    );
                  }).toList() ??
                  [],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text("Recommended",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text("See All"))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 7,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(DetailPage.routeName,
                        arguments: DetailPageArgs(
                          article: __.recommendedNewsResponse?.articles?[index]
                              as Articles,
                        ));
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
                              imageUrl:
                                  "${__.recommendedNewsResponse?.articles?[index].urlToImage}",
                              placeholder: (context, url) => const Center(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  __.recommendedNewsResponse?.articles?[index]
                                          .title ??
                                      "Loading...",
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 150,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          __.recommendedNewsResponse
                                                  ?.articles?[index].author ??
                                              "Not Available",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      const Text(
                                        " · ",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          __
                                                      .recommendedNewsResponse
                                                      ?.articles?[index]
                                                      .publishedAt !=
                                                  null
                                              ?
                                              //format date
                                              DateFormat('dd MMMM yyyy').format(
                                                  DateTime.parse(__
                                                          .recommendedNewsResponse
                                                          ?.articles?[index]
                                                          .publishedAt ??
                                                      ""))
                                              : "Not Available",
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
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
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 15,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
