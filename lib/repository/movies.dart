import 'package:dio/dio.dart';
import 'package:tmdb_sismul/models/movie.dart';

class MovieRepository {
  final Dio client;
  MovieRepository(this.client);
  Future<List<Movie>> getPopularMovies({int? page}) async {
    try {
      final response = await client.get(
        '/movie/popular?page=$page',
      );

      return (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Movie>> getUpcomingMovies({int? page}) async {
    try {
      final response = await client.get('/movie/upcoming?page=$page');
      return (response.data['results'] as List)
          .map((e) => Movie.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<Movie> getMovieDetails(int id) async {
    try {
      final response = await client.get('/movie/$id');

      return Movie.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
