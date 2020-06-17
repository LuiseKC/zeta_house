class ActionID {
  static const String Motor_Porta_Sala	 = '18';
  static const String Sensor_Fumaca	 = '23';
  static const String SENSOR_LDR_ANALOG	 = '24';
  static const String LED_QUINTAL = '25';
  static const String SENSOR_CHUVA = '8';
  static const String LED_BANHEIRO_SUITE = '7';
  static const String LED_COZINHA = '16';
  static const String LED_BANHEIRO = '20';
  static const String LED_GARAGEM = '21';
  static const String Sensor_Temp = '17';
  static const String LEDS_QUARTO  = '27';
  static const String VENTILADOR = '22';
  static const String Sensor_Presenca = '10';
  static const String Alarme_Speaker = '9';
  static const String Alarme_LED = '11';
  static const String LED_AREA_CONV = '5';
  static const String Motor_Janela = '13';
  static const String LED_QUARTO_CASAL = '19';
  static const String LEDS_SALA = '26';



}

class ActionType {
  static const String LIGHT_ON = 'LIGHT_ON';
  static const String LIGHT_OFF = 'LIGHT_OFF';
  static const String SECURITY_ON = 'SECURITY_ON';
  static const String SECURITY_OFF = 'SECURITY_OFF';
  static const String OPEN_WINDOW = 'OPEN_WINDOW';
  static const String CLOSE_WINDOW = 'CLOSE_WINDOW';
  static const String OPEN_GATE = 'OPEN_GATE';
  static const String CLOSE_GATE = 'CLOSE_GATE';
  static const String OPEN_DOOR = 'OPEN_DOOR';
  static const String CLOSE_DOOR = 'CLOSE_DOOR';

}

class Action {
  String Type;
  String Id;

  Action();
  Action.fromJson(Map<String, dynamic> json)
      : Type = json['data']['type'],
        Id= json['data']['id'];


  Map<String, dynamic> toJson() => {
    'type': Type,
    'id': Id
  };

}