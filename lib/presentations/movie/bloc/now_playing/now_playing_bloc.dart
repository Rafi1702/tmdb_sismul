import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/repository/movies.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final MovieRepository repo;
  NowPlayingBloc({required this.repo}) : super(const NowPlayingState()) {
    on<GetNowPlayingMovieEvent>(getNowPlayingMovie);
  }

  Future<void> getNowPlayingMovie(
      GetNowPlayingMovieEvent event, Emitter<NowPlayingState> emit) async {
    emit(state.copyWith(status: NowPlayingStatus.loading));
    try {
      final nowPlayingMovies = await repo.getNowPlayingMovies();

      emit(
        state.copyWith(
          nowPlayingMovies: nowPlayingMovies,
          status: NowPlayingStatus.loaded,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: NowPlayingStatus.error),
      );
    }
  }
}
