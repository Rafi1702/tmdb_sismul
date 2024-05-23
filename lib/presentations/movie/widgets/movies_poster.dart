import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  final String posterPath;
  const MoviePoster({super.key, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        constraints: const BoxConstraints(minWidth: 116.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(
              'http://image.tmdb.org/t/p/w500/$posterPath',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
