import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/data/datasource/news_remote_datasource.dart';
import 'package:fusion_news_app/data/datasource/firestore_service.dart';
import 'package:fusion_news_app/presentation/bloc/following_page_bloc/following_page_bloc.dart';
import 'package:fusion_news_app/presentation/bloc/following_page_bloc/following_page_event.dart';
import 'package:fusion_news_app/presentation/bloc/following_page_bloc/following_page_state.dart';
import 'package:fusion_news_app/presentation/widgets/news_grid_widget.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => FollowedNewsBloc(
            userId: FirebaseAuth.instance.currentUser!.uid,
            firestoreService: FirestoreService(),
            newsDatasource: NewsRemoteDatasourceImpl(),
          )..add(FetchFollowedNews()),
      child: Scaffold(
        body: BlocBuilder<FollowedNewsBloc, FollowedNewsState>(
          builder: (context, state) {
            if (state is FollowedNewsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FollowedNewsError) {
              return Center(child: Text('Hata: ${state.message}'));
            }
            if (state is FollowedNewsLoaded) {
              return NewsGridWidget(newsItems: state.news);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
