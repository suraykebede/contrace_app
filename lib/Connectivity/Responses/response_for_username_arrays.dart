class ResponseForUsernameArrays {
  final List<String> usernames;

  ResponseForUsernameArrays({this.usernames});

  factory ResponseForUsernameArrays.fromJson(Map<String, dynamic> json) {
    List<String> temp_usernames;
    for (String i in json['msg']) {
      temp_usernames.add(i.toString());
    }
    return ResponseForUsernameArrays(usernames: temp_usernames);
  }
}
