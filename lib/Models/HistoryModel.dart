class HistoryModel {
  int? id;
  String? typeCode;
  int? prisonId;
  int? prisonerId;
  String? from;
  String? to;
  String? transferDate;
  String? transferTime;
  String? transferStatus;
  int? userId;
  String? createdAt;
  String? updatedAt;

  HistoryModel(
      {required this.id,
      required this.typeCode,
     required this.prisonId,
     required this.prisonerId,
     required this.from,
     required this.to,
     required this.transferDate,
     required this.transferTime,
     required this.transferStatus,
     required this.userId,
     required this.createdAt,
     required this.updatedAt});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeCode = json['type_code'];
    prisonId = json['prison_id'];
    prisonerId = json['prisoner_id'];
    from = json['from'];
    to = json['to'];
    transferDate = json['transfer_date'];
    transferTime = json['transfer_time'];
    transferStatus = json['transfer_status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type_code'] = this.typeCode;
    data['prison_id'] = this.prisonId;
    data['prisoner_id'] = this.prisonerId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['transfer_date'] = this.transferDate;
    data['transfer_time'] = this.transferTime;
    data['transfer_status'] = this.transferStatus;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}