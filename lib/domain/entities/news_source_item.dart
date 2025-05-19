class NewsSourceItem {
  final String id;
  final String source_name;
  final String favicon;
  final String logo;
  final String rss_link;

  NewsSourceItem(
      {required this.id,
      required this.source_name,
      required this.favicon,
      required this.logo,
      required this.rss_link});
}
