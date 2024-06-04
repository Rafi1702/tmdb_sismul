import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/repository/movies.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final MovieRepository repo;
  int _page = 1;
  UpcomingMoviesBloc({required this.repo})
      : super(const UpcomingMoviesState()) {
    on<GetUpcomingMoviesEvent>(getUpcomingMovies);
  }

  Future<void> getUpcomingMovies(
      GetUpcomingMoviesEvent event, Emitter emit) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      if (state.status == UpcomingMovieStatus.initial) {
        final data = await repo.getUpcomingMovies(page: 1);
        return emit(
          state.copyWith(
            status: UpcomingMovieStatus.loaded,
            upComingMovies: data,
            allUpcomingMovies: data,
            hasReachedMax: false,
          ),
        );
      }

      _page = _page + 1;
      if (_page > 5) return emit(state.copyWith(hasReachedMax: true));
      final data = await repo.getUpcomingMovies(page: _page);
      emit(
        data.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                allUpcomingMovies: List.from(state.allUpcomingMovies)
                  ..addAll(data),
              ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
