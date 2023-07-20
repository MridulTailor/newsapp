import 'package:dio/dio.dart';
import 'package:newsapp/config/const.dart';

class NewsService {
  final Dio _dio = Dio();

  Future<Response> getBreakingNews() async {
    try {
      final Response response =
          await _dio.get('${Constants.newsAPIURL}${Constants.topHeadlines}');
      return response;
    } on DioException catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      throw Exception(e.response?.statusMessage);
    }
  }

  Future<Response> getSearchNews(String query, int page) async {
    try {
      final Response response = await _dio.get(
          '${Constants.newsAPIURL}everything?q=${query}&apiKey=${Constants.newsAPIKey}&page=$page');
      print(response.data);
      return response;
    } on DioException catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);
      throw Exception(e.response?.statusMessage);
    }
  }
}
