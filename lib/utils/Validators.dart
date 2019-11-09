abstract class Validators {
  static String validatePhoneNo(String phoneNo) {
    if (phoneNo == null || phoneNo.isEmpty || phoneNo.length != 10) {
      return 'Please enter a valid mobile no.';
    } else
      return null;
  }

  static String validateForNull(String text) {
    if (text == null || text.isEmpty) {
      return 'Please enter a valid information.';
    } else
      return null;
  }

  static String validatePinCode(String pinCode) {
    if (pinCode == null || pinCode.isEmpty || pinCode.length != 6) {
      return 'Please enter a valid pincode.';
    } else
      return null;
  }
}
