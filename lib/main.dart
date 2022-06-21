import 'package:flutter/material.dart';
import 'package:conversor_app/helpers/gialogs.dart';

// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: avoid_print
//ignore_for_file: avoid_unnecessary_containers
//ignore_for_file: use_key_in_widget_constructors
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> _medidas = [
    'Metros',
    'Kilometros',
    'Gramos',
    'Kilogramos',
    'Pies',
    'Millas',
    'Libras',
    'Onzas',
  ];
  late String _startM;
  late String _endM;
  late int _startI;
  late int _endI;
  late String _endValue = "0";
  final valueController = TextEditingController();
  final _formulas = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.0001, 0, 0, 0, 0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0, 02835, 3.28084, 0, 0.0625, 1],
  ];
  @override
  void initState() {
    _startI = 0;
    _endI = 1;
    _startM = _medidas[_startI];
    _endM = _medidas[_endI];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(color: Colors.blueGrey[900], fontSize: 20);
    final measureStyle = TextStyle(color: Colors.black87, fontSize: 15);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("CONVERSOR DE MEDIDAS"),
      ),
      body: Container(
        child: Builder(
          builder: (BuildContext context) => SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Quiero convertir",
                    style: labelStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: valueController,
                    decoration: InputDecoration(
                      hintText: "Valor inicial a convertir",
                    ),
                  ),
                ),
                DropdownButton<String>(
                    value: _startM,
                    items: _medidas.map((m) {
                      return DropdownMenuItem(
                          value: m,
                          child: Text(
                            m,
                            style: measureStyle,
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _startM = value!;
                        _startI = _medidas.indexOf(_startM);
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 20, right: 20, bottom: 5),
                  child: Text(
                    "A",
                    style: labelStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: DropdownButton<String>(
                      value: _endM,
                      items: _medidas.map((m) {
                        return DropdownMenuItem(
                            value: m,
                            child: Text(
                              m,
                              style: measureStyle,
                            ));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _endM = value!;
                          _endI = _medidas.indexOf(_endM);
                        });
                      }),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        try {
                          final value =
                              double.parse(valueController.text.trim());
                          setState(() {
                            _endValue = "${value * _formulas[_startI][_endI]}";
                          });
                        } catch (e) {
                          clickBoton(context);
                        }
                      },
                      child: Text("Convertir")),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Resultado"),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(_endValue),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  clickBoton(BuildContext context) {
    infoDialog(
        context: context,
        title: "¡Error!",
        content: "El valor ingresado no es válido");
  }
}
