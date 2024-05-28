import 'package:flutter/material.dart';

import 'package:tmdb_sismul/presentations/movie/movie_detail_page.dart';
import 'package:tmdb_sismul/presentations/movie/widgets/shimmer_movie_poster.dart';

class MoviePoster extends StatelessWidget {
  final double vote;
  final String posterPath;
  final int movieId;
  final bool? isActive;
  final BoxConstraints? constraints;
  final bool? isRatingShowed;
  final BoxFit? imageFit;
  const MoviePoster({
    super.key,
    required this.vote,
    required this.posterPath,
    required this.movieId,
    this.isActive = true,
    this.isRatingShowed = true,
    this.constraints,
    this.imageFit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GestureDetector(
        onTap: () {
          isActive ?? true
              ? Navigator.of(context)
                  .pushNamed(MovieDetailPage.route, arguments: movieId)
              : null;
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: ConstrainedBox(
                constraints: constraints ??
                    const BoxConstraints(
                      minWidth: 116.0,
                      maxWidth: 116.0,
                      minHeight: 200.0,
                      maxHeight: 200.0,
                    ),
                child: Image.network(
                  'http://image.tmdb.org/t/p/w500/$posterPath',
                  filterQuality: FilterQuality.none,
                  fit: BoxFit.cover,
                  loadingBuilder: ((context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: ShimmerMoviePoster(),
                    );
                  }),
                ),
              ),
            ),
            isRatingShowed ?? true
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      left: 4.0,
                    ),
                    child: Text(
                      '⭐ ${vote.toStringAsFixed(1)}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      // child: Container(
      //   padding: const EdgeInsets.only(top: 4.0, left: 4.0),

      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //     image: DecorationImage(
      //       image: Image.network(
      //         'http://image.tmdb.org/t/p/w500/$posterPath',
      //         filterQuality: FilterQuality.none,
      //         loadingBuilder: ((context, child, loadingProgress) {
      //           if (loadingProgress == null) {
      //             return child;
      //           }
      //           return const Center(
      //             child: CircularProgressIndicator(),
      //           );
      //         }),
      //       ).image,
      //       fit: imageFit ?? BoxFit.cover,
      //     ),
      //   ),
      //   child: isRatingShowed ?? true
      //       ? Align(
      //           alignment: Alignment.topLeft,
      //           child: Text(
      //             '⭐ ${vote.toStringAsFixed(1)}',
      //             style: Theme.of(context).textTheme.labelMedium!.copyWith(
      //                   color: Colors.white,
      //                 ),
      //           ),
      //         )
      //       : null,
      // ),
    );
  }
}
