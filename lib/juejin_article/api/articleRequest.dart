import 'package:dio/dio.dart';

import '../model/article_model.dart';

int articleTypeToValue(ArticleType type) {
  switch (type) {
    case ArticleType.news:
      return 300;
    case ArticleType.hotALl:
      return 0;
    case ArticleType.recommend:
      return 200;
    case ArticleType.day3:
      return 3;
    case ArticleType.day7:
      return 7;
    case ArticleType.day30:
      return 30;
    default:
      return 200;
  }
}

class ArticleApi {
  static const String BASE_URL = 'https://api.juejin.cn/';
  static const String ARTICLE_LIST = 'recommend_api/v1/article/recommend_all_feed';

  final Dio _client = Dio(BaseOptions(baseUrl: BASE_URL));

  Future<List<Article>> loadArticles(
      {int uuid = 0,
      int limit = 20,
      int page = 1,
      ArticleType type = ArticleType.recommend}) async {
      List<Article> articles = [];
      var response = await _client.post(ARTICLE_LIST, queryParameters: {
        'aid': 2608,
        'uuid': uuid,
      }, data: {
        "id_type": 2, // 1: 官方文章 2: 普通文章
        "sort_type": articleTypeToValue(type),
        "cursor": page.toString(),
        "limit": limit
      });

      if(response.statusCode == 200) {
        if(response.data != null) {
          var data = response.data['data'] as List;
          for(var item in data) {
            var article = Article.fromJson(item);
            if(article.title.isNotEmpty){
              articles.add(article);
            }else{
              continue;
            }
          }

          return articles;
        }else{
          throw Exception('数据异常');
        }
      }else{
        throw Exception('请求失败, 状态码: ${response.statusCode}');
      }
  }
}
