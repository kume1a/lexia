import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/values/constant.dart';
import '../model/folder.dart';
import '../model/folder_dto.dart';

@injectable
class FolderMapper {
  Folder dtoToDomain(FolderDto dto) {
    return Folder(
      id: dto.id ?? kInvalidId,
      createdAt: tryMapDate(dto.createdAt),
      updatedAt: tryMapDate(dto.updatedAt),
      name: dto.name ?? '',
      type: dto.type,
      wordCount: dto.wordCount ?? 0,
      languageFrom: dto.languageFrom,
      languageTo: dto.languageTo,
      subfolders: mapListOrEmpty(dto.subfolders, dtoToDomain),
      parentId: dto.parentId,
    );
  }
}
