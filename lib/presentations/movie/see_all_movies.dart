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
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc as UpcomingMoviesBloc,
      child: BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
        builder: (context, state) {
          return _PosterGrid(
              hasReachedMax: true,
              movies: state.upComingMovies,
              controller: ScrollController());
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
      (widget.bloc as PopularMoviesBloc).add(GetPopularMoviesEvent());
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
  final bool hasReachedMax;
  final List<Movie> movies;
  const _PosterGrid({
    required this.hasReachedMax,
    required this.movies,
    required ScrollController controller,
  }) : _controller = controller;

  final ScrollController _controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _controller,
      itemCount: hasReachedMax ? movies.length : movies.length + 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1 / 2,
      ),
      itemBuilder: (context, index) {
        return index >= movies.length
            ? const Center(child: CircularProgressIndicator())
            : MoviePoster(posterPath: movies[index].posterPath);
      },
    );
  }
}
