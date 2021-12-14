import 'package:expense_tracker/models/budget.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/user_data.dart';
import 'package:expense_tracker/services/api_path.dart';
import 'package:expense_tracker/services/firestore_service_class.dart';

abstract class Database {
  // get Collection queries
  Stream<List<Budget>> getBudgets();
  Stream<List<Expense>> getExpenses({required String budgetId});

  // get Document queries
  Stream<UserData> getUserData();
  Stream<Budget> getBudget({required String budgetId});
  Stream<Expense> getExpense({required String budgetId, required String expenseId});

  // set(create/update) queries
  Future<void> setUserData({required UserData userData});
  Future<void> setBudget({required Budget budget});
  Future<void> setExpense({required Expense expense});

  // delete queries
  Future<void> deleteBudget({required String budgetId});
  Future<void> deleteExpense({required String budgetId, required String expenseId});
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;
  final _service = FirestoreService.instance;

  // get Collection queries
  Stream<List<Budget>> getBudgets() => _service.collectionStream(
        path: APIPath.budgets(uid: uid),
        builder: (data, documentId) => Budget.fromMap(data, documentId),
      );
  Stream<List<Expense>> getExpenses({required String budgetId}) => _service.collectionStream(
        path: APIPath.expenses(uid: uid, budgetId: budgetId),
        builder: (data, documentId) => Expense.fromMap(data, documentId),
      );

  // get Document queries
  Stream<UserData> getUserData() => _service.documentStream(
        path: APIPath.user(uid: uid),
        builder: (data, documentID) => UserData.fromMap(data, documentID),
      );
  Stream<Budget> getBudget({required String budgetId}) => _service.documentStream(
        path: APIPath.budget(uid: uid, budgetId: budgetId),
        builder: (data, documentID) => Budget.fromMap(data, documentID),
      );
  Stream<Expense> getExpense({required String budgetId, required String expenseId}) => _service.documentStream(
        path: APIPath.expense(uid: uid, budgetId: budgetId, expenseId: expenseId),
        builder: (data, documentID) => Expense.fromMap(data, documentID),
      );

  // set(create/update) queries
  Future<void> setUserData({required UserData userData}) => _service.setData(
        path: APIPath.user(uid: uid),
        data: userData.toMap(),
      );
  Future<void> setBudget({required Budget budget}) => _service.setData(
        path: APIPath.user(uid: uid),
        data: budget.toMap(),
      );
  Future<void> setExpense({required Expense expense}) => _service.setData(
        path: APIPath.user(uid: uid),
        data: expense.toMap(),
      );

  // delete queries
  Future<void> deleteBudget({required String budgetId}) => _service.deleteData(
        path: APIPath.budget(uid: uid, budgetId: budgetId),
      );
  Future<void> deleteExpense({required String budgetId, required String expenseId}) => _service.deleteData(
        path: APIPath.expense(uid: uid, budgetId: budgetId, expenseId: expenseId),
      );
}
