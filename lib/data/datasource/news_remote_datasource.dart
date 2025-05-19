import 'dart:convert';

import 'package:fusion_news_app/data/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

abstract class NewsRemoteDatasource {
  Future<List<NewsModel>> getNewsList(String rssUrl);
}

class NewsRemoteDatasourceImpl implements NewsRemoteDatasource {
  @override
  Future<List<NewsModel>> getNewsList(String rssUrl) async {
    final response = await http.get(Uri.parse(rssUrl));
    if (response.statusCode != 200) {
      throw Exception('RSS indirilemedi (HTTP ${response.statusCode})');
    }

    final decodedBody = utf8.decode(response.bodyBytes);
    final raw = xml.XmlDocument.parse(decodedBody);

    final channel =
        raw.findAllElements('channel').firstOrNull ??
        raw.findAllElements('feed').first;

    final channelData = {
      'title': _getTextFromElement(channel, 'title'),
      'description': _getTextFromElement(channel, 'description'),
      'link': _getTextFromElement(channel, 'link'),
      'language': _getTextFromElement(channel, 'language'),
    };

    // Haber öğelerini bulma
    var items = raw.findAllElements('item');
    if (items.isEmpty) items = raw.findAllElements('entry');

    if (items.isEmpty) {
      throw Exception('Haber öğesi bulunamadı');
    }

    return items.map((item) => NewsModel.fromXml(channelData, item)).toList();
  }

  String _getTextFromElement(xml.XmlElement parent, String elementName) {
    return parent.findElements(elementName).firstOrNull?.text.trim() ?? '';
  }
}
