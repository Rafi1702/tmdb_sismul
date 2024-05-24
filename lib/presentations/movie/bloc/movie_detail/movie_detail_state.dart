part of 'movie_detail_bloc.dart';

enum MovieDetailStatus { initial, success, error }

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.movie = Movie.empty,
    this.errorMessage = '',
    this.status = MovieDetailStatus.initial,
  });

  final Movie movie;
  final String errorMessage;
  final MovieDetailStatus status;

  MovieDetailState copyWith(
      {Movie? movie, String? errorMessage, MovieDetailStatus? status}) {
    return MovieDetailState(
      errorMessage: errorMessage ?? this.errorMessage,
      movie: movie ?? this.movie,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [movie, errorMessage, status];
}
