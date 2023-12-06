class Prisoners {
  int? id;
  String? pid;
  String? prisonerId;
  String? caseNo;
  String? dob;
  String? name;
  String? fatherName;
  String? motherName;
  String? husbandName;
  String? wifeName;
  String? nationalId;
  String? birthCertificateId;
  String? country;
  String? division;
  String? district;
  String? subDistrict;
  String? address;
  String? image;
  String? identifier1;
  String? identifier2;
  String? identifier3;
  String? identifier4;
  String? identifier5;
  String? locationInsidePrison;
  int? relativeId;
  int? prisonId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Prisoners({
       this.id,
      this.pid,
      this.prisonerId,
      this.caseNo,
      this.dob,
      this.name,
      this.fatherName,
      this.motherName,
      this.husbandName,
      this.wifeName,
      this.nationalId,
      this.birthCertificateId,
      this.country,
      this.division,
      this.district,
      this.subDistrict,
      this.address,
      this.image,
      this.identifier1,
      this.identifier2,
      this.identifier3,
      this.identifier4,
      this.identifier5,
      this.locationInsidePrison,
      this.relativeId,
      this.prisonId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Prisoners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    prisonerId = json['prisoner_id'];
    caseNo = json['case_no'];
    dob = json['dob'];
    name = json['name'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    husbandName = json['husband_name'];
    wifeName = json['wife_name'];
    nationalId = json['national_id'];
    birthCertificateId = json['birth_certificate_id'];
    country = json['country'];
    division = json['division'];
    district = json['district'];
    subDistrict = json['sub_district'];
    address = json['address'];
    image = json['image'];
    identifier1 = json['identifier_1'];
    identifier2 = json['identifier_2'];
    identifier3 = json['identifier_3'];
    identifier4 = json['identifier_4'];
    identifier5 = json['identifier_5'];
    locationInsidePrison = json['location_inside_prison'];
    relativeId = json['relative_id'];
    prisonId = json['prison_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['prisoner_id'] = this.prisonerId;
    data['case_no'] = this.caseNo;
    data['dob'] = this.dob;
    data['name'] = this.name;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['husband_name'] = this.husbandName;
    data['wife_name'] = this.wifeName;
    data['national_id'] = this.nationalId;
    data['birth_certificate_id'] = this.birthCertificateId;
    data['country'] = this.country;
    data['division'] = this.division;
    data['district'] = this.district;
    data['sub_district'] = this.subDistrict;
    data['address'] = this.address;
    data['image'] = this.image;
    data['identifier_1'] = this.identifier1;
    data['identifier_2'] = this.identifier2;
    data['identifier_3'] = this.identifier3;
    data['identifier_4'] = this.identifier4;
    data['identifier_5'] = this.identifier5;
    data['location_inside_prison'] = this.locationInsidePrison;
    data['relative_id'] = this.relativeId;
    data['prison_id'] = this.prisonId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}