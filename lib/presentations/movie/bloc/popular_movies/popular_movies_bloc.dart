import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/repository/movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc
    extends HydratedBloc<PopularMoviesEvent, PopularMoviesState> {
  final MovieRepository repo;

  PopularMoviesBloc({required this.repo}) : super(const PopularMoviesState()) {
    on<GetPopularMoviesEvent>(getPopularMovies);
    on<LoadMorePopularMoviesEvent>(loadMorePopularMovies);
  }

  Future<void> getPopularMovies(
      GetPopularMoviesEvent event, Emitter<PopularMoviesState> emit) async {
    if (state.status == PopularMovieStatus.loaded) {
      emit(state.copyWith(hasReachedMax: true));
      return;
    }

    try {
      if (state.status == PopularMovieStatus.initial) {
        final data = await repo.getPopularMovies(page: state.page);

        return emit(state.copyWith(
          popularMovies: data,
          allPopularMovies: data,
          hasReachedMax: false,
          status: PopularMovieStatus.loaded,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PopularMovieStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> loadMorePopularMovies(LoadMorePopularMoviesEvent event,
      Emitter<PopularMoviesState> emit) async {
    try {
      emit(state.copyWith(page: state.page + 1));
      final data = await repo.getPopularMovies(page: state.page);

      emit(
        data.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                allPopularMovies: List.from(state.allPopularMovies)
                  ..addAll(data),
                hasReachedMax: false,
              ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PopularMovieStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  PopularMoviesState? fromJson(Map<String, dynamic> json) {
    return PopularMoviesState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(PopularMoviesState state) {
    return state.toJson();
  }
}
