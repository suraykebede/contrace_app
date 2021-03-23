String extractUserNameFromFakeUrl(String authorization) {
  String extractedUserName = "";
  for (int i = 7; i < 15; i++) {
    extractedUserName = extractedUserName + authorization[i];
  }
  //return extractedUserName;
  if (extractedUserName.contains('@_')) {
    extractedUserName =
        extractedUserName + authorization[15] + authorization[16];
    return extractedUserName;
  } else {
    return extractedUserName;
  }
}
