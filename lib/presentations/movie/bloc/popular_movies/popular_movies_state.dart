part of 'popular_movies_bloc.dart';

enum PopularMovieStatus { initial, loading, loaded, error }

class PopularMoviesState extends Equatable {
  const PopularMoviesState({
    this.popularMovies = const [],
    this.allPopularMovies = const [],
    this.status = PopularMovieStatus.initial,
    this.hasReachedMax = false,
    this.errorMessage = '',
    this.page = 1,
  });

  final List<MovieGeneral> popularMovies;
  final List<MovieGeneral> allPopularMovies;
  final PopularMovieStatus status;
  final bool hasReachedMax;
  final String errorMessage;
  final int page;

  PopularMoviesState copyWith(
      {List<MovieGeneral>? popularMovies,
      List<MovieGeneral>? allPopularMovies,
      PopularMovieStatus? status,
      bool? hasReachedMax,
      int? page,
      String? errorMessage}) {
    return PopularMoviesState(
      popularMovies: popularMovies ?? this.popularMovies,
      allPopularMovies: allPopularMovies ?? this.allPopularMovies,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }

  factory PopularMoviesState.fromJson(Map<String, dynamic> json) {
    return PopularMoviesState(
      popularMovies: List<MovieGeneral>.from(
        (json['popular_movies'].map(
          (e) => MovieGeneral.fromJson(e),
        )),
      ).toList(),
      allPopularMovies: List<MovieGeneral>.from(
        (json['all_popular_movies'].map(
          (e) => MovieGeneral.fromJson(e),
        )),
      ).toList(),
      page: json['page'],
      status:
          PopularMovieStatus.values.firstWhere((e) => e.name == json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'popular_movies': popularMovies,
      'status': status.name,
      'all_popular_movies': allPopularMovies,
      'page': page,
    };
  }

  @override
  List<Object> get props => [
        popularMovies,
        status,
        hasReachedMax,
        errorMessage,
        allPopularMovies,
        page
      ];
}
