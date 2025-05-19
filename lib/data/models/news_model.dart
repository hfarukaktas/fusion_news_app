import 'package:fusion_news_app/domain/entities/news_item.dart';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart' as xml;

class NewsModel extends NewsItem {
  NewsModel({
    required String trendingNewsTitle,
    required String trendingNewsLink,
    required DateTime trendingNewsPubDate,
    required String trendingNewsSource,
    required String trendingNewsImage,
    required String newsContent,
  }) : super(
         newsLink: trendingNewsLink,
         newsTitle: trendingNewsTitle,
         newsSource: trendingNewsSource,
         newsPubDate: trendingNewsPubDate,
         newsImage: trendingNewsImage,
         newsContent: newsContent,
       );

  factory NewsModel.fromXml(
    Map<String, String> channelData,
    xml.XmlElement element,
  ) {
    return NewsModel(
      trendingNewsTitle: _getText(element, [
        'title',
        'media:title',
        'dc:title',
      ]),
      trendingNewsLink: _getLink(element),
      trendingNewsPubDate: _parseDate(element),
      trendingNewsSource: channelData['title'] ?? _parseFallbackSource(element),
      trendingNewsImage: _parseImage(element),
      newsContent: _parseContent(element),
    );
  }

  static String _parseContent(xml.XmlElement element) {
    final directContent = _getText(element, [
      'content:encoded',
      'description',
      'content',
      'dc:description',
    ]);

    if (directContent.isNotEmpty) return directContent;

    final mediaDescription = _getText(element, ['media:description']);
    return mediaDescription;
  }

  static String _getText(xml.XmlElement element, List<String> tags) {
    for (final tag in tags) {
      final node = element.findElements(tag).firstOrNull;
      if (node != null) {
        return node.innerText
            .replaceAll('<![CDATA[', '')
            .replaceAll(']]>', '')
            .trim();
      }
    }
    return '';
  }

  static String _getLink(xml.XmlElement element) {
    final link = _getText(element, ['link']);
    if (link.isNotEmpty) return link;

    final guid = element.findElements('guid').firstOrNull;
    if (guid?.getAttribute('isPermaLink') != 'false') {
      return guid?.innerText.trim() ?? '';
    }

    final enclosure = element.findElements('enclosure').firstOrNull;
    return enclosure?.getAttribute('url') ?? '';
  }

  static DateTime _parseDate(xml.XmlElement element) {
    const formats = [
      'EEE, dd MMM yyyy HH:mm:ss zzz',
      'yyyy-MM-ddTHH:mm:ssZ',
      'yyyy-MM-dd HH:mm:ss',
      'dd MMM yyyy HH:mm:ss',
    ];

    final dateString = _getText(element, ['pubDate', 'published', 'dc:date']);
    for (final pattern in formats) {
      try {
        return DateFormat(pattern).parse(dateString);
      } catch (_) {}
    }
    return DateTime.now();
  }

  static String _parseImage(xml.XmlElement element) {
    const mediaSources = [
      'media:content',
      'media:thumbnail',
      'enclosure',
      'image',
    ];

    for (final tag in mediaSources) {
      final node = element.findElements(tag).firstOrNull;
      final url = node?.getAttribute('url') ?? node?.innerText;
      if (url?.isNotEmpty == true) return url!;
    }

    final htmlContent = _getText(element, [
      'content',
      'description',
      'content:encoded',
    ]);

    final imgRegExp = RegExp(
      '<img[^>]*src=("|\')(?<url>[^"\'>]+)\1',
      caseSensitive: false,
      multiLine: true,
    );

    final firstMatch = imgRegExp.firstMatch(htmlContent);
    return firstMatch?.namedGroup('url')?.replaceAll('&amp;', '&') ?? '';
  }

  static String _parseFallbackSource(xml.XmlElement element) {
    final author = _getText(element, ['dc:creator', 'author', 'source']);
    if (author.isNotEmpty) return author;

    final description = _getText(element, ['description']);
    final sourceRegExp = RegExp(r'(?:-|–|—|by|from)\s*([^\n<]+)');
    return sourceRegExp.firstMatch(description)?.group(1)?.trim() ?? 'Unknown';
  }
}
