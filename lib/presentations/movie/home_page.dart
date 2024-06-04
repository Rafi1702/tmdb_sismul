import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/now_playing/now_playing_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/see_all_movies.dart';
import 'package:tmdb_sismul/presentations/movie/widgets/movies_poster.dart';
import 'package:tmdb_sismul/presentations/movie/widgets/shimmer_movie_poster.dart';

class MyHomePage extends StatelessWidget {
  static const route = '/';
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/bc_1.png',
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
            const Text('Cinema'),
          ],
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Column(
              children: [
                _NowPlayingMovies(),
                SizedBox(height: 20.0),
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
          builder: (context, state) {
            switch (state.status) {
              case PopularMovieStatus.initial:
                return const _LoadingMovieBanner();
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
                return const _LoadingMovieBanner();
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

class _NowPlayingMovies extends StatelessWidget {
  const _NowPlayingMovies();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Now Playing', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        BlocBuilder<NowPlayingBloc, NowPlayingState>(
          builder: (context, state) {
            return CarouselSlider(
              items: state.nowPlayingMovies
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'http://image.tmdb.org/t/p/w500/${e.backdropPath ?? ''}',
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: double.infinity / 2,
                          child: Text(
                            e.title!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                clipBehavior: Clip.none,
              ),
            );
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

class _LoadingMovieBanner extends StatelessWidget {
  const _LoadingMovieBanner();

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: ListView.separated(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 10.0),
        itemBuilder: (context, index) {
          return const ShimmerMoviePoster();
        },
      ),
    );
  }
}
