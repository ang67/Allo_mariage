import 'package:allo_mariage/models/event.dart';
import 'package:allo_mariage/services/FirestoreService.dart';
import 'package:allo_mariage/utils/app_data_constantes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

Future signDialog(BuildContext context, String userId) {
  final _formKey = GlobalKey<FormState>();
  int role = 0;
  DateTime date;
  final FirestoreService _firestoreService = FirestoreService();
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(0),
              content: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    right: -40.0,
                    top: -40.0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.close),
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /******************************** */
                        // dropdown
                        DropdownButtonFormField<String>(
                          style: Theme.of(context).textTheme.bodyText1,
                          value: ROLES[role],
                          items: [...ROLES]
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text('Rôle'),
                          onChanged: (value) {
                            setState(() {
                              role = ROLES.indexOf(value);
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 0.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor,
                                    width: 1.0)),
                            prefixIcon: const Icon(
                              Icons.work,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        /******************************** */

                        ([0, 1].contains(role))
                            ? Padding(
                                padding: EdgeInsets.all(1.0),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Text('Date du mariage',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    DateTimePicker(
                                        calendarTitle: 'Date du mariage',
                                        type:
                                            DateTimePickerType.dateTimeSeparate,
                                        dateMask: 'd MMM yyyy',
                                        initialValue: null,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                        icon: Icon(Icons.event),
                                        dateLabelText: 'Jour',
                                        timeLabelText: "Heure",
                                        validator: (val) {
                                          return null;
                                        },
                                        onSaved: (val) {
                                          setState(
                                              () => date = DateTime.parse(val));
                                        }),
                                  ],
                                ),
                              )
                            : Container(),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text("Enregistrer",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.white)),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                _firestoreService
                                    .getUser(userId)
                                    .then((userData) {
                                  _userCollectionRef
                                      .doc(userId)
                                      .update({'role': role});

                                  if ([0, 1].contains(role)) {
                                    var a = _firestoreService
                                        .updateEventData(Event(
                                          eventId: userId +
                                              '${DateTime.now().millisecondsSinceEpoch}',
                                          brideName: role == 0
                                              ? userData['name']
                                              : null,
                                          brideId:
                                              role == 0 ? userData['id'] : null,
                                          groomName: role == 1
                                              ? userData['name']
                                              : null,
                                          groomId:
                                              role == 1 ? userData['id'] : null,
                                          budget: null,
                                          photoURL: null,
                                          date: date,
                                        ))
                                        .then(
                                            (value) => Navigator.pop(context));
                                  }
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
}
