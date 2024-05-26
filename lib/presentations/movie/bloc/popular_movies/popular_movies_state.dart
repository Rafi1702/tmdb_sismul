part of 'popular_movies_bloc.dart';

enum PopularMovieStatus { initial, loading, loaded, error }

class PopularMoviesState extends Equatable {
  const PopularMoviesState({
    this.popularMovies = const [],
    this.allPopularMovies = const [],
    this.status = PopularMovieStatus.initial,
    this.hasReachedMax = false,
    this.errorMessage = '',
  });

  final List<MovieGeneral> popularMovies;
  final List<MovieGeneral> allPopularMovies;
  final PopularMovieStatus status;
  final bool hasReachedMax;
  final String errorMessage;

  PopularMoviesState copyWith(
      {List<MovieGeneral>? popularMovies,
      List<MovieGeneral>? allPopularMovies,
      PopularMovieStatus? status,
      bool? hasReachedMax,
      String? errorMessage}) {
    return PopularMoviesState(
      popularMovies: popularMovies ?? this.popularMovies,
      allPopularMovies: allPopularMovies ?? this.allPopularMovies,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props =>
      [popularMovies, status, hasReachedMax, errorMessage, allPopularMovies];
}
