import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_sismul/models/movie_trailer.dart';
import 'package:tmdb_sismul/repository/movies.dart';

part 'movie_trailer_event.dart';
part 'movie_trailer_state.dart';

class MovieTrailerBloc extends Bloc<MovieTrailerEvent, MovieTrailerState> {
  final MovieRepository repo;
  MovieTrailerBloc({required this.repo}) : super(const MovieTrailerState()) {
    on<GetMovieTrailerEvent>(getMovieTrailer);
  }

  Future<void> getMovieTrailer(
      GetMovieTrailerEvent event, Emitter<MovieTrailerState> emit) async {
    emit(state.copyWith(status: MovieTrailerStatus.loading));
    try {
      final trailers = await repo.getMovieTrailer(event.movieId);

      emit(
        state.copyWith(
          status: MovieTrailerStatus.loaded,
          trailers: trailers,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MovieTrailerStatus.error,
        ),
      );
    }
  }
}
