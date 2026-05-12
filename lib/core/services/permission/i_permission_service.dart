abstract class IPermissionService {
  // get permission
  Future<bool> getPushPermission();
  Future<bool> getStorageWritePermission();
  Future<bool> getContactsWritePermission();
}
