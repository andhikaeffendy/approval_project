// To parse this JSON data, do
//
//     final approvalHistoryResponse = approvalHistoryResponseFromJson(jsonString);

import 'dart:convert';

ApprovalHistoryResponse approvalHistoryResponseFromJson(String str) => ApprovalHistoryResponse.fromJson(json.decode(str));

String approvalHistoryResponseToJson(ApprovalHistoryResponse data) => json.encode(data.toJson());

class ApprovalHistoryResponse {
  ApprovalHistoryResponse({
    this.data,
    this.status,
    this.message,
  });

  List<Datum> data;
  String status;
  String message;

  factory ApprovalHistoryResponse.fromJson(Map<String, dynamic> json) {
    if(json["data"]==null){
      return ApprovalHistoryResponse(
        status: json["status"],
        message: json["message"],
      );
    }else{
      return ApprovalHistoryResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );
    }
  }

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
    "message": message,
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.formDate,
    this.documentNumber,
    this.costAllocation,
    this.purposeOfIssue,
    this.procurementType,
    this.issuedBy,
    this.recurringOption,
    this.percentage,
  });

  int id;
  String name;
  DateTime formDate;
  String documentNumber;
  String costAllocation;
  String purposeOfIssue;
  String procurementType;
  String issuedBy;
  String recurringOption;
  int percentage;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    formDate: DateTime.parse(json["form_date"]),
    documentNumber: json["document_number"],
    costAllocation: json["cost_allocation"],
    purposeOfIssue: json["purpose_of_issue"],
    procurementType: json["procurement_type"],
    issuedBy: json["issued_by"],
    recurringOption: json["recurring_option"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "form_date": "${formDate.year.toString().padLeft(4, '0')}-${formDate.month.toString().padLeft(2, '0')}-${formDate.day.toString().padLeft(2, '0')}",
    "document_number": documentNumber,
    "cost_allocation": costAllocation,
    "purpose_of_issue": purposeOfIssue,
    "procurement_type": procurementType,
    "issued_by": issuedBy,
    "recurring_option": recurringOption,
    "percentage": percentage,
  };
}
