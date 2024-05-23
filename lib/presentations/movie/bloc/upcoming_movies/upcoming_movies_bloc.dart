import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb_sismul/models/movie.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  UpcomingMoviesBloc() : super(const UpcomingMoviesState()) {
    on<UpcomingMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
