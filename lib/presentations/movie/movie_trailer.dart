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
    super.initState();
    _controller = YoutubePlayerController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTrailerBloc, MovieTrailerState>(
      buildWhen: (prev, current) => prev.trailers != current.trailers,
      builder: (context, state) {
        switch (state.status) {
          case MovieTrailerStatus.loading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case MovieTrailerStatus.loaded:
            return YoutubePlayerScaffold(
              autoFullScreen: false,
              controller: _controller
                ..loadVideoById(
                  videoId: state.trailers.first.key,
                  startSeconds: 0,
                ),
              builder: (context, player) => SafeArea(child: player),
            );
          default:
            return Container();
        }
      },
    );
  }
}
