part of 'now_playing_bloc.dart';

enum NowPlayingStatus { initial, loaded, loading, error }

class NowPlayingState extends Equatable {
  const NowPlayingState({
    this.status = NowPlayingStatus.initial,
    this.nowPlayingMovies = const [],
  });
  final NowPlayingStatus status;
  final List<MovieGeneral> nowPlayingMovies;

  NowPlayingState copyWith(
      {NowPlayingStatus? status, List<MovieGeneral>? nowPlayingMovies}) {
    return NowPlayingState(
      status: status ?? this.status,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
    );
  }

  @override
  List<Object> get props => [status, nowPlayingMovies];
}
