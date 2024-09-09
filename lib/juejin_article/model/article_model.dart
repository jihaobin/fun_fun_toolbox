class Article{
  final String title; // 文章标题
  final String articleId; // 文章id
  final String briefContent; // 简要内容
  final String coverImage; // 封面图
  final String authorName; // 作者
  final int diggCount; // 点赞数
  final int viewCount; // 阅读数

  Article({required this.title, required this.articleId, required this.briefContent, required this.coverImage, required this.authorName, required this.diggCount, required this.viewCount});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['item_info']?["article_info"]?["title"] ?? "",
      articleId: json['item_info']?["article_id"] ?? "",
      briefContent: json['item_info']?["article_info"]?["brief_content"] ?? "",
      coverImage: json['item_info']?["article_info"]?["cover_image"] ?? "",
      authorName: json['item_info']?["author_user_info"]?["user_name"] ?? "",
      diggCount: json['item_info']?["article_info"]?["digg_count"] ?? 0,
      viewCount: json['item_info']?["article_info"]?["view_count"] ?? 0,
    );
  }
}

enum ArticleType {
  news,
  hotALl,
  recommend,
  day3,
  day7,
  day30,
}
