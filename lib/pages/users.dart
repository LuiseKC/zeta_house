import 'package:flutter/material.dart';

class Users extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Users';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: List.generate(
          choices.length,
          (index) {
            return Center(
              child: ChoiceCard(choice: choices[index], item: choices[index]),
            );
          },
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

//region choices
const List<Choice> choices = const <Choice>[
  const Choice(
      title:
          'This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car.',
      icon: Icons.directions_car),
  const Choice(
      title:
          'This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle. This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle. This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle.',
      icon: Icons.directions_bike),
  const Choice(
      title: 'This is a Boat, because its a Boat. So, it\'s a Boat',
      icon: Icons.directions_boat),
  const Choice(
      title: 'This is a Bus, because its a Bus. So, it\'s a Bus',
      icon: Icons.directions_bus),
  const Choice(
      title: 'This is a Train, because its a Train. So, it\'s a Train',
      icon: Icons.directions_railway),
  const Choice(
      title: 'This is a Walk, because its a Walk. So, it\'s a Walk',
      icon: Icons.directions_walk),
  const Choice(
      title:
          'This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car.',
      icon: Icons.directions_car),
  const Choice(
      title: 'This is a Car, because its a car. So, it\'s a car',
      icon: Icons.directions_car),
  const Choice(
      title: 'This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle',
      icon: Icons.directions_bike),
  const Choice(
      title: 'This is a Boat, because its a Boat. So, it\'s a Boat',
      icon: Icons.directions_boat),
  const Choice(
      title: 'This is a Bus, because its a Bus. So, it\'s a Bus',
      icon: Icons.directions_bus),
  const Choice(
      title: 'This is a Train, because its a Train. So, it\'s a Train',
      icon: Icons.directions_railway),
  const Choice(
      title: 'This is a Walk, because its a Walk. So, it\'s a Walk',
      icon: Icons.directions_walk),
  const Choice(
      title:
          'This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car.',
      icon: Icons.directions_car),
  const Choice(
      title: 'This is a Car, because its a car. So, it\'s a car',
      icon: Icons.directions_car),
  const Choice(
      title: 'This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle',
      icon: Icons.directions_bike),
  const Choice(
      title: 'This is a Boat, because its a Boat. So, it\'s a Boat',
      icon: Icons.directions_boat),
  const Choice(
      title: 'This is a Bus, because its a Bus. So, it\'s a Bus',
      icon: Icons.directions_bus),
  const Choice(
      title:
          'This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car. This is a Car, because its a car. So, it\'s a car.',
      icon: Icons.directions_car),
  const Choice(
      title: 'This is a Train, because its a Train. So, it\'s a Train',
      icon: Icons.directions_railway),
  const Choice(
      title: 'This is a Walk, because its a Walk. So, it\'s a Walk',
      icon: Icons.directions_walk),
  const Choice(
      title: 'This is a Car, because its a car. So, it\'s a car',
      icon: Icons.directions_car),
  const Choice(
      title: 'This is a Bicycle, because its a Bicycle. So, it\'s a Bicycle',
      icon: Icons.directions_bike),
  const Choice(
      title: 'This is a Boat, because its a Boat. So, it\'s a Boat',
      icon: Icons.directions_boat),
  const Choice(
      title: 'This is a Bus, because its a Bus. So, it\'s a Bus',
      icon: Icons.directions_bus),
  const Choice(
      title: 'This is a Train, because its a Train. So, it\'s a Train',
      icon: Icons.directions_railway),
  const Choice(
      title: 'This is a Walk, because its a Walk. So, it\'s a Walk',
      icon: Icons.directions_walk),
];
//endregion

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {Key key,
      this.choice,
      this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final Choice choice;
  final VoidCallback onTap;
  final Choice item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.topLeft,
              child: Icon(
                choice.icon,
                size: 80.0,
                color: Color.fromRGBO(19, 37, 69, 1),
              )),
          Expanded(
            child: new Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.topLeft,
              child: Text(
                choice.title,
                style: TextStyle(
                  color: Color.fromRGBO(19, 37, 69, 1),
                ),
                textAlign: TextAlign.left,
                maxLines: 5,
              ),
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
