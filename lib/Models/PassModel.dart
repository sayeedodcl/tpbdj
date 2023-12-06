class PassModel {
  int? id;
  int? prisonerId;
  int? relativeId;
  int? numberOfPeople;
  int? prisonId;
  int? buildingId;
  int? roomId;
  String? requestedDate;
  String? requestedTime;
  String? approvedDate;
  String? approvedTimeFrom;
  String? approvedTimeTo;
  String? userId;
  String? createdAt;
  String? updatedAt;

  PassModel(
      {required this.id,
      required this.prisonerId,
      required this.relativeId,
     required this.numberOfPeople,
     required this.prisonId,
     required this.buildingId,
     required this.roomId,
     required this.requestedDate,
     required this.requestedTime,
     required this.approvedDate,
     required this.approvedTimeFrom,
     required this.approvedTimeTo,
     required this.userId,
     required this.createdAt,
     required this.updatedAt});

  PassModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prisonerId = json['prisoner_id'];
    relativeId = json['relative_id'];
    numberOfPeople = json['number_of_people'];
    prisonId = json['prison_id'];
    buildingId = json['building_id'];
    roomId = json['room_id'];
    requestedDate = json['requested_date'];
    requestedTime = json['requested_time'];
    approvedDate = json['approved_date'];
    approvedTimeFrom = json['approved_time_from'];
    approvedTimeTo = json['approved_time_to'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['prisoner_id'] = this.prisonerId;
    data['relative_id'] = this.relativeId;
    data['number_of_people'] = this.numberOfPeople;
    data['prison_id'] = this.prisonId;
    data['building_id'] = this.buildingId;
    data['room_id'] = this.roomId;
    data['requested_date'] = this.requestedDate;
    data['requested_time'] = this.requestedTime;
    data['approved_date'] = this.approvedDate;
    data['approved_time_from'] = this.approvedTimeFrom;
    data['approved_time_to'] = this.approvedTimeTo;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}