part of 'movie_detail_bloc.dart';

enum MovieDetailStatus { initial, loading, loaded, error }

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.movie = MovieDetail.empty,
    this.trailer = const [],
    this.genres = const [],
    this.reviews = const [],
    this.errorMessage = '',
    this.status = MovieDetailStatus.initial,
  });
  final List<MovieTrailer> trailer;
  final List<Genre> genres;
  final List<Review> reviews;
  final MovieDetail movie;
  final String errorMessage;
  final MovieDetailStatus status;

  MovieDetailState copyWith(
      {MovieDetail? movie,
      List<MovieTrailer>? trailer,
      List<Genre>? genres,
      List<Review>? reviews,
      String? errorMessage,
      MovieDetailStatus? status}) {
    return MovieDetailState(
      errorMessage: errorMessage ?? this.errorMessage,
      movie: movie ?? this.movie,
      trailer: trailer ?? this.trailer,
      genres: genres ?? this.genres,
      reviews: reviews ?? this.reviews,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        movie,
        trailer,
        genres,
        errorMessage,
        status,
        reviews,
      ];
}
