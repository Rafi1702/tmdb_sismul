import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/movie_trailer/movie_trailer_bloc.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MovieTrailerPage extends StatefulWidget {
  static const route = '/movie_trailer';
  const MovieTrailerPage({super.key});

  @override
  State<MovieTrailerPage> createState() => _MovieTrailerPageState();
}

class _MovieTrailerPageState extends State<MovieTrailerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTrailerBloc, MovieTrailerState>(
      builder: (context, state) {
        return YoutubePlayerScaffold(
          controller: _controller
            ..loadPlaylist(
              list: state.trailers.map((e) => e.key).toList(),
              startSeconds: 0,
            ),
          builder: (context, player) => player,
        );
      },
    );
  }
}
