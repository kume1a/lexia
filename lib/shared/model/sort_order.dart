enum SortOrder { nameAsc, nameDesc, dateAsc, dateDesc }

extension SortOrderX on SortOrder {
  bool get isNameSort => this == SortOrder.nameAsc || this == SortOrder.nameDesc;
  bool get isDateSort => this == SortOrder.dateAsc || this == SortOrder.dateDesc;
  bool get isAscending => this == SortOrder.nameAsc || this == SortOrder.dateAsc;
}
