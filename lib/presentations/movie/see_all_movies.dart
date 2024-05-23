import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/upcoming_movies/upcoming_movies_bloc.dart';

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
      return BlocProvider.value(
        value: bloc as UpcomingMoviesBloc,
        child: BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
          builder: (context, state) {
            return Container();
          },
        ),
      );
    } else {
      return Container();
    }
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
          return SizedBox(
            height: 200,
            child: GridView.builder(
              controller: _controller,
              itemCount: state.allPopularMovies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return Text(state.allPopularMovies[index].title);
              },
            ),
          );
        },
      ),
    );
  }
}
