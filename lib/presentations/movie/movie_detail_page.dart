import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_sismul/models/movie_detail.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/widgets/movies_poster.dart';

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
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: _MovieBody(),
            ),
          ],
        ),
      ),
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
                Expanded(child: _MoviePicture(movie: state.movie)),
                Expanded(child: _MovieDetail(movie: state.movie)),
                const SizedBox(height: 10.0),
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
  final MovieDetail movie;
  const _MoviePicture({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
              'http://image.tmdb.org/t/p/w500/${movie.backdropPath ?? ''}'),
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.5),
      ),
    );
  }
}

class _MovieDetail extends StatelessWidget {
  const _MovieDetail({
    required this.movie,
  });

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          MoviePoster(
            constraints: const BoxConstraints(
              minWidth: 100.0,
              maxWidth: 100.0,
              minHeight: 130.0,
              maxHeight: 130.0,
            ),
            posterPath: movie.posterPath!,
            vote: movie.voteAverage!,
            movieId: movie.id!,
            isActive: false,
            isRatingShowed: false,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title ?? ''),
              Row(
                children: [
                  Text(movie.originalLanguage ?? ''),
                  Text(movie.voteAverage!.toStringAsFixed(1)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MovieDescription extends StatelessWidget {
  const _MovieDescription();

  @override
  Widget build(BuildContext context) {
    return Container(child: const Text('Container'));
  }
}
