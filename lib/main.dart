import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController alcoolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = "Informe os Valores";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void _reset() {
    alcoolController.text = "";
    gasolinaController.text = "";

    // SetState e para quando você click no botão ele atualizar a tela
    setState(() {
      _resultado = "Informe os Valores";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculaCombustivelIdeal() {
    // SetState e para quando você click no botão ele altere tudo que estiver dentro
    setState(() {
      double vAlcool = double.parse(alcoolController.text.replaceAll(',', '.'));
      double vGasolina =
          double.parse(gasolinaController.text.replaceAll(',', '.'));
      double proporcao = vAlcool / vGasolina;

      if (proporcao < 0.7) {
        _resultado = "Abasteça com Álcool";
      } else {
        _resultado = "Abasteça com Gasolina";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Álcool ou Gasolina ? ",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _reset();
            },
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.local_gas_station,
                size: 140.0,
                color: Colors.lightBlue,
              ),
              TextFormField(
                controller: alcoolController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Informe o Valor do Álcool" : null,
                //Decoração do input
                decoration: InputDecoration(
                  labelText: "Valor do Álcool",
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                ),
                //Decoração do Text
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 26.0,
                ),
              ),
              TextFormField(
                controller: gasolinaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Informe o  Valor da gasolina!": null,
                //Decoração do input
                decoration: InputDecoration(
                  labelText: "Valor da gasolina",
                  labelStyle: TextStyle(color: Colors.lightBlue[900]),
                ),
                //Decoração do Text
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 26.0,
                ),
              ),
              //Espaçamento entre os Inputs e o Botão
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                //O espaçamento tem como filho um Container aonde vai abrigar um botão
                child: Container(
                  height: 50.0,

                  //Botão
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate())
                      _calculaCombustivelIdeal();
                    },
                    //Estilização do Botão
                    child: Text(
                      "Verificar",
                      style: const TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    // color: Colors.lightBlue,
                  ),
                ),
              ),

              Text(
                _resultado,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 26.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
