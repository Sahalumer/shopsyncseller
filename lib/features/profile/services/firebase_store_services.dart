import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopsyncseller/features/profile/models/store_details_model.dart';

class FirebaseStoreDetailsServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<StoreDetailsModel?> fetchDetails(String uid) async {
    try {
      DocumentSnapshot detailsDoc = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('store_details')
          .doc(uid)
          .get();

      if (detailsDoc.exists && detailsDoc.data() != null) {
        return StoreDetailsModel.fromMap(
            detailsDoc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw 'Fetch details failed: $e';
    }
  }

  Future<void> addorEditDetails(StoreDetailsModel details, String uid) async {
    try {
      print(uid);
      await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('store_details')
          .doc(uid)
          .set(details.toMap());
    } catch (e) {
      throw 'Update failed: $e';
    }
  }
}
