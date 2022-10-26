import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:newsapp/src/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';


class Tab2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsServcie = Provider.of<NewsServices>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
             _ListaCategoria(),

             Expanded(child: ListasNoticias(newsServcie.getArticulosCategoriaSeleccionada)),

          ],
        )
       ),
    );
  }
}

class _ListaCategoria extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<NewsServices>(context).categories;
    final newsServices = Provider.of<NewsServices>(context);

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {

          final categoryName = categories[index].name;

          return Padding(
            padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                const SizedBox(height: 5,),
                Text(
                  '${categoryName[0].toUpperCase()}${categoryName.substring(1)}', 
                  style: TextStyle(
                    color: (newsServices.selectedCategory == categoryName)
                      ? miTema.colorScheme.secondary
                      : Colors.white70,
                  ),
                ), //para que la primera letra sea mayuscula
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {

  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsServices = Provider.of<NewsServices>(context);

    return GestureDetector(
      onTap: (){
        //print("${categoria.name}");
        final newsServices = Provider.of<NewsServices>(context, listen: false);
        newsServices.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        /*decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black38,
        ),*/
        child: Icon(
          categoria.icon,
          color: (newsServices.selectedCategory == categoria.name)
            ? miTema.colorScheme.secondary
            : Colors.white54,
        ),
      ),
    );
  }
}