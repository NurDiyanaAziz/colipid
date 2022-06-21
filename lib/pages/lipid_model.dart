class LipidModel {
  String date;
  String id;
  String time;
  String? comment;
  final String ic;
  double tc, hdl, ldl, trigly; //TotalCholesterol = tc
  String? tcstatus, ldlstatus, hdlstatus, triglystatus;
  String? drname;

  LipidModel({
    this.comment = '',
    this.date = '',
    this.id = '',
    this.time = '',
    required this.ic,
    this.tc = 0,
    this.hdl = 0,
    this.ldl = 0,
    this.trigly = 0,
    this.tcstatus = '',
    this.hdlstatus = '',
    this.ldlstatus = '',
    this.triglystatus = '',
    this.drname = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'date': date,
      'id': id,
      'time': time,
      'ic': ic,
      'tc': tc,
      'hdl': hdl,
      'ldl': ldl,
      'trigly': trigly,
      'tcstatus': tcstatus,
      'hdlstatus': hdlstatus,
      'ldlstatus': ldlstatus,
      'triglystatus': triglystatus,
      'drname': drname,
    };
  }
}
