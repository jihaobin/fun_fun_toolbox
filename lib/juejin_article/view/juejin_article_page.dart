import 'package:flutter/material.dart';

import 'juejin_article_content.dart';

class JueJinArticlePage extends StatelessWidget {
  const JueJinArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('丐版掘金'),
      ),
      body: const ArticleContent(),
    );
  }
}
