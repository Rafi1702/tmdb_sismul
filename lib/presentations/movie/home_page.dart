import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/see_all_movies.dart';
import 'package:tmdb_sismul/presentations/movie/widgets/movies_poster.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MovieListHeader(
          title: 'Popular Movies',
          arguments: BlocProvider.of<PopularMoviesBloc>(context),
        ),
        BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          buildWhen: (previous, current) =>
              previous.popularMovies != current.popularMovies,
          builder: (context, state) {
            switch (state.status) {
              case PopularMovieStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PopularMovieStatus.loaded:
                return _MoviesList(
                  movies: state.popularMovies,
                );
              case PopularMovieStatus.error:
                return Center(
                  child: Text(state.errorMessage),
                );
              default:
                return Container();
            }
          },
        ),
      ],
    );
  }
}

class _UpComingMovies extends StatelessWidget {
  const _UpComingMovies();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MovieListHeader(
          title: 'Upcoming Movies',
          arguments: BlocProvider.of<UpcomingMoviesBloc>(context),
        ),
        BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
          builder: (context, state) {
            switch (state.status) {
              case UpcomingMovieStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case UpcomingMovieStatus.loaded:
                return _MoviesList(
                  movies: state.upComingMovies,
                );
              case UpcomingMovieStatus.error:
                return Center(
                  child: Text(state.errorMessage),
                );
              default:
                return Container();
            }
          },
        ),
      ],
    );
  }
}

class _MovieListHeader extends StatelessWidget {
  final Object arguments;
  final String title;
  const _MovieListHeader({
    required this.arguments,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        TextButton(
          child: const Text('See All'),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(SeeAllMoviesPage.route, arguments: arguments);
          },
        ),
      ],
    );
  }
}

class _MoviesList extends StatelessWidget {
  final List<MovieGeneral> movies;

  const _MoviesList({
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200.0),
      child: ListView.separated(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10.0);
        },
        itemBuilder: (context, index) {
          return MoviePoster(
            posterPath: movies[index].posterPath!,
            vote: movies[index].voteAverage!,
            movieId: movies[index].id,
          );
        },
      ),
    );
  }
}
