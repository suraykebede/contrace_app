String getUserGivenNameFromQrCode(String authorization) {
  String userGivenName = "";
  int endIndex = authorization.length - 4;
  for (int i = 16; i <= endIndex; i++) {
    if (authorization[i] == "_") {
      userGivenName = userGivenName + " ";
    } else {
      userGivenName = userGivenName + authorization[i];
    }
  }
  return userGivenName;
}
