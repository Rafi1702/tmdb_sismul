import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tmdb_sismul/models/movie_detail.dart';
import 'package:tmdb_sismul/models/review.dart';
import 'package:tmdb_sismul/presentations/movie/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:tmdb_sismul/presentations/movie/movie_trailer.dart';
// import 'package:tmdb_sismul/presentations/movie/movie_trailer.dart';
import 'package:tmdb_sismul/presentations/movie/widgets/movies_poster.dart';

class MovieDetailPage extends StatelessWidget {
  static const route = '/movie_detail';
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movie Detail')),
      body: const SafeArea(
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
                const SizedBox(height: 10.0),
                Expanded(child: _MovieDetail(movie: state.movie)),
                const SizedBox(height: 10.0),
                Expanded(
                  flex: 2,
                  child: _MovieDescription(
                    movie: state.movie,
                    reviews: state.reviews,
                  ),
                ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoviePoster(
            constraints: const BoxConstraints(),
            posterPath: movie.posterPath!,
            vote: movie.voteAverage!,
            movieId: movie.id!,
            isActive: false,
            isRatingShowed: false,
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(movie.title ?? '',
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2.0),
                        color: Colors.grey[400],
                      ),
                      child: FittedBox(
                        child: Text(
                          movie.originalLanguage ?? '',
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          movie.voteAverage!.toStringAsFixed(1),
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.yellow,
                                  ),
                        ),
                        const Icon(
                          Icons.star_outline,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Genres:'),
                    Wrap(
                      spacing: 4.0,
                      runSpacing: 4.0,
                      runAlignment: WrapAlignment.spaceAround,
                      children: movie.genres!
                          .map(
                            (e) => Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.greenAccent,
                                    Colors.lightBlueAccent,
                                  ],
                                ),
                              ),
                              child: Text(
                                e.name!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                  label: Text('Watch Trailer',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Colors.white,
                          )),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(MovieTrailerPage.route, arguments: movie.id);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDescription extends StatelessWidget {
  const _MovieDescription({
    required this.movie,
    required this.reviews,
  });
  final MovieDetail movie;
  final List<Review> reviews;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Overview'),
                Tab(text: 'Reviews'),
              ],
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 10.0,
                ),
                child: TabBarView(
                  clipBehavior: Clip.none,
                  children: [
                    movie.overview!.isEmpty
                        ? const Center(child: Text('Overview not Available'))
                        : Text(
                            movie.overview!,
                          ),
                    reviews.isEmpty
                        ? const Center(
                            child: Text('Reviews Not Available'),
                          )
                        : ListView.separated(
                            itemCount: reviews.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20.0),
                            itemBuilder: (context, index) => _AuthorReview(
                              review: reviews[index],
                            ),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthorReview extends StatelessWidget {
  const _AuthorReview({required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF192841),
          ),
          child: Image.network(
            '${review.authorDetails!.avatarPath}',
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.question_mark,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review.authorDetails!.username!,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(DateFormat.yMMMd().format(review.createdAt!)),
              const SizedBox(height: 10.0),
              Text(
                review.content!,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        )
      ],
    );
  }
}
