import 'package:common_utilities/common_utilities.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/values/constant.dart';
import '../model/word.dart';
import '../model/word_dto.dart';
import '../model/word_with_folder_dto.dart';

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
}
