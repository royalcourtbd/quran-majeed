import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quran_majeed/core/utility/color_utility.dart';
import 'package:quran_majeed/core/utility/exceptions.dart';
import 'package:quran_majeed/core/utility/logger_utility.dart';
import 'package:quran_majeed/core/utility/trial_utility.dart';
import 'package:quran_majeed/core/utility/utility.dart';
import 'package:quran_majeed/presentation/notification/services/static_virtual_machine_entry_points.dart';
import 'package:synchronized/synchronized.dart';

/// By separating the Firebase code into its own class, we can make it easier to
/// replace Firebase with another backend-as-a-service provider in the future.
///
/// This is because the rest of the app only depends on the public interface of
/// the `BackendAsAService` class, and not on the specific implementation details
/// of Firebase.
/// Therefore, if we decide to switch to a different backend-as-a-service
/// provider, we can simply create a new class that implements the same public
/// interface and use that instead.
///
/// This can help improve the flexibility of the app and make it easier to adapt
/// to changing business requirements or market conditions.
/// It also reduces the risk of vendor lock-in, since we are not tightly
/// coupling our app to a specific backend-as-a-service provider.
///
/// Overall, separating Firebase code into its own class can help make our app
/// more future-proof and adaptable to changing needs.
class BackendAsAService {
  BackendAsAService() {
    _initAnalytics();
  }

  void _initAnalytics() {
    _analytics
        .setAnalyticsCollectionEnabled(true)
        .then((_) => _analytics.logAppOpen());
  }

  Future<String> signIn() async => _signIn();

  Future<void> signOut() async => _signOut();

  Future<bool> get isAuthenticated async => _checkAuthentication();

  Future<void> listenToDeviceToken({
    required void Function(String) onTokenFound,
  }) async =>
      _listenToDeviceToken(onTokenFound: onTokenFound);

  Future<void> listenToFirebaseNotification() async {
    FirebaseMessaging.onMessage.listen(onBackgroundPushNotificationReceived);
    FirebaseMessaging.onBackgroundMessage(onBackgroundPushNotificationReceived);
  }

  Future<void> logPromotionMessageSeen({required int messageId}) async {
    await _analytics.logEvent(
      name: "home_notification_seen",
      parameters: {
        "time": DateTime.now().toIso8601String(),
        "user_id": _auth.currentUser?.uid ?? "",
        "user_email": _auth.currentUser?.email ?? "",
        "device_info": await getDeviceInfo(),
        "message_id": messageId,
      },
    );
  }

  Future<void> addBookmark({required Map<String, Object?> bookmark}) async =>
      _addItem(item: bookmark, folderName: _bookmarkFolderName);

  Future<void> addPin({required Map<String, Object?> pin}) async =>
      _addItem(item: pin, folderName: _pinFolderName);

  Future<void> deleteAyahFromBookmarks(
          {required int surahID, required int ayahID}) async =>
      _deleteAyahFromCollection(
        surahID: surahID,
        ayahID: ayahID,
        folderName: _bookmarkFolderName,
      );

  Future<void> deleteBookmarkFolder({required String folderName}) async =>
      _deleteItemsByName(
        name: folderName,
        nameKey: "folder_name",
        folderName: _bookmarkFolderName,
      );

  Future<void> deletePinByName({required String pinName}) async =>
      _deleteItemsByName(
        name: pinName,
        nameKey: "name",
        folderName: _pinFolderName,
      );

  Future<void> saveBookmarks({
    required List<Map<String, Object?>> bookmarks,
  }) async =>
      _saveItems(
        items: bookmarks,
        folderName: _bookmarkFolderName,
        nameKey: "folder_name",
      );

  Future<void> savePins({required List<Map<String, Object?>> pins}) async =>
      _saveItems(
        items: pins,
        folderName: _pinFolderName,
        nameKey: "name",
      );

  Future<List<Map<String, Object?>>> getSavedBookmarks() async =>
      _getSavedItems(folderName: _bookmarkFolderName);

  Future<List<Map<String, Object?>>> getSavedPins() async =>
      _getSavedItems(folderName: _pinFolderName);

