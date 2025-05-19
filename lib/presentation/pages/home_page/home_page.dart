import 'package:flutter/material.dart';
import 'package:fusion_news_app/presentation/pages/home_page/following_page.dart';
import 'package:fusion_news_app/presentation/pages/home_page/trending_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  snap: true,
                  title: TabBar(
                    padding: EdgeInsets.zero,
                    tabs: [
                      const Tab(text: 'Trending'),
                      const Tab(text: 'Your Fusion'),
                    ],
                  ),
                ),
              ],
          body: TabBarView(children: [TrendingPage(), FollowingPage()]),
        ),
      ),
    );
  }
}
