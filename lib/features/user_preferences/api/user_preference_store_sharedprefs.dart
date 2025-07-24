import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/model/sort_order.dart';
import 'user_preference_store.dart';

@LazySingleton(as: UserPreferenceStore)
class UserPreferenceStoreSharedPrefs implements UserPreferenceStore {
  UserPreferenceStoreSharedPrefs(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static const String _keyFolderSortOrder = 'folder_sort_order';
  static const String _keyWordSortOrder = 'word_sort_order';

  @override
  Future<void> setFolderSortOrder(SortOrder sortOrder) async {
    await _sharedPreferences.setString(_keyFolderSortOrder, sortOrder.name);
  }

  @override
  Future<SortOrder> getFolderSortOrder() async {
    final sortOrderName = _sharedPreferences.getString(_keyFolderSortOrder);

    if (sortOrderName == null) {
      return SortOrder.nameAsc;
    }

    return SortOrder.values.firstWhere((e) => e.name == sortOrderName, orElse: () => SortOrder.nameAsc);
  }

  @override
  Future<void> setWordSortOrder(SortOrder sortOrder) async {
    await _sharedPreferences.setString(_keyWordSortOrder, sortOrder.name);
  }

  @override
  Future<SortOrder> getWordSortOrder() async {
    final sortOrderName = _sharedPreferences.getString(_keyWordSortOrder);

    if (sortOrderName == null) {
      return SortOrder.nameAsc;
    }

    return SortOrder.values.firstWhere((e) => e.name == sortOrderName, orElse: () => SortOrder.nameAsc);
  }

  @override
  Future<void> clear() async {
    await Future.wait([
      _sharedPreferences.remove(_keyFolderSortOrder),
      _sharedPreferences.remove(_keyWordSortOrder),
    ]);
  }
}
