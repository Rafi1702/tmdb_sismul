import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_sismul/dependency.dart';

import 'package:tmdb_sismul/presentations/movie/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/home_page.dart';
import 'package:tmdb_sismul/presentations/movie/see_all_movies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              enableFeedback: false,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
        ),
      ),
      routes: {
        MyHomePage.route: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      sl<PopularMoviesBloc>()..add(GetPopularMoviesEvent()),
                ),
                BlocProvider(
                  create: (context) => sl<UpcomingMoviesBloc>(),
                ),
              ],
              child: const MyHomePage(title: 'Flutter Demo Home Page'),
            ),
        SeeAllMoviesPage.route: (context) {
          return const SeeAllMoviesPage();
        }
      },
    );
  }
}
