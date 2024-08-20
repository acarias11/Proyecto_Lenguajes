import 'package:app_ahorro/ahorro_page.dart';
import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/widgets/graph.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
   int currentIndex=0;
   final controller =PageController();
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (index){
          currentIndex+index;
          setState(() {});
        },
        children:  const [
           HomePage(),
           HistorialPage(),
           AhorroPage(),
           GraphPage(),
           
        ],
      ),
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey,
        currentIndex: currentIndex,
        onTap: (index){
          currentIndex=index;
          controller.jumpToPage(index);
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house),
              label: 'home'
              ),
  
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clockRotateLeft),
            label: 'historial',
            ),

          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.wallet),
            label: 'Ahorro'
            ),
          BottomNavigationBarItem
          (icon: Icon(FontAwesomeIcons.chartPie),
          label: 'Grafico'
          )
            
         ],
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          child:const Icon(Icons.add),
          onPressed:(){} ,
        ),

     
    );
  }
}
        
