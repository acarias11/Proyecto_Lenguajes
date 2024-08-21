import 'package:app_ahorro/ahorro_page.dart';
import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/widgets/configuraciones_page.dart';
import 'package:app_ahorro/widgets/graph.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:app_ahorro/widgets/screens/agregar_ahorro_screen.dart';
import 'package:app_ahorro/widgets/screens/agregar_gastos_screen.dart';
import 'package:app_ahorro/widgets/screens/agregar_ingresos_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';




class InicioPage extends StatefulWidget {
   const InicioPage({super.key});

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
   int currentIndex=0;
   final controller =PageController();
   
      final GlobalKey<AnimatedFloatingActionButtonState> key =GlobalKey<AnimatedFloatingActionButtonState>();
  


  @override
  Widget build(BuildContext context) {
    Widget float1() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: (){
           Navigator.push(context,MaterialPageRoute(builder: (context) => AddIngresoPage()));
        },
        heroTag: "btn2",
        tooltip: 'Second button',
        child:Text('Ingresos'),
      ),
    );
}
Widget float2() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => AgregarGastoPage()));
        },
        heroTag: "btn1",
        tooltip: 'First button',
        child:Text('Gastos'),
      ),
    );
}
Widget float3() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => AgregarAhorroPage()));
        },
        heroTag: "btn3",
        tooltip: 'third button',
        child:Text('Ahorros'),
      ),
    );
}
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (index){
          currentIndex+index;
          setState(() {});
        },
        children:   [
           HistorialPage(),
           AhorroPage(),
           HomePage(),
           LineChartWidget(gradientColor1: AppColors.contentColorOrange, gradientColor2: AppColors.contentColorPink,
           gradientColor3: AppColors.contentColorPurple, indicatorStrokeColor: AppColors.contentColorYellow,),
           SettingsScreen(),           
        ],
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: CupertinoColors.activeGreen,
        currentIndex: currentIndex,
        onTap: (index){
          currentIndex=index;
          controller.jumpToPage(index);
          setState(() {});
        },
        items: const [
          
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.clockRotateLeft),
            label: 'historial',
            ),
            BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.wallet),
            label: 'Ahorro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home'
              ),
              BottomNavigationBarItem
          (icon: Icon(FontAwesomeIcons.chartPie),
          label: 'Grafico'
          ),
  
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuracion'
            ),
          
            
         ],
        ),
         floatingActionButton: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
           child: AnimatedFloatingActionButton(
                   fabButtons: <Widget>[
              float1(), float2(), float3()
                   ],
                   key :  key,
                   colorStartAnimation: Colors.green,
                   colorEndAnimation: Colors.red,
                   animatedIconData: AnimatedIcons.menu_close
               ),
         ),


     
    );
    
  }
}
        


