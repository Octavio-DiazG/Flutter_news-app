import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;


const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY = '102b34265a204c818e3c7943380d1431';

class NewsServices with ChangeNotifier{

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.stethoscope, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyball, 'sports'),
    Category(FontAwesomeIcons.microchip, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsServices(){
    getTopHeadlines();

    categories.forEach((item) { 
      categoryArticles[item.name] = [];
    });
  }

  
  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor){
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  get getArticulosCategoriaSeleccionada => categoryArticles[selectedCategory];

  getTopHeadlines() async {
    
    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx');
    final resp = await  http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    headlines.addAll(newsResponse.articles);
    notifyListeners();
    
  }

  getArticlesByCategory(String category) async {

    if (categoryArticles[category]!.isNotEmpty) {
      return categoryArticles[category];
    }

    final url = Uri.parse('$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx&category=$category');
    final resp = await  http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);

    categoryArticles[category]?.addAll(newsResponse.articles);

    notifyListeners();
  }

}