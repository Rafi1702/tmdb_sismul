import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_sismul/network.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:tmdb_sismul/repository/movies.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //Dio Init
  sl.registerSingleton<Dio>(Client.init());

  //Movies
  sl.registerSingleton<MovieRepository>(MovieRepository(sl()));
  sl.registerSingleton<PopularMoviesBloc>(PopularMoviesBloc(repo: sl()));
  sl.registerSingleton<UpcomingMoviesBloc>(UpcomingMoviesBloc());
}
