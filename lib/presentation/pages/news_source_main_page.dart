import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:fusion_news_app/presentation/bloc/news_bloc/news_event.dart';
import 'package:fusion_news_app/presentation/bloc/news_bloc/news_state.dart';
import 'package:fusion_news_app/domain/entities/news_source_item.dart';
import 'package:fusion_news_app/presentation/widgets/follow_button.dart';
import 'package:fusion_news_app/presentation/widgets/custom_icon_button.dart';
import 'package:fusion_news_app/presentation/widgets/news_grid_widget.dart';

class NewsSourceMainPage extends StatelessWidget {
  final NewsSourceItem source;
  final NewsBloc Function() blocFactory;

  const NewsSourceMainPage({
    required this.source,
    required this.blocFactory,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => blocFactory()..add(FetchNews(source.rss_link)),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(source.logo, height: 150, width: 150),
                          const SizedBox(width: 12),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FollowButton(sourceId: source.id),
                          const SizedBox(width: 8),
                          CustomIconButton(buttonIcon: Icons.web_asset),
                          CustomIconButton(buttonIcon: Icons.more_vert_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoading) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is NewsError) {
                    return SliverFillRemaining(
                      child: Center(child: Text('Hata: ${state.message}')),
                    );
                  }
                  if (state is NewsLoaded) {
                    return NewsGridWidget(
                      newsItems: state.newsList,
                      isSliver: true,
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
