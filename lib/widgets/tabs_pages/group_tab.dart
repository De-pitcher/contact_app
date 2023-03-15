// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../view_model/contacts.dart';
// import '../group_list_view.dart';

// class GroupTab extends StatelessWidget {
//   const GroupTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.71,
//       child: Consumer<Contacts>(builder: (ctx, contact, _) {
//         final groupList = contact.groups;
//         return ListView(
//           children: groupList
//               .map(
//                 (e) => GroupListView(
//                   groupName: e,
//                   color: Colors.blue,
//                   groupContacts: contact.item
//                       .where((cont) => cont.group!.contains(e))
//                       .toList(),
//                 ),
//               )
//               .toList(),
//         );
//       }),
//     );
//   }
// }
