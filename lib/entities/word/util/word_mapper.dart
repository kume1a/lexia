import 'package:injectable/injectable.dart';

import '../model/word.dart';
import '../model/word_dto.dart';
import '../model/word_with_folder_dto.dart';

@injectable
class WordMapper {
  Word dtoToDomain(WordDto dto) {
    return Word(
      id: dto.id,
      folderId: dto.folderId,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      text: dto.text,
      definition: dto.definition,
    );
  }

  Word wordWithFolderDtoToDomain(WordWithFolderDto dto) {
    return Word(
      id: dto.id,
      folderId: dto.folder.id,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      text: dto.text,
      definition: dto.definition,
    );
  }

  WordDto domainToDto(Word domain) {
    return WordDto(
      id: domain.id,
      folderId: domain.folderId,
      createdAt: domain.createdAt,
      updatedAt: domain.updatedAt,
      text: domain.text,
      definition: domain.definition,
    );
  }
}
