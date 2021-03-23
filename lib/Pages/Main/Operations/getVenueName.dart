String getVenueName({String scanned_string}) {
  String to_return = "";
  for (int i = 18; i < scanned_string.length - 3; i++) {
    to_return = to_return + scanned_string[i];
  }
  return to_return;
}
