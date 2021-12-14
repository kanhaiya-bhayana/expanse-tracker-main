class Budget {
  Budget({required this.name, required this.amount, required this.startDate, required this.endDate, this.documentId});

  final String name;
  final String? documentId;
  final double amount;
  final DateTime startDate, endDate;

  factory Budget.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for $documentId');
    }
    final String name = data['name'];
    final double amount = data['amount'];
    final DateTime startDate = data['imgUrl'];
    final DateTime endDate = data['imgUrl'];

    return Budget(
      name: name,
      amount: amount,
      startDate: startDate,
      endDate: endDate,
      documentId: documentId,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  @override
  String toString() => '<Budget> name: $name, amount: $amount, startDate: $startDate, endDate: $endDate, documentId: $documentId';
}
