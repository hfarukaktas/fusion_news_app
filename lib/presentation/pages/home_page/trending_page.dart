import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/data/datasource/news_remote_datasource.dart';
import 'package:fusion_news_app/data/datasource/firestore_service.dart';
import 'package:fusion_news_app/presentation/bloc/trending_news_page_bloc/test_trending_news_bloc.dart';
import 'package:fusion_news_app/presentation/bloc/trending_news_page_bloc/trending_news_event.dart';
import 'package:fusion_news_app/presentation/bloc/trending_news_page_bloc/trending_news_state.dart';

import 'package:fusion_news_app/presentation/widgets/news_list_view.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => TrendingNewsBloc(
            userId: FirebaseAuth.instance.currentUser!.uid,
            firestoreService: FirestoreService(),
            newsDatasource: NewsRemoteDatasourceImpl(),
          )..add(FetchTrendingNews()),
      child: Scaffold(
        body: BlocBuilder<TrendingNewsBloc, TrendingNewsState>(
          builder: (context, state) {
            if (state is TrendingNewsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TrendingNewsError) {
              return Center(child: Text('Hata: ${state.message}'));
            }
            if (state is TrendingNewsLoaded) {
              return TrendingNewsListView(trendingNewsItems: state.news);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