  Future<void> updateBookmarkFolderName({
    required String folderName,
    required String newFolderName,
    required Color color,
  }) async =>
      _updateCollection(
        collectionFolderName: _bookmarkFolderName,
        itemName: folderName,
        newItemName: newFolderName,
        nameField: "folder_name",
        itemColor: color,
      );

  Future<void> updatePin({
    required String pinName,
    required String newPinName,
    required Color color,
  }) async =>
      _updateCollection(
        collectionFolderName: _pinFolderName,
        itemName: pinName,
        newItemName: newPinName,
        nameField: "name",
        itemColor: color,
      );

  late final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  late final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  late final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> getRemoteNotice({
    required void Function(Map<String, Object?>) onNotification,
  }) async {
    _fireStore
        .collection('remote-notice')
        .doc('notice-bn')
        .snapshots()
        .listen((docSnapshot) {
      onNotification(docSnapshot.data() ?? {});
    });
  }

  Future<Map<String, dynamic>> getAppUpdateInfo() async {
    Map<String, dynamic>? appUpdateInfo = {};
    appUpdateInfo = await catchAndReturnFuture(() async {
      final DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await _fireStore.collection("remote_notice").doc("app_update").get();
      return docSnapshot.data();
    });
    return appUpdateInfo ?? {};
  }

  Future<void> _deleteItemsByName({
    required String name,
    required String nameKey,
    required String folderName,
  }) async {
    await _onAuthenticationValidated(() async {
      final String email = await _currentUserEmail;

      final CollectionReference<Map<String, Object?>> collection =
          _getFirestoreCollection(email: email, folderName: folderName);
      final QuerySnapshot<Map<String, Object?>> querySnapshot =
          await collection.where(nameKey, isEqualTo: name).get();
      final List<QueryDocumentSnapshot<Map<String, Object?>>> documents =
          querySnapshot.docs;
      if (documents.isEmpty) return;

      final WriteBatch batch = _fireStore.batch();
      for (final QueryDocumentSnapshot<Map<String, Object?>> document
          in documents) {
        batch.delete(document.reference);
      }
      await batch.commit();
    });
  }

  Future<List<Map<String, Object?>>> _getSavedItems({
    required String folderName,
  }) async {
    List<Map<String, Object?>> items = [];

    await _onAuthenticationValidated(() async {
      final String email = await _currentUserEmail;

      final CollectionReference<Map<String, Object?>> collection =
          _getFirestoreCollection(email: email, folderName: folderName);
      final QuerySnapshot<Map<String, Object?>> snapshot =
          await collection.get();

      items = snapshot.docs.map((doc) => doc.data()).toList();
    });

    return items;
  }

  Future<void> _updateCollection({
    required String collectionFolderName,
    required String itemName,
    required String newItemName,
    required String nameField,
    required Color itemColor,
  }) async {
    await _onAuthenticationValidated(() async {
      final String email = await _currentUserEmail;
      final CollectionReference<Map<String, Object?>> collection =
          _getFirestoreCollection(
        folderName: collectionFolderName,
        email: email,
      );

      final QuerySnapshot<Map<String, Object?>> querySnapshot =
          await collection.where(nameField, isEqualTo: itemName).get();

      final List<QueryDocumentSnapshot<Map<String, Object?>>> documents =
          querySnapshot.docs;

      if (documents.isEmpty) return;

      final WriteBatch batch = _fireStore.batch();
      for (final QueryDocumentSnapshot<Map<String, Object?>> document
          in documents) {
        final String hexColor = getHexFromColor(itemColor);
        final Map<String, Object> data = {
          nameField: newItemName,
          'color': hexColor,
          'updated_at': DateTime.now().millisecondsSinceEpoch,
        };
        batch.update(document.reference, data);
      }
      await batch.commit();
    });
  }

  CollectionReference<Map<String, Object?>> _getFirestoreCollection({
    required String email,
    required String folderName,
  }) =>
      _fireStore
          .collection(_collectionRootFolderName)
          .doc(email)
          .collection(folderName);

