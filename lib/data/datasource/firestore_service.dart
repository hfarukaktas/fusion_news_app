import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getFollowedSourceIds(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return List<String>.from(doc['news_sources'] ?? []);
  }

  Future<List<String>> getTrendingSourceIds(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return List<String>.from(doc['trending_news_sources'] ?? []);
  }

  Future<List<String>> getRssLinksFromSources(List<String> sourceIds) async {
    final List<String> rssLinks = [];
    for (final id in sourceIds) {
      final doc = await _firestore.collection('news_sources').doc(id).get();
      if (doc.exists) {
        rssLinks.add(doc['main_rss']);
      }
    }
    return rssLinks;
  }
}
