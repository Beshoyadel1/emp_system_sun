class GetDriverDetailsRequest {
  final int driverId;

  GetDriverDetailsRequest({
    required this.driverId,

  });

  Map<String, dynamic> toJson() {
    return {
      "driverId": driverId,
    };
  }
}