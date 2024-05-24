import 'package:flutter/material.dart';
import 'package:tmdb_sismul/models/movie.dart';
import 'package:tmdb_sismul/presentations/movie/movie_detail_page.dart';

class MoviePoster extends StatelessWidget {
  final Movie movie;
  const MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(MoviesDetailPage.route, arguments: movie.id);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
          constraints: const BoxConstraints(minWidth: 116.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: Image.network(
                'http://image.tmdb.org/t/p/w300/${movie.posterPath}',
                loadingBuilder: ((context, child, loadingProgress) {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress!.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                }),
              ).image,
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              '⭐ ${movie.voteAverage?.toStringAsFixed(1)}',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
