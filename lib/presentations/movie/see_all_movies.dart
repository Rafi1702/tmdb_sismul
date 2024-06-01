import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/widgets/movies_poster.dart';

class SeeAllMoviesPage extends StatelessWidget {
  static const route = '/see_all_movies';

  const SeeAllMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = ModalRoute.of(context)!.settings.arguments as Bloc;
    return Scaffold(
      body: SafeArea(
        child: Body(
          bloc: bloc,
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final Bloc bloc;
  const Body({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    if (bloc is PopularMoviesBloc) {
      return _PopularMoviesGrid(bloc: bloc);
    } else if (bloc is UpcomingMoviesBloc) {
      return _UpcomingMoviesGrid(bloc: bloc);
    } else {
      return Container();
    }
  }
}

class _UpcomingMoviesGrid extends StatefulWidget {
  const _UpcomingMoviesGrid({required this.bloc});
  final Bloc bloc;
  @override
  State<_UpcomingMoviesGrid> createState() => __UpcomingMoviesGridState();
}

class __UpcomingMoviesGridState extends State<_UpcomingMoviesGrid> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      (widget.bloc as UpcomingMoviesBloc).add(GetUpcomingMoviesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc as UpcomingMoviesBloc,
      child: BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
        builder: (context, state) {
          return _PosterGrid(
            hasReachedMax: state.hasReachedMax,
            movies: state.allUpcomingMovies,
            controller: _controller,
          );
        },
      ),
    );
  }
}

class _PopularMoviesGrid extends StatefulWidget {
  const _PopularMoviesGrid({
    required this.bloc,
  });

  final Bloc bloc;

  @override
  State<_PopularMoviesGrid> createState() => _PopularMoviesGridState();
}

class _PopularMoviesGridState extends State<_PopularMoviesGrid> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      (widget.bloc as PopularMoviesBloc).add(LoadMorePopularMoviesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc as PopularMoviesBloc,
      child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
        builder: (context, state) {
          return _PosterGrid(
            controller: _controller,
            movies: state.allPopularMovies,
            hasReachedMax: state.hasReachedMax,
          );
        },
      ),
    );
  }
}

class _PosterGrid extends StatelessWidget {
  const _PosterGrid({
    required this.hasReachedMax,
    required this.movies,
    required ScrollController controller,
  }) : _controller = controller;

  final ScrollController _controller;
  final bool hasReachedMax;
  final List<MovieGeneral> movies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 10.0,
      ),
      child: GridView.builder(
        clipBehavior: Clip.none,
        controller: _controller,
        itemCount: hasReachedMax ? movies.length : movies.length + 1,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1 / 2,
        ),
        itemBuilder: (context, index) {
          return index >= movies.length
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: MoviePoster(
                        posterPath: movies[index].posterPath!,
                        vote: movies[index].voteAverage!,
                        movieId: movies[index].id,
                      ),
                    ),
                    Expanded(child: Text(movies[index].title ?? 'No Title')),
                  ],
                );
        },
      ),
    );
  }
}
