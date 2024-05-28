import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tmdb_sismul/dependency.dart';

import 'package:tmdb_sismul/presentations/movie/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/now_playing/now_playing_bloc.dart';

import 'package:tmdb_sismul/presentations/movie/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/home_page.dart';
import 'package:tmdb_sismul/presentations/movie/movie_detail_page.dart';
import 'package:tmdb_sismul/presentations/movie/see_all_movies.dart';
import 'package:tmdb_sismul/styles/text_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF192841),
        ),
        useMaterial3: true,
        textTheme: textTheme.apply(
          bodyColor: const Color(0xFF192841),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF192841),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF192841),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              enableFeedback: false,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              overlayColor: WidgetStateProperty.all(Colors.transparent)),
        ),
      ),
      routes: {
        MyHomePage.route: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => sl<NowPlayingBloc>()
                    ..add(const GetNowPlayingMovieEvent()),
                ),
                BlocProvider(
                  create: (context) =>
                      sl<PopularMoviesBloc>()..add(GetPopularMoviesEvent()),
                ),
                BlocProvider(
                  create: (context) =>
                      sl<UpcomingMoviesBloc>()..add(GetUpcomingMoviesEvent()),
                ),
              ],
              child: const MyHomePage(title: 'Flutter Demo Home Page'),
            ),
        SeeAllMoviesPage.route: (context) {
          return const SeeAllMoviesPage();
        },
        MovieDetailPage.route: (context) {
          final id = ModalRoute.of(context)!.settings.arguments as int;
          return BlocProvider(
            create: (context) =>
                sl<MovieDetailBloc>()..add(GetMovieDetailEvent(id)),
            child: const MovieDetailPage(),
          );
        }
      },
    );
  }
}
