part of 'now_playing_bloc.dart';

sealed class NowPlayingEvent extends Equatable {
  const NowPlayingEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMovieEvent extends NowPlayingEvent {
  const GetNowPlayingMovieEvent();

  @override
  List<Object> get props => [];
}
