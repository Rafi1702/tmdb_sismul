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
  final String? errorMessage;

  @override
  List<Object> get props => [];
}
