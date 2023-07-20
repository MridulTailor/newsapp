import 'package:newsapp/config/export.dart';
import 'package:newsapp/response_model/response_model.dart';

class HomepageProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  final CarouselController _carouselController = CarouselController();
  CarouselController get carouselController => _carouselController;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  int _carouselIndex = 0;
  int get carouselIndex => _carouselIndex;

  void changeCarouselIndex(int index) {
    _carouselIndex = index;
    notifyListeners();
  }

  final PagingController<dynamic, Articles> _recommendedPagingController =
      PagingController(firstPageKey: 0);
  PagingController<dynamic, Articles> get recommendedPagingController =>
      _recommendedPagingController;

  NewsResponse? _recommendedNewsResponse = NewsResponse();
  NewsResponse? get recommendedNewsResponse => _recommendedNewsResponse;

  void fetchRecommendedNews() async {
    _recommendedNewsResponse = await fetchBreakingNews();
    notifyListeners();
    if (_recommendedNewsResponse != null) {
      _recommendedNewsResponse = _recommendedNewsResponse;
      _recommendedPagingController.appendPage(
          _recommendedNewsResponse?.articles as List<Articles>,
          _recommendedNewsResponse?.totalResults);
      notifyListeners();
    }
  }

  Future<NewsResponse> fetchBreakingNews() async {
    final Response response = await NewsService().getBreakingNews();
    if (response.statusCode == 200) {
      if (response.data['status'] == 'ok') {
        print(response.data['status']);
        print(response.data['totalResults']);
        return NewsResponse.fromJson(response.data);
      } else {
        print(response.data['status']);
        return NewsResponse.fromJson(response.data);
      }
    } else {
      print(response.statusMessage);
      return NewsResponse();
    }
  }
}
