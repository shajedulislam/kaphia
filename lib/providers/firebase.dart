import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kaphia/providers/selected_menu.dart';

final menuStreamProvider = StreamProvider<QuerySnapshot?>(
  (ref) {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseFirestore.instance.collection('menu').snapshots();
    } else {
      return const Stream.empty();
    }
  },
);

final menuItemsStreamProvider = StreamProvider<DocumentSnapshot?>(
  (ref) {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseFirestore.instance
          .collection('menu')
          .doc(ref.watch(selectedMenuProvider))
          .snapshots();
    } else {
      return const Stream.empty();
    }
  },
);