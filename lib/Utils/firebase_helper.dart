
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/Dash%20Screen/Model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper
{
  static FirebaseHelper helper = FirebaseHelper();
  String? uid;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> SignInGuest() async {
    try {
      await auth.signInAnonymously();
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

  bool checkuser() {
    User? user = auth.currentUser;
    return user != null;
  }

  Map<String, String?> userDetaile()
  {
    User? user = auth.currentUser;
    return {
      'photo':user!.photoURL,
      'name':user.displayName,
      'email':user.email,
      'phone':user.phoneNumber,
       'uid' : user.uid,
    };
  }

  Future<String> logOut() async {
    try {
      await auth.signOut();
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

  Future<String> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await auth.signInWithCredential(credential);
      return "Success";
    } catch (e) {
      return "Failed";
    }
  }

  //=================== Fire store================

  FirebaseFirestore firestore =FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> readProductData()
  {
    return firestore.collection("Product").snapshots();
  }

  void updateData(ProductModel model)
  {
    firestore.collection('Product').doc(model.id).set(
        {
          "name":model.name,
          "price":model.price,
          "category":model.cate,
          "image":model.img,
          "desc":model.desc,
          "like":model.like
        }
    );
  }

  void add_cart_Data(ProductModel model) {
    firestore.collection("Cart").doc('$uid').collection('product').add({
      "name":model.name,
      "price":model.price,
      "category":model.cate,
      "image":model.img,
      "desc":model.desc,
      "like":model.like,
      'item_count':model.item_count

    });
  }



  Stream<QuerySnapshot<Map<String, dynamic>>> readCartData()
  {
   return firestore.collection('Cart').doc('$uid').collection('product').snapshots();
  }

  void add_address_Data(AddressModel model)
  {
    firestore.collection("Cart").doc('$uid').collection('Address').add({
      "street":model.street,
      "city":model.city,
      "state":model.state,
      "zipcode":model.zipcod,
      "cno":model.cno,
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> readAddressData()
  {
    return firestore.collection('Cart').doc('$uid').collection('Address').get();
  }

  void updateCartData(ProductModel model)
  {
    firestore.collection('Cart').doc('$uid').collection('product').doc(model.id).set(
        {
          "name":model.name,
          "price":model.price,
          "category":model.cate,
          "image":model.img,
          "desc":model.desc,
          "like":model.like,
          'item_count':model.item_count
        }
    );
  }

  void deleteCartData(id)
  {
    firestore.collection('Cart').doc('$uid').collection('product').doc('$id').delete();
  }

  void deleteallCartData()
  {
    firestore.collection('Cart').doc('$uid').delete();
  }

  void add_history(ProductModel model)
  {
    firestore.collection("Cart").doc('$uid').collection('history').add({
      "name":model.name,
      "price":model.price,
      "category":model.cate,
      "image":model.img,
      "desc":model.desc,
      "like":model.like,
      'item_count':model.item_count
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readHistoryData()
  {
    return firestore.collection('Cart').doc('$uid').collection('history').snapshots();
  }



}