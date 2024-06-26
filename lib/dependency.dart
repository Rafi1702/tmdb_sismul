import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmdb_sismul/network.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/movie_trailer/movie_trailer_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/now_playing/now_playing_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:tmdb_sismul/repository/movies.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  await dotenv.load(fileName: ".env");

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  //Dio Init
  sl.registerSingleton<Dio>(Client.init(dotenv.get('API_KEY')));

  //Movies
  sl.registerSingleton<MovieRepository>(MovieRepository(sl()));
  sl.registerSingleton<PopularMoviesBloc>(PopularMoviesBloc(repo: sl()));
  sl.registerSingleton<UpcomingMoviesBloc>(UpcomingMoviesBloc(repo: sl()));
  sl.registerSingleton<NowPlayingBloc>(NowPlayingBloc(repo: sl()));
  sl.registerFactory<MovieTrailerBloc>(() => MovieTrailerBloc(repo: sl()));
  sl.registerFactory<MovieDetailBloc>(() => MovieDetailBloc(repo: sl()));
}
