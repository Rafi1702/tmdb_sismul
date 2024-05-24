import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/movie_detail/movie_detail_bloc.dart';

// class MoviesDetailPage extends StatefulWidget {
//   static const route = '/movie_detail';
//   const MoviesDetailPage({super.key});

//   @override
//   State<MoviesDetailPage> createState() => _MoviesDetailPageState();
// }

// class _MoviesDetailPageState extends State<MoviesDetailPage> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {

//     _controller = YoutubePlayerController(
//       flags: const YoutubePlayerFlags(
//         autoPlay: false,
//         mute: false,
//         loop: false,
//       ),
//       initialVideoId: '',
//     );

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
//           builder: (context, state) {
//             return YoutubePlayer(
//               aspectRatio: 16 / 9,
//               controller: _controller
//                 ..loadPlaylist(
//                   list: state.trailer.map((e) => e.key).toList(),
//                   startSeconds: 0,
//                 ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class MovieDetailPage extends StatelessWidget {
  static const route = '/movie_detail';
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _MovieBody(),
    );
  }
}

class _MovieBody extends StatelessWidget {
  const _MovieBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        switch (state.status) {
          case MovieDetailStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case MovieDetailStatus.loaded:
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child:
                      _MoviePicture(imageUrl: state.movie.backdropPath ?? ''),
                ),
                const Expanded(child: _MovieDescription()),
              ],
            );
          case MovieDetailStatus.error:
            return Text(state.errorMessage);
          default:
            return Container();
        }
      },
    );
  }
}

class _MoviePicture extends StatelessWidget {
  final String imageUrl;
  const _MoviePicture({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('http://image.tmdb.org/t/p/w500/$imageUrl'),
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.3),
        ));
  }
}

class _MovieDescription extends StatelessWidget {
  const _MovieDescription();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
