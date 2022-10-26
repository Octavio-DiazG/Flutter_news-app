import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:newsapp/src/theme/tema.dart';
import 'package:provider/provider.dart';


class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: miTema.colorScheme.secondary,
      currentIndex: navegacionModel.paginaActual, //numero a cambiar
      onTap: (i){ 
        navegacionModel.paginaActual = i;
      },
      items: const[
        BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public_outlined), label: 'Global'),
      ]
    );
  }
}


class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context); 

    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget> [
        Tab1Page(), //Mostramos la Primera pagina de Tab1
        Tab2Page(),
      ],
    );
  }
}



class _NavegacionModel with ChangeNotifier{

  int _paginaActual = 0;
  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;
  set paginaActual(int valor) {
    _paginaActual = valor;

    _pageController.animateToPage(valor, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);

    notifyListeners();
  }

  PageController get pageController => this._pageController;
}