  Future<void> _saveItems({
    required List<Map<String, Object?>> items,
    required String folderName,
    required String nameKey,
  }) async {
    await _onAuthenticationValidated(() async {
      if (items.isEmpty) return;

      const String idKey = "id";
      const String surahIdKey = "surah_id";
      const String ayahIdKey = "ayah_id";

      final String email = await _currentUserEmail;

      final CollectionReference<Map<String, Object?>> collection =
          _getFirestoreCollection(email: email, folderName: folderName);

      final QuerySnapshot<Map<String, Object?>> snapshot =
          await collection.get();

      // Extract existing item IDs from the snapshot
      final Set<int> existingIds =
          snapshot.docs.map((doc) => doc.data()[idKey] as int? ?? 0).toSet();

      // Extract existing items with the same content from the snapshot
      final Set<String> existingItemsWithSameContent = snapshot.docs.map((doc) {
        final int surahId = doc.data()[surahIdKey] as int? ?? -1;
        final int ayahId = doc.data()[ayahIdKey] as int? ?? -1;
        final String folderName = doc.data()[nameKey] as String? ?? "";
        return "$surahId-$ayahId-$folderName";
      }).toSet();

      final WriteBatch batch = _fireStore.batch();
      for (final Map<String, Object?> item in items) {
        final bool itemExists = existingIds.contains(item['id'] as int? ?? 0);
        // Prevent saving the same bookmark item twice in the same folder
        final bool itemWithSameContentExists =
            existingItemsWithSameContent.contains(
                "${item[surahIdKey]}-${item[ayahIdKey]}-${item[nameKey]}");
        if (itemExists && itemWithSameContentExists) return;
        batch.set(collection.doc(), item);
      }

      await batch.commit();
    });
  }

  Future<void> _addItem({
    required Map<String, Object?> item,
    required String folderName,
  }) async {
    await _onAuthenticationValidated(() async {
      // Retrieve current user's email
      final String email = await _currentUserEmail;

      // Get the Firestore collection for the specified folder and user email
      final CollectionReference<Map<String, Object?>> collection =
          _getFirestoreCollection(email: email, folderName: folderName);

      // Add the item to the collection
      await collection.add(item);
    });
  }

  Future<AuthCredential?> _signInWithGoogle() async {
    return catchAndReturnFuture(() async {
      // Sign in with Google
      final GoogleSignInAccount? currentUser = await _googleSignIn.signIn();
      if (currentUser == null) throw SignInException();

      // Retrieve Google authentication data
      final GoogleSignInAuthentication googleSignInAuthentication =
          await currentUser.authentication;
      final String? accessToken = googleSignInAuthentication.accessToken;
      final String? idToken = googleSignInAuthentication.idToken;

      // Create Google AuthCredential using the retrieved data
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      return credential;
    });
  }

  Future<void> _purgeCredentialCache() async {
    _currentUserIdCache = null;
    _currentUserEmailCache = null;
  }

  String? _currentUserIdCache;

  Future<String> get _currentUserId async {
    _currentUserIdCache ??= _auth.currentUser?.uid ?? "";
    return _currentUserIdCache!;
  }

  String? _currentUserEmailCache;

  Future<String> get _currentUserEmail async {
    _currentUserEmailCache ??= _auth.currentUser?.email ?? "";
    return _currentUserEmailCache!;
  }

  static const String _collectionRootFolderName = 'collections';
  static const String _bookmarkFolderName = 'bookmarks';
  static const String _pinFolderName = 'pins';

  Future<String> _signIn() async {
    // Check if the user is already signed in
    if (_auth.currentUser != null) return _auth.currentUser!.uid;

    // Sign in with Google and retrieve the authentication credential
    final AuthCredential? credential = await _signInWithGoogle();

    // If the credential is null, throw a SignInException
    if (credential == null) throw SignInException();

    // Use the credential to sign in the user
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    // Retrieve the signed-in user from the UserCredential
    final User? user = userCredential.user;

    // If the user is null, throw a SignInException
    if (user == null) throw SignInException();
    // Retrieve the user ID
    final String userId = user.uid;

    // Cache the current user ID and email
    _currentUserIdCache = userId;
    _currentUserEmailCache = user.email;

    // Log the login event to analytics
    await _analytics.logLogin(loginMethod: "Google Sign In");

    return userId;
  }

  Future<void> _signOut() async {
    await _onAuthenticationValidated(() async {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await _purgeCredentialCache();
    });
  }

