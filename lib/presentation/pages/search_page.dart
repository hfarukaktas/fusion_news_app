import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fusion_news_app/data/datasource/news_source_remote_datasource.dart';
import 'package:fusion_news_app/data/repositories/news_source_repository_impl.dart';
import 'package:fusion_news_app/domain/usecases/get_news_sources_usecase.dart';
import 'package:fusion_news_app/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:fusion_news_app/presentation/pages/search_body.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final datasource = NewsSourceRemoteDatasourceImpl(
      FirebaseFirestore.instance,
    );
    final repository = NewsSourceRepositoryImpl(datasource);
    final usecase = GetNewsSourcesUsecase(repository);

    return SearchBody(
      blocFactory: () => SearchBloc(getNewsSourcesListUseCase: usecase),
    );
  }
}
