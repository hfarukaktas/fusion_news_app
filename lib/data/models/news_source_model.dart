import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fusion_news_app/domain/entities/news_source_item.dart';

class NewsSourceModel extends NewsSourceItem {
  NewsSourceModel({
    required String id,
    required String source_name,
    required String favicon,
    required String logo,
    required String rss_link,
  }) : super(
         id: id,
         source_name: source_name,
         favicon: favicon,
         logo: logo,
         rss_link: rss_link,
       );

  factory NewsSourceModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NewsSourceModel(
      id: doc.id,
      source_name: data['source'],
      rss_link: data['main_rss'],
      favicon: data['favicon'],
      logo: data['logo'],
    );
  }
}
