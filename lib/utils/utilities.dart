class Utils {
  static String getUserName(String email) {
    return "live:${email.split('@')[0]}";
  }

  static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String initials = "${nameSplit[0][0]}" "${nameSplit[1][0]}";
    return initials;
  }
}
