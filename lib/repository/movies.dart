import 'package:dio/dio.dart';

import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/models/movie_detail.dart';
import 'package:tmdb_sismul/models/movie_trailer.dart';
import 'package:tmdb_sismul/models/review.dart';

class MovieRepository {
  final Dio client;
  MovieRepository(this.client);
  Future<List<MovieGeneral>> getPopularMovies({int? page}) async {
    try {
      final response = await client.get(
        '/movie/popular?page=$page',
      );

      return (response.data['results'] as List)
          .map((e) => MovieGeneral.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<MovieGeneral>> getUpcomingMovies({int? page}) async {
    try {
      final response = await client.get('/movie/upcoming?page=$page');
      return (response.data['results'] as List)
          .map((e) => MovieGeneral.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<MovieGeneral>> getNowPlayingMovies() async {
    try {
      final response = await client.get('/movie/now_playing');
      return (response.data['results'] as List)
          .map((e) => MovieGeneral.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<MovieDetail> getMovieDetails(int id) async {
    try {
      final response = await client.get('/movie/$id');

      return MovieDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<MovieTrailer>> getMovieTrailer(int id) async {
    try {
      final response = await client.get('/movie/$id/videos');

      return (response.data['results'] as List)
          .map((e) => MovieTrailer.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Review>> getMovieReviews(int id) async {
    try {
      final response = await client.get('/movie/$id/reviews');

      return (response.data['results'] as List)
          .map((e) => Review.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
