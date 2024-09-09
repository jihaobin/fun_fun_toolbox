import 'package:flutter/material.dart';
import 'package:fun_toolbox/componts/dropdown_selector.dart';

import '../model/article_model.dart';
import 'juejin_article_content.dart';

class JueJinArticlePage extends StatefulWidget {
  JueJinArticlePage({super.key});

  @override
  State<JueJinArticlePage> createState() => _JueJinArticlePageState();
}

class _JueJinArticlePageState extends State<JueJinArticlePage> {
  final categorySelectors = [
    DropdownSelectorModel(selectedName: '推荐', selectedType: ArticleType.recommend),
    DropdownSelectorModel(selectedName: '热门', selectedType: ArticleType.hotALl),
    DropdownSelectorModel(selectedName: '最新', selectedType: ArticleType.news),
    DropdownSelectorModel(selectedName: '3天前', selectedType: ArticleType.day3),
    DropdownSelectorModel(selectedName: '七天前', selectedType: ArticleType.day7),
    DropdownSelectorModel(selectedName: '30天前', selectedType: ArticleType.day30),
  ];

  late DropdownSelectorModel<ArticleType> currentCategory;

  @override
  void initState() {
    super.initState();
    currentCategory = categorySelectors[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('丐版掘金'),
        actions: [
          DropdownSelector(value: currentCategory, items: categorySelectors,onChanged: (value){
            currentCategory = value!;
            setState(() {});
          },)
        ],
      ),
      body: ArticleContent(
        currentCategory: currentCategory,
      ),
    );
  }
}
