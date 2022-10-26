import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/tema.dart';

class ListasNoticias extends StatelessWidget {
  final List<Article> noticias;
  ListasNoticias(this.noticias);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: noticias[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({required this.noticia, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        _TarjetaTopBar(noticia, index),

        _TarjetaTitulo(noticia),

        _TarjetaImagen(noticia),

        _TarjetaBody(noticia),

        _TarjetaBotones(noticia),

        const SizedBox(height: 10,),

        const Divider(indent: 25, endIndent: 25, thickness: 1.5,),
      ],
    );
  }
}

//------------------------------------------------------------------------------
class _TarjetaBotones extends StatelessWidget {
  final Article noticia;

  const _TarjetaBotones(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            elevation: 10,
            fillColor: Colors.red.shade900,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.star_border_rounded,
              size: 35,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          RawMaterialButton(
            onPressed: () {},
            elevation: 10,
            fillColor: Colors.red.shade900,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.arrow_forward_rounded,
              size: 35,
            ),
          )
        ],
      ),
    );
  }
}

//------------------------------------------------------------------------------
class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Text(
        (noticia.description != null) 
          ?noticia.description.toString() 
          :'', 
          textAlign: TextAlign.justify,
      ),
    );
  }
}

//------------------------------------------------------------------------------
class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen(this.noticia);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.elliptical(68, 120),
        bottomLeft: Radius.elliptical(68, 120),
        topLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: (noticia.urlToImage == null) //agregamos un if ternario al hijo para saber si tiene o no imagen la noticia
              ? const Image(
                  image: AssetImage('assets/img/no-image.png'),
                )
              : FadeInImage(
                  image: NetworkImage(noticia.urlToImage.toString()),
                  placeholder: const AssetImage('assets/img/giphy.gif'),
                  imageErrorBuilder: //it will only be called if an error occurs during image loading, example the image path does not exist
                  (context, error, stackTrace){
                    return const Image(image: AssetImage('assets/img/no-image.png'));
                  },
                )
      ),
    );
  }
}

//------------------------------------------------------------------------------
class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo(this.noticia);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.purple,
      padding: const EdgeInsets.only(left: 10, right: 50),
      child: Text(
        noticia.title,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700,),
        textAlign: TextAlign.start,
      ),
    );
  }
}

//------------------------------------------------------------------------------
class _TarjetaTopBar extends StatelessWidget {
  final Article noticia;
  final int index;

  const _TarjetaTopBar(this.noticia, this.index);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10,top: 7,),
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: <Widget>[
              Text(
                '${index + 1}. ', style: TextStyle( color: miTema.colorScheme.secondary, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration( borderRadius: BorderRadius.circular(5), color: Colors.red.shade900,),
                child: Text( '${noticia.source.name}. ', style: const TextStyle(fontSize: 15),),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.only(right: 30),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: getAuthorStatus(noticia),
                
                /*(!noticia.author.toString().isEmpty /*|| noticia.author.toString().startsWith('http') != ''*/)
                  ? Text('${noticia.author}', style: const TextStyle(fontSize: 10),)
                  : const Text(''),*/
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget getAuthorStatus(noticia) {

  if (noticia.author != null) {
    if(noticia.author.toString().startsWith('http')){
      return const Text('');
    }
    return Text('${noticia.author}', style: const TextStyle(fontSize: 10),);
  }
  else {
    return const Icon(
      Icons.horizontal_rule_rounded,
      //size: 200,
      //color: Colors.black,
    );
  }
}
