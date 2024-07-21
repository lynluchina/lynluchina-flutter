import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_estate/widgets/webview_screen.dart';
import '/utils/data.dart';
import '/theme/color.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _displayedArticles = [];
  List<Map<String, dynamic>> _filteredArticles = [];
  int _currentPage = 0;
  final int _articlesPerPage = 10;
  bool _hasMore = true;
  bool _sortLatest = true;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredArticles = List.from(articles);
    _sortArticles();
    _loadMoreArticles();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMoreArticles();
    }
  }

  void _loadMoreArticles() {
    if (_hasMore) {
      final startIndex = _currentPage * _articlesPerPage;
      final endIndex = startIndex + _articlesPerPage;
      
      if (startIndex < _filteredArticles.length) {
        setState(() {
          _displayedArticles.addAll(
            _filteredArticles.sublist(startIndex, endIndex > _filteredArticles.length ? _filteredArticles.length : endIndex)
          );
          _currentPage++;
          _hasMore = endIndex < _filteredArticles.length;
        });
      } else {
        setState(() {
          _hasMore = false;
        });
      }
    }
  }

  void _searchArticles(String query) {
    setState(() {
      _filteredArticles = articles.where((article) =>
        article['title'].toLowerCase().contains(query.toLowerCase())
      ).toList();
      _sortArticles();
      _resetList();
    });
  }

  void _sortArticles() {
    _filteredArticles.sort((a, b) {
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);
      return _sortLatest ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _sortLatest = !_sortLatest;
      _sortArticles();
      _resetList();
    });
  }

  void _resetList() {
    _currentPage = 0;
    _displayedArticles.clear();
    _hasMore = true;
    _loadMoreArticles();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchArticles('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      appBar: AppBar(
        title: _isSearching
          ? TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: '搜索文章...',
                hintStyle: TextStyle(color: AppColor.mainColor.withOpacity(0.5)),
                border: InputBorder.none,
              ),
              style: TextStyle(color: AppColor.mainColor),
              onChanged: _searchArticles,
            )
          : Text('文章', style: TextStyle(color: AppColor.mainColor)),
        backgroundColor: AppColor.cardColor,
        elevation: 0,
        leading: _isSearching
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: AppColor.mainColor),
              onPressed: _toggleSearch,
            )
          : null,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search, color: AppColor.mainColor),
            onPressed: _toggleSearch,
          ),
          IconButton(
            icon: Icon(Icons.sort, color: AppColor.mainColor),
            onPressed: _toggleSortOrder,
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _displayedArticles.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _displayedArticles.length) {
            return ArticleCard(article: _displayedArticles[index]);
          } else if (_hasMore) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}


class ArticleCard extends StatelessWidget {
  final Map<String, dynamic> article;

  const ArticleCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          var link  = article['link'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: link),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                article['img_url'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.mainColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _formatDate(article['date']),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.inActiveColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return DateFormat.yMMMd().format(date);
  }
}