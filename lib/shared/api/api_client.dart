// ignore_for_file: avoid_positional_boolean_parameters

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../entities/folder/model/create_folder_body.dart';
import '../../entities/folder/model/folder_dto.dart';
import '../../entities/folder/model/move_folder_body.dart';
import '../../entities/folder/model/update_folder_body.dart';
import '../../entities/user/model/update_user_body.dart';
import '../../entities/user/model/user_dto.dart';
import '../../entities/word/model/create_word_body.dart';
import '../../entities/word/model/update_word_body.dart';
import '../../entities/word/model/word_dto.dart';
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

  @POST('/api/v1/folders')
  Future<FolderDto> createFolder(@Body() CreateFolderBody body);

  @PUT('/api/v1/folders/{folderId}')
  Future<FolderDto> updateFolder(@Path('folderId') String folderId, @Body() UpdateFolderBody body);

  @PUT('/api/v1/folders/{folderId}/move')
  Future<FolderDto> moveFolder(@Path('folderId') String folderId, @Body() MoveFolderBody body);

  @DELETE('/api/v1/folders/{folderId}')
  Future<void> deleteFolder(@Path('folderId') String folderId);

  // Word Management
  @POST('/api/v1/words')
  Future<WordWithFolderDto> createWord(@Body() CreateWordBody body);

  @GET('/api/v1/words/{wordId}')
  Future<WordWithFolderDto> getWordById(@Path('wordId') String wordId);

  @PUT('/api/v1/words/{wordId}')
  Future<WordWithFolderDto> updateWord(@Path('wordId') String wordId, @Body() UpdateWordBody body);

  @DELETE('/api/v1/words/{wordId}')
  Future<void> deleteWord(@Path('wordId') String wordId);

  @GET('/api/v1/folders/{folderId}/words')
  Future<List<WordDto>> getWordsByFolder(@Path('folderId') String folderId);
}
