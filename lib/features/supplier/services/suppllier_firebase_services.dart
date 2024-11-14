import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';

class SupplierFirebaseServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<SupplierModel>> fetchSuppliers(String uid) {
    try {
      return _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('suppliers')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => SupplierModel.fromMap(doc.data()..['id'] = doc.id))
              .toList());
    } catch (e) {
      return Stream.value([]);
    }
  }

  Future<String?> addSupplier(String uid, SupplierModel supplier) async {
    try {
      DocumentReference docRef = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('suppliers')
          .add(supplier.toMap());

      supplier.id = docRef.id;

      await docRef.set(supplier.toMap(), SetOptions(merge: true));
      return supplier.id;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateSupplier(String uid, SupplierModel supplier) async {
    try {
      if (supplier.id == null) {
        print("Error: Supplier ID is null");
        return;
      }

      await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('suppliers')
          .doc(supplier.id)
          .set(supplier.toMap(), SetOptions(merge: true));
    } catch (e) {
      print("Error updating supplier: $e");
    }
  }

  Future<SupplierModel?> fetchSingleSupplierById(
      String uid, String supplierId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('suppliers')
          .doc(supplierId)
          .get();

      if (doc.exists) {
        return SupplierModel.fromMap(doc.data()!..['id'] = doc.id);
      }
      return null;
    } catch (e) {
      print("Error Fetch single supplier: $e");
      return null;
    }
  }

  Future<void> deleteSupplier(String uid, String supplierId) async {
    try {
      await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('suppliers')
          .doc(supplierId)
          .delete();
    } catch (e) {
      print("Error deleting supplier: $e");
    }
  }

  Future<List<SupplierModel>> searchSuppliers(String uid, String query) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('suppliers')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      return querySnapshot.docs
          .map((doc) => SupplierModel.fromMap(doc.data()..['id'] = doc.id))
          .toList();
    } catch (e) {
      print("Error searching suppliers: $e");
      return [];
    }
  }
}
