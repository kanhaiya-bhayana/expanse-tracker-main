class UserData {
  UserData({required this.name, required this.email, required this.currency, this.documentId}) : symbol = currency[0];
  final String name, email, currency, symbol;
  final String? documentId;

  factory UserData.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for $documentId');
    }
    final String name = data['name'];
    final String email = data['email'];
    final String currency = data['currency'];
    return UserData(
      name: name,
      email: email,
      currency: currency,
      documentId: documentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'currency': currency,
    };
  }

  @override
  String toString() => '<UserData> name: $name, email: $email, currency: $currency, documentId: $documentId';
}
