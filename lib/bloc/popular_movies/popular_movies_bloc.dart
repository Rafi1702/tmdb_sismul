import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/models/movie.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc() : super(const PopularMoviesState()) {
    on<PopularMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
