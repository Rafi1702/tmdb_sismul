part of 'upcoming_movies_bloc.dart';

enum UpcomingMovieStatus { initial, loading, loaded, error }

class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState({
    this.upComingMovies = const [],
    this.allUpcomingMovies = const [],
    this.status = UpcomingMovieStatus.initial,
    this.errorMessage = '',
    this.hasReachedMax = false,
  });

  final List<Movie> upComingMovies;
  final List<Movie> allUpcomingMovies;
  final UpcomingMovieStatus status;
  final String errorMessage;
  final bool hasReachedMax;

  UpcomingMoviesState copyWith({
    List<Movie>? upComingMovies,
    List<Movie>? allUpcomingMovies,
    UpcomingMovieStatus? status,
    String? errorMessage,
    bool? hasReachedMax,
  }) {
    return UpcomingMoviesState(
      upComingMovies: upComingMovies ?? this.upComingMovies,
      allUpcomingMovies: allUpcomingMovies ?? this.allUpcomingMovies,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props =>
      [upComingMovies, status, errorMessage, hasReachedMax, allUpcomingMovies];
}
