part of 'popular_movies_bloc.dart';

enum PopularMovieStatus { initial, loading, loaded }

class PopularMoviesState extends Equatable {
  const PopularMoviesState({
    this.popularMovies = const [],
    this.status = PopularMovieStatus.initial,
    this.hasReachedMax = false,
  });

  final List<Movie> popularMovies;
  final PopularMovieStatus status;
  final bool hasReachedMax;

  PopularMoviesState copyWith(
      {List<Movie>? popularMovies,
      PopularMovieStatus? status,
      bool? hasReachedMax}) {
    return PopularMoviesState(
      popularMovies: popularMovies ?? this.popularMovies,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [popularMovies, status, hasReachedMax];
}
