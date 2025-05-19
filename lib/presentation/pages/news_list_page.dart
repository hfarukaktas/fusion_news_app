import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/presentation/widgets/news_grid_widget.dart';
import '../bloc/news_bloc/news_bloc.dart';
import '../bloc/news_bloc/news_event.dart';
import '../bloc/news_bloc/news_state.dart';

class NewsListPage extends StatelessWidget {
  final String rssUrl;
  final NewsBloc Function() blocFactory;

  const NewsListPage({
    Key? key,
    required this.rssUrl,
    required this.blocFactory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => blocFactory()..add(FetchNews(rssUrl)),
      child: Scaffold(
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is NewsError) {
              return Center(child: Text('Hata: ${state.message}'));
            }
            if (state is NewsLoaded) {
              return NewsGridWidget(newsItems: state.newsList);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
