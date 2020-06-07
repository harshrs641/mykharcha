// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mykhacha/trans_list.dart';
// import '../global_var.dart';

// class crudMethods {
//   bool isLogIn() {
//     if (FirebaseAuth.instance.currentUser() != null) {
//       return true;
//     } else
//       return false;
//   }

//   // void addTAData(tai) async {
//   //   if (isLogIn()) {

//   //     Firestore.instance
//   //         .collection(user.uid)
//   //         .document('ta')
//   //         .setData({'tai': tai});
//   //   }
//   // }
//   Future<void> addOneTrans(int i, int j,String txt, int amt,DateTime dt) async {
//     if (isLogIn()) {
//       await snapshot.reference
//           .collection(i.toString())
//           .document(j.toString())
//           .setData({
//         'Title': txt,
//         'Amount': amt,
//         'Date': dt
//       });
//     }
//   }

//   Future<void> addTransData() async {
//     if (isLogIn()) {
//       for (int i = 0; i <31; i++) {
//         for (int j = 0; j < transaction[i].length; j++){
//           await snapshot.reference
//               .collection((i+1).toString())
//               .document((j+1).toString())
//               .setData({
//             'Title': transaction[i][j].txt,
//             'Amount': transaction[i][j].amount,
//             'Date': transaction[i][j].date
//           });}
//       }
//     }
//   }

//   Future<void> delete(int i, int j) async {
//     if (isLogIn())
//       await snapref
//           .collection(i.toString())
//           .document(j.toString())
//           .delete();
//   }

//   Future<void> updateData(tlist,i,j)async {
//     if (isLogIn()) {
//       // for (int i = 0; i <= 31; i++) {
//       //   for (int j = 0; j < tlist[i].length; j++)
//           await snapshot.reference
//               .collection(i.toString())
//               .document(j.toString())
//               .updateData({'Transaction': tlist[i-1][j-1].txt});
//       await  snapshot.reference
//               .collection(i.toString())
//               .document(j.toString())
//               .updateData({'Amount': tlist[i-1][j-1].amount});

//       // Firestore.instance.collection(user.uid).document('ta').updateData(tai);
    
//   }}

//   // get getTAData async {

//   //   return await Firestore.instance.collection(user.uid).document('ta').get();
//   // }

//   getLength(int i) {
//     return snapshot.reference..collection(i.toString());
//   }

//   // present() {

//   //   return  snapshot.data;
//   // }

//   Future<DocumentSnapshot> getTransData(int i, int j) async {
//     return  snapshot.reference
//         .collection(i.toString())
//         .document(j.toString())
//         .get();
//   }
// }
