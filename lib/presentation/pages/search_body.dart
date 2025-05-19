import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/data/datasource/news_remote_datasource.dart';
import 'package:fusion_news_app/data/repositories/news_repository_impl.dart';
import 'package:fusion_news_app/domain/usecases/get_news_list.dart';
import 'package:fusion_news_app/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:fusion_news_app/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:fusion_news_app/presentation/bloc/search_bloc/search_events.dart';
import 'package:fusion_news_app/presentation/bloc/search_bloc/search_state.dart';
import 'package:fusion_news_app/presentation/pages/news_source_main_page.dart';

class SearchBody extends StatelessWidget {
  final SearchBloc Function() blocFactory;

  const SearchBody({Key? key, required this.blocFactory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => blocFactory()..add(FetchNewsSources()),
      child: Builder(
        builder: (blocContext) {
          final remoteDatasource = NewsRemoteDatasourceImpl();
          final repository = NewsRepositoryImpl(
            remoteDatasource: remoteDatasource,
          );
          final useCase = GetNewsList(repository);

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Haber kaynağı ara...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onChanged: (query) {
                    blocContext.read<SearchBloc>().add(
                      FilterNewsSources(query: query),
                    );
                  },
                ),
              ),
            ),
            body: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is NewsSourceshLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is SearchError) {
                  return Center(child: Text('Hata: ${state.message}'));
                }
                if (state is NewsSourcesLoaded) {
                  final items = state.newsSourceList;
                  if (items.isEmpty) {
                    return const Center(child: Text('Kaynak bulunamadı'));
                  }
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final source = items[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => NewsSourceMainPage(
                                      source: source,
                                      blocFactory: () => NewsBloc(useCase),
                                    ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [_buildSouceLogo(source.logo)],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSouceLogo(String? url) {
    if (url == null || url.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 56);
    }
    return SizedBox(
      width: 120,
      height: 75,
      child: Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 56),
      ),
    );
  }
}
