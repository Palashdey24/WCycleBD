class EventInterestedModel {
  EventInterestedModel(
      {this.eventsId, this.eventsInterested, this.interestedUsers});

  num? eventsInterested;
  String? eventsId;
  List<String>? interestedUsers;

  EventInterestedModel.fromJson(dynamic json) {
    eventsInterested = json['eventsInterested'];
    eventsId = json['eventsId'];
    interestedUsers = List.castFrom<dynamic, String>(json['interestedUsers']);
  }

  EventInterestedModel copyWith(
          {String? eventsId,
          num? eventsInterested,
          List<String>? interestedUsers}) =>
      EventInterestedModel(
        eventsInterested: eventsInterested ?? this.eventsInterested,
        interestedUsers: interestedUsers ?? this.interestedUsers,
        eventsId: eventsId ?? this.eventsId,
      );
}
