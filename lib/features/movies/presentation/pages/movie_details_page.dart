import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/presentation/widgets/floating_back_button.dart';
import 'package:moviedb/core/presentation/widgets/floating_watch_list_action_button.dart';
import 'package:moviedb/features/movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:moviedb/features/movies/presentation/widgets/custom_tab_bar.dart';
import 'package:moviedb/features/movies/presentation/widgets/header_delegate.dart';
import 'package:moviedb/features/movies/presentation/widgets/review_list_tile.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';
import 'package:moviedb/injection_container.dart';

class MovieDetailsPage extends StatelessWidget {
  static const _tabs = [
    Tab(
      height: 37,
      text: "About Movie",
    ),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Tab(
        height: 37,
        text: "Reviews",
      ),
    ),
  ];

  const MovieDetailsPage({
    super.key,
    required this.baseMovie,
  });

  final MovieEntity baseMovie;

  @override
  Widget build(BuildContext context) {
    final tabBar = CustomTabBar(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.pagePadding.horizontal / 2,
      ),
      tabs: _tabs,
    );

    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<MovieDetailsBloc>()
          ..add(GetMovieDetailsEvent(movieId: baseMovie.tmdbId)),
        child: Stack(
          children: [
            DefaultTabController(
              length: _tabs.length,
              child: NestedScrollView(
                floatHeaderSlivers: true,
                physics: const BouncingScrollPhysics(),
                headerSliverBuilder: (headerContext, innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          headerContext),
                      sliver: SliverPersistentHeader(
                        pinned: true,
                        delegate: HeaderDelegate(
                          context: context,
                          baseMovie: baseMovie,
                          tabBar: tabBar,
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    _buildAboutTab(context),
                    _buildReviewsTab(context),
                  ]
                      .map(
                        (child) => SafeArea(
                          top: false,
                          bottom: false,
                          child: Builder(
                            builder: (BuildContext context) {
                              return CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                key: PageStorageKey<String>(child.toString()),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.all(8.0),
                                    sliver: SliverToBoxAdapter(
                                      child: child,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  String? get _formattedReleaseDate {
    final releaseDate = baseMovie.releaseDate;
    if (releaseDate == null) {
      return null;
    }
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(releaseDate);
  }

  String get _formattedAverageRating {
    return baseMovie.voteAverage.toStringAsFixed(1);
  }

  Widget _buildReviewsTab(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.pagePadding.horizontal / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 18),
          BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
            builder: (context, state) {
              if (state is MovieDetailsLoaded) {
                if (state.movieDetails.reviews.isEmpty) {
                  return const Text("No reviews yet");
                }
                return ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.movieDetails.reviews.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 28);
                  },
                  itemBuilder: (context, index) {
                    final review = state.movieDetails.reviews[index];
                    return ReviewListTile(
                      review: review,
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          SizedBox(
              height: AppConstants.footerButtonsHeight +
                  AppConstants.pagePadding.vertical),
        ],
      ),
    );
  }

  Widget _buildAboutTab(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.pagePadding.horizontal / 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(
            "Overviews:",
            style: textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          Text(baseMovie.overview),
          const SizedBox(height: 12),
          Text(
            "Release Date:",
            style: textTheme.titleSmall,
          ),
          Text(_formattedReleaseDate ?? "NA"),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Average Rating:",
                      style: textTheme.titleSmall,
                    ),
                    Text(
                      _formattedAverageRating,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rate Count:",
                      style: textTheme.titleSmall,
                    ),
                    Text(
                      baseMovie.voteCount.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Popularity:",
            style: textTheme.titleSmall,
          ),
          Text(baseMovie.popularity.toString()),
          SizedBox(
            height: AppConstants.footerButtonsHeight +
                AppConstants.pagePadding.vertical,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.pagePadding.left,
            vertical: AppConstants.pagePadding.top,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: AppConstants.footerButtonsHeight,
                child: FloatingBackButton(),
              ),
              SizedBox(
                height: AppConstants.footerButtonsHeight,
                child: BlocBuilder<WatchlistBloc, WatchlistState>(
                  builder: (context, state) {
                    return FloatingWatchListActionButton(
                      isWatchlisted: baseMovie.isWatchlisted,
                      onTap: () => _onTapWatchlistButton(context),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapWatchlistButton(BuildContext context) {
    context.read<WatchlistBloc>().add(
          ToggleWatchlistItem(movie: baseMovie),
        );
  }
}
