import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_sismul/models/movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(const MovieDetailState()) {
    on<GetMovieDetailEvent>(getMovieDetail);
  }

  Future<void> getMovieDetail(
      GetMovieDetailEvent event, Emitter<MovieDetailState> emit) async {}
}
