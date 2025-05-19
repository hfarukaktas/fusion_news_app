import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fusion_news_app/data/models/news_source_model.dart';

abstract class NewsSourceRemoteDatasource {
  Future<List<NewsSourceModel>> getNewsSources();
}

class NewsSourceRemoteDatasourceImpl implements NewsSourceRemoteDatasource {
  final FirebaseFirestore firestore;

  NewsSourceRemoteDatasourceImpl(this.firestore);

  @override
  Future<List<NewsSourceModel>> getNewsSources() async {
    final snapshot = await firestore.collection('news_sources').get();
    return snapshot.docs
        .map((doc) => NewsSourceModel.fromFirestore(doc))
        .toList();
  }
}
