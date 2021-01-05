class Event {
  final String eventId;
  final String brideName;
  final String brideId;
  final String groomName;
  final String groomId;
  final double budget;
  final String photoURL;
  final DateTime date;

  Event(
      {this.eventId,
      this.brideName,
      this.brideId,
      this.groomName,
      this.groomId,
      this.budget,
      this.photoURL,
      this.date});

  Event.fromJson(Map<String, dynamic> json)
      : eventId = json['eventId'],
        brideName = json['brideName'],
        brideId = json['brideId'],
        groomName = json['groomName'],
        groomId = json['groomId'],
        budget = json['budget'],
        photoURL = json['photoURL'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'eventId': eventId,
        'brideName': brideName,
        'brideId': brideId,
        'groomName': groomName,
        'groomId': groomId,
        'budget': budget,
        'photoURL': photoURL,
        'date': date
      };
}
