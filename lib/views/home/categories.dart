// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:pro_design/pro_design.dart';
// import 'package:pro_widgets/pro_widgets.dart';

// import '../../controllers/menu_controller.dart';
// import '../../utilities/colors.dart';
// import '../../utilities/constants/strings.dart';
// import '../shared/widgets/loading_indicator.dart';
// import '../shared/widgets/radius_clip.dart';

// class MenuCategories extends StatelessWidget {
//   const MenuCategories({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FoodMenuController().getMenu(),
//       builder: (
//         BuildContext context,
//         AsyncSnapshot<QuerySnapshot> snapshot,
//       ) {
//         if (snapshot.hasError) {
//           return Center(
//             child: ProText(
//               text: ProjectStrings.wentWrong,
//               fontSize: ProDesign.sp(16),
//               color: ProjectColors.secondary500,
//               fontWeight: FontWeight.bold,
//             ),
//           );
//         }

//         if (snapshot.hasData) {
//           if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                     vertical: ProDesign.pt(30),
//                     horizontal: ProDesign.pt(20),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ProText(
//                         text: "Hello!",
//                         fontSize: ProDesign.sp(28),
//                         color: ProjectColors.secondary500,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       ProGap(y: ProDesign.pt(8)),
//                       ProText(
//                         text: "What would you like to order?",
//                         fontSize: ProDesign.sp(18),
//                         color: ProjectColors.secondary500,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: ProDesign.pt(250),
//                   child: ListView(
//                     padding: EdgeInsets.only(
//                       left: ProDesign.pt(20),
//                     ),
//                     scrollDirection: Axis.horizontal,
//                     children:
//                         snapshot.data!.docs.map((DocumentSnapshot document) {
//                       Map<String, dynamic> data =
//                           document.data()! as Map<String, dynamic>;
//                       return Padding(
//                         padding: EdgeInsets.only(right: ProDesign.pt(20)),
//                         child: ProTapper(
//                           padding: const EdgeInsets.all(0),
//                           onTap: () {},
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                   bottom: ProDesign.pt(16),
//                                 ),
//                                 child: ProRadiusClip(
//                                   borderRadius: ProDesign.pt(8),
//                                   child: ProShape(
//                                     color: ProjectColors.grey300,
//                                     width: ProDesign.pt(150),
//                                     height: ProDesign.pt(150),
//                                     radius: ProDesign.pt(8),
//                                     child: CachedNetworkImage(
//                                       height: ProDesign.pt(150),
//                                       width: ProDesign.pt(150),
//                                       fit: BoxFit.cover,
//                                       imageUrl: data['image'] ?? "",
//                                       placeholder: (context, url) =>
//                                           const NormalLoader(),
//                                       errorWidget: (context, url, error) =>
//                                           Icon(
//                                         Icons.restaurant_menu_rounded,
//                                         size: ProDesign.pt(50),
//                                         color: ProjectColors.secondary400,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: ProDesign.pt(150),
//                                 child: ProText(
//                                   text: data['name'] ?? "NA",
//                                   fontSize: ProDesign.sp(18),
//                                   color: ProjectColors.secondary500,
//                                   fontWeight: FontWeight.w600,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   alignment: TextAlign.center,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             );
//           }
//         }
//         return const NormalLoader();
//       },
//     );
//   }
// }
