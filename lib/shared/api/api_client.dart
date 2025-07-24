// ignore_for_file: avoid_positional_boolean_parameters

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../entities/folder/model/create_folder_body.dart';
import '../../entities/folder/model/folder_dto.dart';
import '../../entities/folder/model/move_folder_body.dart';
import '../../entities/folder/model/update_folder_body.dart';
import '../../entities/translate/model/detect_language_request_body.dart';
import '../../entities/translate/model/detect_language_response_dto.dart';
import '../../entities/translate/model/supported_languages_response_dto.dart';
import '../../entities/translate/model/translate_request_body.dart';
import '../../entities/translate/model/translate_response_dto.dart';
import '../../entities/user/model/update_user_body.dart';
import '../../entities/user/model/user_dto.dart';
import '../../entities/word/model/create_word_body.dart';
import '../../entities/word/model/update_word_body.dart';
import '../../entities/word/model/word_dto.dart';
import '../../entities/word/model/word_duplicate_check_dto.dart';
import '../../entities/word/model/word_with_folder_dto.dart';
import '../../features/authentication/model/email_sign_in_body.dart';
import '../../features/authentication/model/email_sign_up_body.dart';
import '../../features/authentication/model/token_payload_dto.dart';
import '../dto/ok_dto.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // Authentication
  @GET('/api/v1/auth/status')
  Future<OkDto> getAuthStatus();

  @POST('/api/v1/auth/signin')
  Future<TokenPayloadDto> emailSignIn(@Body() EmailSignInBody body);

  @POST('/api/v1/auth/signup')
  Future<TokenPayloadDto> emailSignUp(@Body() EmailSignUpBody body);

  // User Management
  @GET('/api/v1/user/auth')
  Future<UserDto> getAuthUser();

  @PUT('/api/v1/user/auth')
  Future<UserDto> updateAuthUser(@Body() UpdateUserBody body);

  // Folder Management
  @GET('/api/v1/folders')
  Future<List<FolderDto>> getUserFolders();

  @GET('/api/v1/folders/root')
  Future<List<FolderDto>> getRootFolders();

  @GET('/api/v1/folders/{folderId}')
  Future<FolderDto> getFolderById(@Path('folderId') String folderId);

  @GET('/api/v1/folders/{folderId}/subfolders')
  Future<List<FolderDto>> getSubfoldersByFolderId(@Path('folderId') String folderId);

  @POST('/api/v1/folders')
  Future<FolderDto> createFolder(@Body() CreateFolderBody body);

  @PUT('/api/v1/folders/{folderId}')
  Future<FolderDto> updateFolderById(@Path('folderId') String folderId, @Body() UpdateFolderBody body);

  @PUT('/api/v1/folders/{folderId}/move')
  Future<FolderDto> moveFolderById(@Path('folderId') String folderId, @Body() MoveFolderBody body);

  @DELETE('/api/v1/folders/{folderId}')
  Future<void> deleteFolderById(@Path('folderId') String folderId);

  // Word Management
  @POST('/api/v1/words')
  Future<WordWithFolderDto> createWord(@Body() CreateWordBody body);

  @GET('/api/v1/words/{wordId}')
  Future<WordWithFolderDto> getWordById(@Path('wordId') String wordId);

  @PUT('/api/v1/words/{wordId}')
  Future<WordWithFolderDto> updateWordById(@Path('wordId') String wordId, @Body() UpdateWordBody body);

  @DELETE('/api/v1/words/{wordId}')
  Future<void> deleteWordById(@Path('wordId') String wordId);

  @GET('/api/v1/folders/{folderId}/words')
  Future<List<WordDto>> getWordsByFolderId(@Path('folderId') String folderId);

  @GET('/api/v1/words/check-duplicate')
  Future<WordDuplicateCheckDto> checkWordDuplicate(@Query('text') String text);

  // Translation
  @POST('/api/v1/translate')
  Future<TranslateResponseDto> translateText(@Body() TranslateRequestBody body);

  @POST('/api/v1/translate/detect')
  Future<DetectLanguageResponseDto> detectLanguage(@Body() DetectLanguageRequestBody body);

  @GET('/api/v1/translate/languages')
  Future<SupportedLanguagesResponseDto> getSupportedLanguages();
}
