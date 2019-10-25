abstract class Validators {
  static String validatePhoneNo(String phoneNo) {
    if (phoneNo.isEmpty || phoneNo.length != 10) {
      return 'Please enter a valid mobile no.';
    } else
      return null;
  }
}
