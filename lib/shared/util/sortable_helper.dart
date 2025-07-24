import '../../app/intl/extension/enum_intl.dart';
import '../../features/user_preferences/api/user_preference_store.dart';
import '../model/sort_order.dart';
import '../typedefs.dart';
import '../ui/bottom_sheet/bottom_sheet_manager.dart';
import '../ui/bottom_sheet/select_option/select_option.dart';
import '../values/assets.dart';

class SortableHelper {
  static Future<SortOrder> loadSortOrder(UserPreferenceStore store, {required bool isFolder}) async {
    return isFolder ? await store.getFolderSortOrder() : await store.getWordSortOrder();
  }

  static Future<void> saveSortOrder(
    UserPreferenceStore store,
    SortOrder sortOrder, {
    required bool isFolder,
  }) async {
    if (isFolder) {
      await store.setFolderSortOrder(sortOrder);
    } else {
      await store.setWordSortOrder(sortOrder);
    }
  }

  static Future<SortOrder?> showSortOptions({
    required BottomSheetManager bottomSheetManager,
    required SortOrder currentSortOrder,
    required LocalizedStringResolver getHeaderText,
  }) async {
    return bottomSheetManager.openOptionSelector<SortOrder>(
      header: getHeaderText,
      options: SortOrder.values
          .map(
            (sortOrder) => SelectOption(
              value: sortOrder,
              label: (l) => sortOrder.translate(l),
              iconAssetName: currentSortOrder == sortOrder ? Assets.svgCheck : null,
            ),
          )
          .toList(),
    );
  }
}
