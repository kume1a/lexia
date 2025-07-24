import '../../../shared/model/sort_order.dart';

abstract interface class UserPreferenceStore {
  Future<void> setFolderSortOrder(SortOrder sortOrder);

  Future<SortOrder> getFolderSortOrder();

  Future<void> setWordSortOrder(SortOrder sortOrder);

  Future<SortOrder> getWordSortOrder();

  Future<void> clear();
}
