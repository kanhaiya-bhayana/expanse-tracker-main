class Expense {
  Expense({required this.name, required this.amount, required this.date, required this.category, this.documentId});
  final String name, category;
  final String? documentId;
  final double amount;
  final DateTime date;

  factory Expense.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for $documentId');
    }
    final String name = data['name'];
    final double amount = data['amount'];
    final String category = data['category'];
    final DateTime date = data['date'];

    return Expense(
      name: name,
      amount: amount,
      category: category,
      date: date,
      documentId: documentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'category': category,
      'date': date,
    };
  }

  @override
  String toString() => '<Expense> name: $name, amount: $amount, category: $category, date: $date, documentId: $documentId';
}
