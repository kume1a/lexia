import 'package:injectable/injectable.dart';

import '../model/folder.dart';
import '../model/folder_dto.dart';
import '../model/folder_type.dart';
import '../model/language.dart';

@injectable
class FolderMapper {
  Folder dtoToDomain(FolderDto dto) {
    return Folder(
      id: dto.id,
      createdAt: dto.createdAt.isNotEmpty ? DateTime.tryParse(dto.createdAt) : null,
      updatedAt: dto.updatedAt.isNotEmpty ? DateTime.tryParse(dto.updatedAt) : null,
      name: dto.name,
      wordCount: dto.wordCount,
      languageFrom: dto.languageFrom ?? Language.english,
      languageTo: dto.languageTo ?? Language.georgian,
    );
  }

  FolderDto domainToDto(Folder domain) {
    return FolderDto(
      id: domain.id,
      name: domain.name,
      type: FolderType.wordCollection, // Default type - adjust based on business logic
      wordCount: domain.wordCount,
      languageFrom: domain.languageFrom,
      languageTo: domain.languageTo,
      createdAt: domain.createdAt?.toIso8601String() ?? '',
      updatedAt: domain.updatedAt?.toIso8601String() ?? '',
      hasWords: domain.wordCount > 0,
    );
  }
}
