import 'package:newsapp/config/export.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPageArgs {
  final Articles article;
  DetailPageArgs({required this.article});
}

class DetailPage extends StatelessWidget {
  static const String routeName = '/detail';
  const DetailPage({super.key, required this.article});
  static Route route({required DetailPageArgs args}) {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => DetailPage(
        article: args.article,
      ),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  final Articles article;

  @override
  Widget build(BuildContext context) {
    var __ = Provider.of<HomepageProvider>(context);
    return Scaffold(
        body: GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity! < 0) {
          // Swiped from right to left
          if (article.url != null && article.url!.isNotEmpty) {
            launchUrl(Uri.parse(article.url!));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('No URL found')),
            );
          }
        }
      },
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: "${article.urlToImage}",
                          placeholder: (context, url) => const Center(
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
                            borderRadius: BorderRadius.circular(10),
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
                          "${article.title}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${article.description}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                if (article.content != null && article.content!.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        '${article.content}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
              ],
            ),
            Positioned(
              top: 60,
              left: 20,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width - 40,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white.withOpacity(0.5)),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (article.url != null && article.url!.isNotEmpty) {
                          launchUrl(Uri.parse(article.url!));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('No URL found')));
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white.withOpacity(0.5)),
                        child: const Icon(Icons.link),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
