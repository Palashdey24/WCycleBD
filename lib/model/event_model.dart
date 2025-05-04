import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  EventModel(
      {this.litteredImpactLevel,
      this.litteredVillMet,
      this.eventsOnline,
      this.eventsTittle,
      this.litteredAddress,
      this.userId,
      this.eventsInterested,
      this.litteredThana,
      this.litteredWard,
      this.eventsDate,
      this.eventsId,
      this.eventsTime,
      this.ltSrc,
      this.litteredDivision,
      this.eventsDescription,
      this.createTimeStamp});

  EventModel.fromJson(dynamic json) {
    litteredImpactLevel = json['litteredImpactLevel'];
    litteredVillMet = json['litteredVillMet'];
    eventsOnline = json['eventsOnline'];
    eventsTittle = json['eventsTittle'];
    litteredAddress = json['litteredAddress'];
    userId = json['userId'];
    eventsInterested = json['eventsInterested'];
    litteredThana = json['litteredThana'];
    litteredWard = json['litteredWard'];
    eventsDate = json['eventsDate'];
    eventsId = json['eventsId'];
    eventsTime = json['eventsTime'];
    ltSrc = json['ltSrc'];
    litteredDivision = json['litteredDivision'];
    eventsDescription = json['eventsDescription'];
    createTimeStamp = json['createTimeStamp'];
  }
  String? litteredImpactLevel;
  String? litteredVillMet;
  bool? eventsOnline;
  String? eventsTittle;
  String? litteredAddress;
  String? userId;
  num? eventsInterested;
  String? litteredThana;
  String? litteredWard;
  String? eventsDate;
  String? eventsId;
  String? eventsTime;
  String? ltSrc;
  String? litteredDivision;
  String? eventsDescription;
  Timestamp? createTimeStamp;
  EventModel copyWith(
          {String? litteredImpactLevel,
          String? litteredVillMet,
          bool? eventsOnline,
          String? eventsTittle,
          String? litteredAddress,
          String? userId,
          num? eventsInterested,
          String? litteredThana,
          String? litteredWard,
          String? eventsDate,
          String? eventsId,
          String? eventsTime,
          String? ltSrc,
          String? litteredDivision,
          String? eventsDescription,
          Timestamp? createTimeStamp}) =>
      EventModel(
        litteredImpactLevel: litteredImpactLevel ?? this.litteredImpactLevel,
        litteredVillMet: litteredVillMet ?? this.litteredVillMet,
        eventsOnline: eventsOnline ?? this.eventsOnline,
        eventsTittle: eventsTittle ?? this.eventsTittle,
        litteredAddress: litteredAddress ?? this.litteredAddress,
        userId: userId ?? this.userId,
        eventsInterested: eventsInterested ?? this.eventsInterested,
        litteredThana: litteredThana ?? this.litteredThana,
        litteredWard: litteredWard ?? this.litteredWard,
        eventsDate: eventsDate ?? this.eventsDate,
        eventsId: eventsId ?? this.eventsId,
        eventsTime: eventsTime ?? this.eventsTime,
        ltSrc: ltSrc ?? this.ltSrc,
        litteredDivision: litteredDivision ?? this.litteredDivision,
        eventsDescription: eventsDescription ?? this.eventsDescription,
        createTimeStamp: createTimeStamp ?? this.createTimeStamp,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['litteredImpactLevel'] = litteredImpactLevel;
    map['litteredVillMet'] = litteredVillMet;
    map['eventsOnline'] = eventsOnline;
    map['eventsTittle'] = eventsTittle;
    map['litteredAddress'] = litteredAddress;
    map['userId'] = userId;
    map['eventsInterested'] = eventsInterested;
    map['litteredThana'] = litteredThana;
    map['litteredWard'] = litteredWard;
    map['eventsDate'] = eventsDate;
    map['eventsId'] = eventsId;
    map['eventsTime'] = eventsTime;
    map['ltSrc'] = ltSrc;
    map['litteredDivision'] = litteredDivision;
    map['eventsDescription'] = eventsDescription;
    map['createTimeStamp'] = createTimeStamp;
    return map;
  }
}
