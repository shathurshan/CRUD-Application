class Validator {
  static String? validateFiels({required String value}) {
    if (value.isEmpty) {
      return "Textfield can not be empty";
    }
    return null;
  }

  static String? validateUserId({required String uid}) {
    if (uid.isEmpty) {
      return "User ID can not be empty";
    } else if (uid.length <= 5) {
      return "User Id should be grater than 5 characters";
    }
    return null;
  }
}
