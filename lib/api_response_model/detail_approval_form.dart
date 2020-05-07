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
  String value;
  String supplier;
  String summary;
  String summaryTerm;
  String justification;
  DateTime createdAt;
  List<Detail> details;
  List<dynamic> documents;

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
    this.details,
    this.documents,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    if(json["documents"]==null){
      print("doc null");
      return Data(
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
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );
    }else if(json["details"]==null){
      print("details null");
      return Data(
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
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
      );
    }else if(json["details"]==null && json["documents"]==null){
      print("both null");
      return Data(
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
        createdAt: DateTime.parse(json["created_at"])
      );
    }else{
      print("detail normal");
      return Data(
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
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
      );
    }
  }

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
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "documents": List<dynamic>.from(documents.map((x) => x)),
  };
}

class Detail {
  String item;
  String value;
  int quantity;
  String subTotal;

  Detail({
    this.item,
    this.value,
    this.quantity,
    this.subTotal,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    item: json["item"],
    value: json["value"],
    quantity: json["quantity"],
    subTotal: json["sub_total"],
  );

  Map<String, dynamic> toJson() => {
    "item": item,
    "value": value,
    "quantity": quantity,
    "sub_total": subTotal,
  };
}
