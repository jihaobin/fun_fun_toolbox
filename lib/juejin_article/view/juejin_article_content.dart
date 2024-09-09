import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../componts/dropdown_selector.dart';
import '../../icons/icons.dart';
import '../api/articleRequest.dart';
import '../model/article_model.dart';
import 'juejin_article_detail_page.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({super.key, required this.currentCategory});

  final DropdownSelectorModel<ArticleType> currentCategory;

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  List<Article> _articles = [];
  ArticleApi api = ArticleApi();
  int _page = 1;
  int _limit = 20;

  static const _uuid = 7395085426157536806;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.currentCategory.selectedType != widget.currentCategory.selectedType){
      _page = 1;
      _loadData();
    }
  }

  Future<List<Article>> _onRequestData() async {
    return await api.loadArticles(
        uuid: _uuid,
        limit: _limit,
        page: _page,
        type: widget.currentCategory.selectedType);
  }

  void _loadData() async {
    _loading = true;
    setState(() {});
    _articles = await _onRequestData();
    _loading = false;
    setState(() {});
  }

  void _onRefresh() async {
    _page = 1;
    _articles = await _onRequestData();
    setState(() {});
  }

  void _onLoadMore() async{
    _page += _limit;
    _articles = [..._articles, ...await _onRequestData()];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(_loading){
      return const Center(
        child: Wrap(
          spacing: 10,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CupertinoActivityIndicator(),
            Text("数据加载中，请稍后...",style: TextStyle(color: Colors.grey),)
          ],
        ),
      );
    }

    return EasyRefresh(
      header: const ClassicHeader(
        dragText: "下拉加载",
        armedText: "释放刷新",
        readyText: "开始加载",
        processingText: "正在加载",
        processedText: "刷新成功",
      ),
      footer:const ClassicFooter(
          processingText: "正在加载"
      ),
      onRefresh:_onRefresh,
      onLoad: _onLoadMore,
      child: ListView.builder(
        itemExtent: 100,
        itemCount: _articles.length,
        itemBuilder: _buildItemByIndex,
      ),
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
                            AppIcons.digg,
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