  Future<bool> _checkAuthentication() async {
    final bool? isAuthenticated = await catchAndReturnFuture(
      () async =>
          (await _currentUserId).isNotEmpty &&
          (await _currentUserEmail).isNotEmpty,
    );
    return isAuthenticated ?? false;
  }

  Future<void> _onAuthenticationValidated(
    FutureOr<void> Function() onValidated,
  ) async {
    final bool isAuthenticated = await _checkAuthentication();
    isAuthenticated
        ? await onValidated()
        : logDebug("User is not authenticated");
  }

  final Lock _listenToDeviceTokenLock = Lock();
  String? _inMemoryDeviceToken;

  Future<void> _listenToDeviceToken({
    required void Function(String) onTokenFound,
  }) async {
    // prevents this function to be called multiple times in short period
    await _listenToDeviceTokenLock.synchronized(() async {
      _inMemoryDeviceToken ??= await _firebaseMessaging.getToken();
      logDebug("Device token refreshed -> $_inMemoryDeviceToken");
      if (_inMemoryDeviceToken != null) onTokenFound(_inMemoryDeviceToken!);
      _firebaseMessaging.onTokenRefresh.listen((String? token) {
        logDebug("Device token refreshed -> $token");
        if (token != null) onTokenFound(token);
      });
    });
  }

  Future<void> _deleteAyahFromCollection({
    required int surahID,
    required int ayahID,
    required String folderName,
  }) async {
    // Validate authentication before proceeding
    await _onAuthenticationValidated(() async {
      // Define the key for the surah ID field
      const String surahIdKey = "surah_id";
      const String ayahIdKey = "ayah_id";

      // Retrieve the current user's email
      final String email = await _currentUserEmail;

      // Get the Firestore collection for the specified folder and user
      final CollectionReference<Map<String, Object?>> collection =
          _getFirestoreCollection(email: email, folderName: folderName);

      // Query the collection for documents with matching surah and ayah IDs
      final QuerySnapshot<Map<String, Object?>> querySnapshot = await collection
          .where(surahIdKey, isEqualTo: surahID)
          .where(ayahIdKey, isEqualTo: ayahID)
          .get();

      // Retrieve the list of documents
      final List<QueryDocumentSnapshot<Map<String, Object?>>> documents =
          querySnapshot.docs;

      // If no documents match the query, return
      if (documents.isEmpty) return;

      // Create a WriteBatch to perform the delete operation
      final WriteBatch batch = _fireStore.batch();

      // Add the delete operation for each document to the batch
      for (final QueryDocumentSnapshot<Map<String, Object?>> document
          in documents) {
        batch.delete(document.reference);
      }

      // Commit the batch operation to delete the documents
      await batch.commit();
    });
  }

  Future<void> deleteAyahFromBookmarkFolder({
    required int surahID,
    required int ayahID,
    required String folderName,
  }) async {
    await _onAuthenticationValidated(() async {
      // Retrieve the current user's email
      final String email = await _currentUserEmail;

      // Key for the "surah_id" field in Firestore
      const String surahIdKey = "surah_id";
      const String ayahIdKey = "ayah_id";

      // Get the Firestore collection for bookmarks
      final CollectionReference<Map<String, Object?>> collection =
          _getFirestoreCollection(
        email: email,
        folderName: _bookmarkFolderName,
      );

      // Query Firestore for documents with matching folder name and surah ID
      final QuerySnapshot<Map<String, Object?>> querySnapshot = await collection
          .where("folder_name", isEqualTo: folderName)
          .where(surahIdKey, isEqualTo: surahID)
          .where(ayahIdKey, isEqualTo: ayahID)
          .get();
      final List<QueryDocumentSnapshot<Map<String, Object?>>> documents =
          querySnapshot.docs;

      // If no matching documents found, return
      if (documents.isEmpty) return;

      // Create a batch operation for efficient deletion
      final WriteBatch batch = _fireStore.batch();

      // Delete each matching document in the batch
      for (final QueryDocumentSnapshot<Map<String, Object?>> document
          in documents) {
        batch.delete(document.reference);
      }

      // Commit the batch operation to delete the documents
      await batch.commit();
    });
  }
}
