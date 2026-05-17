class WorkTimeModel {
  final int? worktimeid;
  final int? provid;

  final bool? sat;
  final bool? sun;
  final bool? mon;
  final bool? tue;
  final bool? wed;
  final bool? thr;
  final bool? fri;

  final String? fromTime;
  final String? toTime;

  WorkTimeModel({
    this.worktimeid,
    this.provid,
    this.sat=false,
    this.sun=false,
    this.mon=false,
    this.tue=false,
    this.wed=false,
    this.thr=false,
    this.fri=false,
    this.fromTime,
    this.toTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "worktimeid": worktimeid,
      "provid": provid,
      "sat": sat,
      "sun": sun,
      "mon": mon,
      "tue": tue,
      "wed": wed,
      "thr": thr,
      "fri": fri,
      "fromtime": fromTime,
      "totime": toTime,
    };
  }
}
