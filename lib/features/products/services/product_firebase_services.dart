import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopsyncseller/features/products/models/offer_model.dart';
import 'package:shopsyncseller/features/products/models/offer_product_model.dart';
import 'package:shopsyncseller/features/products/models/product_model.dart';
import 'package:shopsyncseller/features/supplier/models/supplier_model.dart';
import 'package:shopsyncseller/utils/constants/store_user.dart';

class ProductFirebaseServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<ProductModel>> fetchProducts(String uid) {
    try {
      return _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('products')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ProductModel.fromMap(doc.data()..['id'] = doc.id))
              .toList());
    } catch (e) {
      return Stream.value([]);
    }
  }

  Future<String?> addProduct(String uid, ProductModel product) async {
    try {
      DocumentReference docRef = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('products')
          .add(product.toMap());
      addedProductId = docRef.id;
      product.id = docRef.id;
      await docRef.set(product.toMap(), SetOptions(merge: true));

      return product.id;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateProduct(String uid, ProductModel product) async {
    try {
      await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('products')
          .doc(product.id)
          .set(product.toMap(), SetOptions(merge: true));
    } catch (e) {}
  }

  Future<void> deleteProduct(String uid, String productId) async {
    try {
      await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('products')
          .doc(productId)
          .delete();
    } catch (e) {}
  }

  Future<void> deleteOfferProduct(String uid, String productId) async {
    try {
      await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('offer_products')
          .doc(productId)
          .delete();
    } catch (e) {}
  }

  Future<ProductModel?> fetchProductById(String uid, String productId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('products')
          .doc(productId)
          .get();

      if (doc.exists) {
        return ProductModel.fromMap(doc.data()!..['id'] = doc.id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<OfferProductModel?> fetchOfferProductById(
      String uid, String productId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('offer_products')
          .doc(productId)
          .get();

      if (doc.exists) {
        return OfferProductModel.fromMap(doc.data()!..['id'] = doc.id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> checkEligible(String uid) async {
    try {
      DocumentSnapshot detailsDoc = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('store_details')
          .doc(uid)
          .get();

      return detailsDoc.exists && detailsDoc.data() != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateOffer(String uid, String productId, Offer offer) async {
    try {
      await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('offer_products')
          .doc(productId)
          .set(
        {"offer": offer.toMap()},
        SetOptions(merge: true),
      );
    } catch (e) {}
  }

  Future<void> updateOfferProduct(String uid, OfferProductModel product) async {
    try {
      await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('offer_products')
          .doc(product.id)
          .set(product.toMap(), SetOptions(merge: true));
    } catch (e) {
      print("Error updating offer product: $e");
    }
  }

  Future<String?> addOffer(
      String uid, ProductModel product, Offer offer) async {
    try {
      OfferProductModel offerProduct = OfferProductModel(
        productName: product.productName,
        price: product.price,
        description: product.description,
        pictures: product.pictures,
        reviews: product.reviews,
        unit: product.unit,
        reviewGraph: product.reviewGraph,
        quantity: product.quantity,
        offer: offer,
      );

      DocumentReference docRef = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('offer_products')
          .add(offerProduct.toMap());

      offerProduct.id = docRef.id;
      await docRef.set({"id": offerProduct.id}, SetOptions(merge: true));
      deleteProduct(uid, product.id!);
      return offerProduct.id;
    } catch (e) {
      print("Error adding offer: $e");
      return null;
    }
  }

  Future<void> removeOffer(String uid, String productId) async {
    try {
      OfferProductModel? product = await fetchOfferProductById(uid, productId);
      if (product != null) {
        await addProduct(
          uid,
          ProductModel(
            productName: product.productName,
            price: product.price,
            description: product.description,
            pictures: product.pictures,
            reviews: product.reviews,
            unit: product.unit,
            reviewGraph: product.reviewGraph,
            quantity: product.quantity,
          ),
        );
        await deleteOfferProduct(uid, productId);
      }
    } catch (e) {
      print("Error removing offer: $e");
    }
  }

  Stream<List<OfferProductModel>> fetchOfferProducts(String uid) {
    try {
      return _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('offer_products')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) =>
                  OfferProductModel.fromMap(doc.data()..['id'] = doc.id))
              .toList());
    } catch (e) {
      print("Error fetching offer products: $e");
      return Stream.value([]);
    }
  }

  Future<SupplierModel?> searchForSupplier(String uid, String productId) async {
    try {
      final querySnapshot = await _firebaseFirestore
          .collection('admin')
          .doc('sellers')
          .collection('users')
          .doc(uid)
          .collection('suppliers')
          .where('products', arrayContains: productId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return SupplierModel.fromMap(querySnapshot.docs.first.data());
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
