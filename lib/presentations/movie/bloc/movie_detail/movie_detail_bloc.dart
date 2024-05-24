import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/models/movie_trailer.dart';
import 'package:tmdb_sismul/repository/movies.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository repo;
  MovieDetailBloc({required this.repo}) : super(const MovieDetailState()) {
    on<GetMovieDetailEvent>(getMovieDetailAndTrailer);
  }

  Future<void> getMovieDetailAndTrailer(
      GetMovieDetailEvent event, Emitter<MovieDetailState> emit) async {
    emit(state.copyWith(status: MovieDetailStatus.loading));
    try {
      final movieDetail = await repo.getMovieDetails(event.id);

      final movieTrailer = await repo.getMovieTrailer(event.id);

      emit(
        state.copyWith(
          movie: movieDetail,
          trailer: movieTrailer,
          status: MovieDetailStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: MovieDetailStatus.error,
        ),
      );
    }
  }
}
