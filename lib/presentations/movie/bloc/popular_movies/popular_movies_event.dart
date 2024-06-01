part of 'popular_movies_bloc.dart';

class PopularMoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetPopularMoviesEvent extends PopularMoviesEvent {}

class LoadMorePopularMoviesEvent extends PopularMoviesEvent {}
