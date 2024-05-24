part of 'movie_detail_bloc.dart';

enum MovieDetailStatus { initial, loading, success, error }

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.movie = Movie.empty,
    this.trailer = const [],
    this.errorMessage = '',
    this.status = MovieDetailStatus.initial,
  });
  final List<MovieTrailer> trailer;
  final Movie movie;
  final String errorMessage;
  final MovieDetailStatus status;

  MovieDetailState copyWith(
      {Movie? movie,
      List<MovieTrailer>? trailer,
      String? errorMessage,
      MovieDetailStatus? status}) {
    return MovieDetailState(
      errorMessage: errorMessage ?? this.errorMessage,
      movie: movie ?? this.movie,
      trailer: trailer ?? this.trailer,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [movie, trailer, errorMessage, status];
}
