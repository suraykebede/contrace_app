class ResponseWithMsg {
  final String msg;

  ResponseWithMsg({this.msg});

  factory ResponseWithMsg.fromJson(Map<String, dynamic> json) {
    return ResponseWithMsg(msg: json['msg']);
  }
}
