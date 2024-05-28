part of 'movie_trailer_bloc.dart';

sealed class MovieTrailerEvent extends Equatable {
  const MovieTrailerEvent();

  @override
  List<Object> get props => [];
}

class GetMovieTrailerEvent extends MovieTrailerEvent {
  const GetMovieTrailerEvent({required this.movieId});
  final int movieId;
  @override
  List<Object> get props => [movieId];
}
