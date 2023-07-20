import 'package:newsapp/config/export.dart';

class ExploreProvider extends ChangeNotifier {
  String _searchQuery = 'every';
  String get searchQuery => _searchQuery;

  int _page = 1;
  int get page => _page;

  set page(int page) {
    _page = page;
    notifyListeners();
  }

  void changeSearchQuery(String query) {
    _searchQuery = query != "" ? query : 'every';
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = 'every';
    notifyListeners();
  }

  void dispose() {
    super.dispose();
  }
}
