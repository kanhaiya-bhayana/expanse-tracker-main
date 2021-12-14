class APIPath {
  static String user({required String uid}) => 'users/$uid';

  static String budgets({required String uid}) => 'users/$uid/budgets';
  static String budget({required String uid, required String budgetId}) => 'users/$uid/budgets/$budgetId';

  static String expenses({required String uid, required String budgetId}) => 'users/$uid/budgets/$budgetId/expenses';
  static String expense({required String uid, required String budgetId, required String expenseId}) =>
      'users/$uid/budgets/$budgetId/expenses/$expenseId';
}
