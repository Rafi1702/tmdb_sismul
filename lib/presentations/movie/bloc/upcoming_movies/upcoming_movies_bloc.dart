import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/repository/movies.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final MovieRepository repo;
  UpcomingMoviesBloc({required this.repo})
      : super(const UpcomingMoviesState()) {
    on<GetUpcomingMoviesEvent>(getUpcomingMovies);
  }

  Future<void> getUpcomingMovies(
      GetUpcomingMoviesEvent event, Emitter emit) async {
    try {
      final data = await repo.getUpcomingMovies(page: 1);
      emit(
        state.copyWith(
          status: UpcomingMovieStatus.loaded,
          upComingMovies: data,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
