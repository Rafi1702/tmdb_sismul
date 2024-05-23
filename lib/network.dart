import 'package:dio/dio.dart';

class Client {
  static Dio init() {
    Dio dio = Dio(
      BaseOptions(
        queryParameters: {
          'api_key': 'f7fccd306ac87e9e0a7dfa2cd3ff1c03',
        },
        baseUrl: 'https://api.themoviedb.org/3',
      ),
    );
    return dio;
  }
}
