class DeleteCarGroupRequest {
  final int groupId;

  DeleteCarGroupRequest({
    required this.groupId,

  });

  Map<String, dynamic> toJson() {
    return {
      "groupId": groupId,
    };
  }
}