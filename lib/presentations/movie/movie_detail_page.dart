import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MoviesDetailPage extends StatefulWidget {
  static const route = '/movie_detail';
  const MoviesDetailPage({super.key});

  @override
  State<MoviesDetailPage> createState() => _MoviesDetailPageState();
}

class _MoviesDetailPageState extends State<MoviesDetailPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          return YoutubePlayer(
            aspectRatio: 16 / 9,
            controller: _controller
              ..loadPlaylist(list: state.trailer.map((e) => e.key).toList()),
          );
        },
      ),
    );
  }
}
