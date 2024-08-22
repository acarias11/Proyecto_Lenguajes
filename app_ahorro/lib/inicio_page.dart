import 'package:app_ahorro/ahorro_page.dart';
import 'package:app_ahorro/historial_page.dart';
import 'package:app_ahorro/widgets/configuraciones_page.dart';
import 'package:app_ahorro/widgets/graficos_page.dart';
import 'package:app_ahorro/home_page.dart';
import 'package:app_ahorro/widgets/screens/agregar_ahorro_screen.dart';
import 'package:app_ahorro/widgets/screens/agregar_gastos_screen.dart';
import 'package:app_ahorro/widgets/screens/agregar_ingresos_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  int currentIndex = 2;
  final controller = PageController();

  final GlobalKey<AnimatedFloatingActionButtonState> key =
      GlobalKey<AnimatedFloatingActionButtonState>();

  @override
  Widget build(BuildContext context) {
    Widget float1() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddIngresoPage()));
          },
          heroTag: "btn2",
          tooltip: 'Second button',
          child: const Text('Ingresos'),
        ),
      );
    }

    Widget float2() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AgregarGastoPage()));
          },
          heroTag: "btn1",
          tooltip: 'First button',
          child: const Text('Gastos'),
        ),
      );
    }

    Widget float3() {
      return Container(
        child: FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AgregarAhorroPage()));
          },
          heroTag: "btn3",
          tooltip: 'third button',
          child: const Text('Ahorros'),
        ),
      );
    }

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (index) {
          currentIndex + index;
          setState(() {});
        },
        children: const [
          HistorialPage(),
          AhorroPage(),
          HomePage(),
          UnidosGraficosPage(),
          SettingsScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: CupertinoColors.activeGreen,
        currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chartPie), label: 'Grafico'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Configuracion'),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: AnimatedFloatingActionButton(
            fabButtons: <Widget>[float1(), float2(), float3()],
            key: key,
            colorStartAnimation: Colors.green,
            colorEndAnimation: Colors.red,
            animatedIconData: AnimatedIcons.menu_close),
      ),
    );
  }
}
