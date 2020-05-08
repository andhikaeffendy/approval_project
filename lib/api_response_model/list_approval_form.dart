// To parse this JSON data, do
//
//     final listApprovalForm = listApprovalFormFromJson(jsonString);

import 'dart:convert';

ListApprovalForm listApprovalFormFromJson(String str) => ListApprovalForm.fromJson(json.decode(str));

String listApprovalFormToJson(ListApprovalForm data) => json.encode(data.toJson());

class ListApprovalForm {
  List<Datum> data;
  String status;
  String message;

  ListApprovalForm({
    this.data,
    this.status,
    this.message,
  });

  factory ListApprovalForm.fromJson(Map<String, dynamic> json) {
    if(json["data"]==null){
      return ListApprovalForm(
        status: json["status"],
        message: json["message"],
      );
    }else{
      return ListApprovalForm(
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
  int id;
  String name;
  DateTime formDate;
  String documentNumber;
  String costAllocation;
  String purposeOfIssue;
  String procurementType;
  String issuedBy;
  String recurringOption;
  double percentage;

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
    percentage: json["percentage"].toDouble(),
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
