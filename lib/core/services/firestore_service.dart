import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
@LazySingleton()
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Sets data on a document at the specified [path].
  /// If [merge] is true, fields are merged with existing data.
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    try {
      final reference = _firestore.doc(path);
      await reference.set(data, SetOptions(merge: merge));
    } catch (e) {
      rethrow;
    }
  }

  /// Adds a document to a collection at the specified [path] with an auto-generated ID.
  Future<DocumentReference<Map<String, dynamic>>> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      final reference = _firestore.collection(path);
      return await reference.add(data);
    } catch (e) {
      rethrow;
    }
  }

  /// Gets a single document from the specified [path].
  Future<DocumentSnapshot<Map<String, dynamic>>> getData({
    required String path,
  }) async {
    try {
      final reference = _firestore.doc(path);
      return await reference.get();
    } catch (e) {
      rethrow;
    }
  }

  /// Updates fields in a document at the specified [path].
  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      final reference = _firestore.doc(path);
      await reference.update(data);
    } catch (e) {
      rethrow;
    }
  }

  /// Deletes a document from the specified [path].
  Future<void> deleteData({
    required String path,
  }) async {
    try {
      final reference = _firestore.doc(path);
      await reference.delete();
    } catch (e) {
      rethrow;
    }
  }

  /// Streams updates for a single document at the specified [path].
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamData({
    required String path,
  }) {
    final reference = _firestore.doc(path);
    return reference.snapshots();
  }

  /// Gets a collection of documents at the specified [path], with an optional [queryBuilder] to filter/sort.
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection({
    required String path,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)? queryBuilder,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection(path);
      if (queryBuilder != null) {
        query = queryBuilder(query);
      }
      return await query.get();
    } catch (e) {
      rethrow;
    }
  }

  /// Streams updates for a collection at the specified [path], with an optional [queryBuilder] to filter/sort.
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCollection({
    required String path,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)? queryBuilder,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query.snapshots();
  }
}
