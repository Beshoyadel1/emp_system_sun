class AddCompanyDriverRequest {
  final String userName;
  final String phone;
  final int companyId;

  AddCompanyDriverRequest({
    required this.userName,
    required this.phone,
    required this.companyId,
  });

  Map<String, dynamic> toJson() {
    return {
      "USERNAME": userName,
      "PHONE": phone,
      "COMPANYID": companyId,
    };
  }
}