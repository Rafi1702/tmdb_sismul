import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/see_all_movies.dart';

class MyHomePage extends StatefulWidget {
  static const route = '/';
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                _PopularMovies(),
                SizedBox(height: 20.0),
                _UpComingMovies(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PopularMovies extends StatelessWidget {
  const _PopularMovies();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      buildWhen: (previous, current) =>
          previous.popularMovies != current.popularMovies,
      builder: (context, state) {
        switch (state.status) {
          case PopularMovieStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case PopularMovieStatus.loaded:
            return _MoviesColumn(
              title: 'Popular Movies',
              movies: state.popularMovies,
              route: SeeAllMoviesPage.route,
              arguments: BlocProvider.of<PopularMoviesBloc>(context),
            );
          case PopularMovieStatus.error:
            return Center(
              child: Text(state.errorMessage),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class _UpComingMovies extends StatelessWidget {
  const _UpComingMovies();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
      builder: (context, state) {
        return _MoviesColumn(
          title: 'Upcoming Movies',
          movies: const [],
          route: SeeAllMoviesPage.route,
          arguments: BlocProvider.of<UpcomingMoviesBloc>(context),
        );
      },
    );
  }
}

class _MoviesColumn extends StatelessWidget {
  final List<Movie> movies;
  final String route;
  final Object arguments;
  final String title;
  const _MoviesColumn({
    required this.movies,
    required this.route,
    required this.arguments,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            TextButton(
                child: const Text('See All'),
                onPressed: () {
                  Navigator.of(context).pushNamed(route, arguments: arguments);
                }),
          ],
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200.0),
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10.0);
            },
            itemBuilder: (context, index) {
              return _MoviePoster(
                posterPath:
                    'http://image.tmdb.org/t/p/w500/${movies[index].posterPath}',
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final String posterPath;
  const _MoviePoster({required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        constraints: const BoxConstraints(minWidth: 116.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(
              posterPath,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
