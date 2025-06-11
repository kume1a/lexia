import 'package:collection/collection.dart';
import 'package:common_models/common_models.dart';
import 'package:injectable/injectable.dart';

import '../model/word.dart';
import 'word_remote_repository.dart';

final fakeWords = [
  Word(
    id: '1',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    text: 'Hello',
    definition: 'A greeting or expression of goodwill.',
    folderId: '1',
  ),
  Word(
    id: '2',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    text: 'World',
    definition: 'The earth, together with all of its countries and peoples.',
    folderId: '1',
  ),
  Word(
    id: '3',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    text: 'Flutter',
    definition: 'An open-source UI software development toolkit created by Google.',
    folderId: '1',
  ),
  Word(
    id: '4',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    text: 'Dart',
    definition:
        'A programming language optimized for building mobile, desktop, server, and web applications.',
    folderId: '1',
  ),
  Word(
    id: '5',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    text: 'Dependency Injection',
    definition:
        'A design pattern used to implement IoC (Inversion of Control), allowing for better modularity and testing.',
    folderId: '1',
  ),
];

@LazySingleton(as: WordRemoteRepository)
class WordRemoteRepositoryImpl implements WordRemoteRepository {
  @override
  Future<Either<NetworkCallError, Word>> create({
    required String folderId,
    required String text,
    required String definition,
  }) {
    return Future.delayed(const Duration(seconds: 2), () {
      final newWord = Word(
        id: DateTime.now().toIso8601String(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        text: text,
        definition: definition,
        folderId: folderId,
      );
      fakeWords.insert(0, newWord);
      return right(newWord);
    });
  }

  @override
  Future<Either<MutateEntityError, Word>> updateById(
    String id, {
    required String folderId,
    required String text,
    required String definition,
  }) {
    return Future.delayed(const Duration(seconds: 2), () {
      final wordIndex = fakeWords.indexWhere((word) => word.id == id);
      if (wordIndex == -1) {
        return left(MutateEntityError.notFound);
      }

      final updatedWord = fakeWords[wordIndex].copyWith(
        folderId: folderId,
        text: text,
        definition: definition,
        updatedAt: DateTime.now(),
      );
      fakeWords[wordIndex] = updatedWord;
      return right(updatedWord);
    });
  }

  @override
  Future<Either<MutateEntityError, Word>> deleteById(String id) {
    final wordIndex = fakeWords.indexWhere((word) => word.id == id);
    if (wordIndex == -1) {
      return Future.error('Word not found');
    }

    final removedOne = fakeWords.removeAt(wordIndex);
    return Future.delayed(const Duration(seconds: 2), () => right(removedOne));
  }

  @override
  Future<Either<NetworkCallError, List<Word>>> getAllByFolderId(String folderId) {
    return Future.delayed(const Duration(seconds: 2), () {
      return right(fakeWords.where((word) => word.folderId == folderId).toList());
    });
  }

  @override
  Future<Either<GetEntityError, Word>> getById(String id) {
    return Future.delayed(const Duration(seconds: 2), () {
      final word = fakeWords.firstWhereOrNull((word) => word.id == id);
      if (word == null) {
        return left(GetEntityError.notFound);
      }

      return right(word);
    });
  }
}
