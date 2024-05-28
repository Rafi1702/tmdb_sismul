part of 'movie_trailer_bloc.dart';

enum MovieTrailerStatus { initial, loading, loaded, error }

class MovieTrailerState extends Equatable {
  const MovieTrailerState({
    this.trailers = const [],
    this.status = MovieTrailerStatus.initial,
  });
  final List<MovieTrailer> trailers;
  final MovieTrailerStatus status;

  MovieTrailerState copyWith(
      {List<MovieTrailer>? trailers, MovieTrailerStatus? status}) {
    return MovieTrailerState(
      status: status ?? this.status,
      trailers: trailers ?? this.trailers,
    );
  }

  @override
  List<Object> get props => [trailers, status];
}
