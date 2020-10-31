import 'package:flutter/material.dart';

class RolesDialogs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
      child: Text('GRID SERVICE'),
      onPressed: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Je suis Marthe"),
            content: Text("Tu hésite et tu veux de l'ade ?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context, 'Non'),
                child: Text("Non merci"),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context, 'Oui'),
                child: Text("Oui"),
              )
            ],
          ),
        ).then((returnVal) {
          if (returnVal != null) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('You clicked: $returnVal'),
                action: SnackBarAction(label: 'OK', onPressed: () {}),
              ),
            );
          }
        });
      },
    ));
  }
}
