import 'package:dio/dio.dart';

class Client {
  static Dio init(String key) {
    Dio dio = Dio(
      BaseOptions(
        queryParameters: {
          'api_key': key,
        },
        baseUrl: 'https://api.themoviedb.org/3',
      ),
    );
    return dio;
  }
}
