import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/values/constant.dart';
import '../model/folder_path_item.dart';
import '../model/folder_path_item_dto.dart';
import '../model/word.dart';
import '../model/word_dto.dart';
import '../model/word_duplicate_check.dart';
import '../model/word_duplicate_check_dto.dart';
import '../model/word_with_folder_dto.dart';
import '../model/word_with_folder_path.dart';
import '../model/word_with_folder_path_dto.dart';

@injectable
class WordMapper {
  Word dtoToDomain(WordDto dto) {
    return Word(
      id: dto.id ?? kInvalidId,
      folderId: dto.folderId ?? kInvalidId,
      createdAt: tryMapDate(dto.createdAt),
      updatedAt: tryMapDate(dto.updatedAt),
      text: dto.text ?? '',
      definition: dto.definition ?? '',
    );
  }

  Word wordWithFolderDtoToDomain(WordWithFolderDto dto) {
    return Word(
      id: dto.id ?? kInvalidId,
      folderId: dto.folder?.id ?? kInvalidId,
      createdAt: tryMapDate(dto.createdAt),
      updatedAt: tryMapDate(dto.updatedAt),
      text: dto.text ?? '',
      definition: dto.definition ?? '',
    );
  }

  FolderPathItem folderPathItemDtoToDomain(FolderPathItemDto dto) {
    return FolderPathItem(id: dto.id, name: dto.name);
  }

  WordWithFolderPath wordWithFolderPathDtoToDomain(WordWithFolderPathDto dto) {
    return WordWithFolderPath(
      id: dto.id,
      createdAt: tryMapDate(dto.createdAt),
      updatedAt: tryMapDate(dto.updatedAt),
      text: dto.text,
      definition: dto.definition,
      folderPath: dto.folderPath.map(folderPathItemDtoToDomain).toList(),
    );
  }

  WordDuplicateCheck duplicateCheckDtoToDomain(WordDuplicateCheckDto dto) {
    return WordDuplicateCheck(
      isDuplicate: dto.isDuplicate,
      word: dto.word != null ? wordWithFolderPathDtoToDomain(dto.word!) : null,
    );
  }
}
