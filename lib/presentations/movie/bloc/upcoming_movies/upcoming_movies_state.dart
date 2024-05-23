part of 'upcoming_movies_bloc.dart';

enum UpcomingMovieStatus { initial, loading, loaded, error }

class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState({
    this.upComingMovies = const [],
    this.status = UpcomingMovieStatus.initial,
    this.errorMessage = '',
  });

  final List<Movie> upComingMovies;
  final UpcomingMovieStatus status;
  final String errorMessage;

  UpcomingMoviesState copyWith(
      {List<Movie>? upComingMovies,
      UpcomingMovieStatus? status,
      String? errorMessage}) {
    return UpcomingMoviesState(
      upComingMovies: upComingMovies ?? this.upComingMovies,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [upComingMovies, status, errorMessage];
}
