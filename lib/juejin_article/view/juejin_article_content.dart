import 'package:flutter/material.dart';

import '../api/articleRequest.dart';
import '../model/article.dart';
import 'juejin_article_detail_page.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({super.key});

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  List<Article> _articles = [];
  ArticleApi api = ArticleApi();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    _articles = await api.loadArticles(uuid: 7395085426157536806);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 100,
      itemCount: _articles.length,
      itemBuilder: _buildItemByIndex,
    );
  }

  Widget _buildItemByIndex(BuildContext context, int index) {
    return ArticleItem(
      article: _articles[index],
      onTap: _jumpToDetailPage,
    );
  }

  void _jumpToDetailPage(Article article) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ArticleDetailPage(
          url: "post/${article.articleId}",
          title: '文章详情',
        ),
      ),
    );
  }
}

class ArticleItem extends StatelessWidget {
  final Article article;
  final ValueChanged<Article> onTap;

  const ArticleItem({super.key, required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(article),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        article.briefContent,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                    Row(children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Color(0xFF9EA4b0),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            article.viewCount >= 1000
                                ? "${(article.viewCount / 1000).ceil()}K"
                                : "${article.viewCount}",
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.linked_camera_rounded,
                            color: Color(0xFF9EA4b0),
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            article.diggCount >= 1000
                                ? "${(article.diggCount / 1000).ceil()}K"
                                : "${article.diggCount}",
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ])
                  ],
                ),
              ),
              if (article.coverImage.isNotEmpty)
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey, width: 1),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(article.coverImage),
                      ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
