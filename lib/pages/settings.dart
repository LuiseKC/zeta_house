import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zeta_house/pages/home_page.dart';
import 'package:zeta_house/shared/drawer.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final title = 'Configurações';

  String urlApi = 'https://zeta-house.herokuapp.com';

  bool sensorChuva;
  bool sensorGas;
  double temp = 20;
  bool ativoTemp;
  bool sensorLdr;

  @override
  void initState() {
    sensorChuva = false;
    sensorGas = false;
    temp = 20;
    ativoTemp = false;
    sensorLdr = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(title: Text(title), actions: <Widget>[
        FlatButton(
          textColor: Colors.white,
          onPressed: () {
            configAction(sensorChuva, sensorGas, temp, ativoTemp, sensorLdr);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Text("Salvar"),
        ),
      ]),
      body: Column(
        children: <Widget>[
          Container(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection("Sensor")
                  .where("Excluido", isEqualTo: false)
                  .where("TipoID", isEqualTo: '4')
                  .orderBy("ComodoDescricao")
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => Divider(
                      color: Color.fromRGBO(19, 137, 196, 0.5),
                    ),
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    padding: const EdgeInsets.all(5.0),
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.documents[index];
                      if (ds['SensorID'] == 23) {
                        sensorGas = ds["Ativado"] == 1 ? true : false;
                      }
                      if (ds['SensorID'] == 17) {
                        ativoTemp = ds["Ativado"] == 1 ? true : false;
                      }
                      if (ds['SensorID'] == 24) {
                        sensorLdr = ds["Ativado"] == 1 ? true : false;
                      }
                      if (ds['SensorID'] == 8) {
                        sensorChuva = ds["Ativado"] == 1 ? true : false;
                      }
                      Row row = Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 25.0, bottom: 25.0),
                          ),
                          Expanded(
                            child: Text(
                              ds["Descricao"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            flex: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: Switch(
                              value: ds["Ativado"] == 1 ? true : false,
                              onChanged: (value) {
                                setState(() {
                                  Firestore.instance
                                      .collection('Sensor')
                                      .document(ds.documentID)
                                      .updateData({
                                    'Ativado': value ? 1 : 0,
                                  });
                                });
                              },
                              activeTrackColor: Color.fromRGBO(19, 37, 69, 0.8),
                              activeColor: Color.fromRGBO(26, 58, 128, 0.8),
                            ),
                          ),
                        ],
                      );
                      return row;
                    },
                  );
                } else {
                  return Text("Carregando");
                }
              },
            ),
          ),
          SizedBox(height: 60),
          Column(
            children: <Widget>[
              Text("Temperatura"),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.blue[700],
                  inactiveTrackColor: Colors.blue[100],
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 4.0,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  thumbColor: Colors.blueAccent,
                  overlayColor: Colors.blue.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                  tickMarkShape: RoundSliderTickMarkShape(),
                  activeTickMarkColor: Colors.blue[700],
                  inactiveTickMarkColor: Colors.blue[100],
                  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                  valueIndicatorColor: Colors.blueAccent,
                  valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Slider(
                  value: temp,
                  min: 10,
                  max: 35,
                  divisions: 25,
                  label: '$temp',
                  onChanged: (value) {
                    setState(
                      () {
                        temp = value;
                      },
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void configAction(bool sensorChuva, bool sensorGas, double temp, bool ativo,
      bool ldr) async {
    String requestUrl = urlApi + '/changeconfig';
    Map<String, dynamic> json = {
      'sensorChuva': sensorChuva,
      'sensorGas': sensorGas,
      'climatizacao': {'temp': temp, 'ativo': ativo},
      'ldr': ldr
    };
    print(json);
    http.Response resp = await http.post(requestUrl, body: json);
    print(resp);
  }
}
