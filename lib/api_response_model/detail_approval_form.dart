// To parse this JSON data, do
//
//     final detailApprovalForm = detailApprovalFormFromJson(jsonString);

import 'dart:convert';

DetailApprovalForm detailApprovalFormFromJson(String str) => DetailApprovalForm.fromJson(json.decode(str));

String detailApprovalFormToJson(DetailApprovalForm data) => json.encode(data.toJson());

class DetailApprovalForm {
  Data data;
  String status;
  String message;

  DetailApprovalForm({
    this.data,
    this.status,
    this.message,
  });

  factory DetailApprovalForm.fromJson(Map<String, dynamic> json) => DetailApprovalForm(
    data: Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  int id;
  String name;
  DateTime formDate;
  String documentNumber;
  String costAllocation;
  String purposeOfIssue;
  String procurementType;
  String issuedBy;
  String recurringOption;
  int value;
  String supplier;
  String summary;
  String summaryTerm;
  String justification;
  DateTime createdAt;

  Data({
    this.id,
    this.name,
    this.formDate,
    this.documentNumber,
    this.costAllocation,
    this.purposeOfIssue,
    this.procurementType,
    this.issuedBy,
    this.recurringOption,
    this.value,
    this.supplier,
    this.summary,
    this.summaryTerm,
    this.justification,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    formDate: DateTime.parse(json["form_date"]),
    documentNumber: json["document_number"],
    costAllocation: json["cost_allocation"],
    purposeOfIssue: json["purpose_of_issue"],
    procurementType: json["procurement_type"],
    issuedBy: json["issued_by"],
    recurringOption: json["recurring_option"],
    value: json["value"],
    supplier: json["supplier"],
    summary: json["summary"],
    summaryTerm: json["summary_term"],
    justification: json["justification"],
    createdAt: DateTime.parse(json["created_at"]),
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
    "value": value,
    "supplier": supplier,
    "summary": summary,
    "summary_term": summaryTerm,
    "justification": justification,
    "created_at": createdAt.toIso8601String(),
  };
}
