// import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// import 'widgets/alphabetic_scroll_page.dart';

// void main() => runApp(const MainApp());

// String getRandomName() {
//   final List<String> preFix = ['Aa', 'bo', 'Ce', 'Do', 'Ha', 'Tu', 'Zu'];
//   final List<String> surFix = ['sad', 'bad', 'lad', 'nad', 'kat', 'pat', 'my'];
//   preFix.shuffle();
//   surFix.shuffle();
//   return '${preFix.first}${surFix.first}';
// }

// class User {
//   final String name;
//   final String company;
//   final bool favourite;

//   User(this.name, this.company, this.favourite);
// }

// class MainApp extends StatefulWidget {
//   const MainApp({super.key});

//   @override
//   State<MainApp> createState() => _MainAppState();
// }

// class _MainAppState extends State<MainApp> {
//   List<User> userList = [];
//   List<String> strList = [];
//   List<Widget> favouriteList = [];
//   List<Widget> normalList = [];
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     for (var i = 0; i < 26; i++) {
//       userList.add(User(getRandomName(), getRandomName(), false));
//     }
//     for (var i = 0; i < 4; i++) {
//       userList.add(User(getRandomName(), getRandomName(), true));
//     }
//     userList
//         .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
//     filterList();
//     searchController.addListener(() {
//       filterList();
//     });
//     super.initState();
//   }

//   filterList() {
//     List<User> users = [];
//     users.addAll(userList);
//     favouriteList = [];
//     normalList = [];
//     strList = [];
//     if (searchController.text.isNotEmpty) {
//       users.retainWhere((user) => user.name
//           .toLowerCase()
//           .contains(searchController.text.toLowerCase()));
//     }
//     users.forEach((user) {
//       if (user.favourite) {
//         favouriteList.add(
//           Slidable(
//             child: ListTile(
//               leading: Stack(
//                 children: <Widget>[
//                   const CircleAvatar(
//                     backgroundImage:
//                         NetworkImage("https://placeimg.com/200/200/people"),
//                   ),
//                   SizedBox(
//                       height: 40,
//                       width: 40,
//                       child: Center(
//                         child: Icon(
//                           Icons.star,
//                           color: Colors.yellow[100],
//                         ),
//                       ))
//                 ],
//               ),
//               title: Text(user.name),
//               subtitle: Text(user.company),
//             ),
//           ),
//         );
//       } else {
//         normalList.add(
//           Slidable(
//             endActionPane: ActionPane(
//               motion: const DrawerMotion(),
//               dismissible: DismissiblePane(onDismissed: () {}),
//               children: [
//                 SlidableAction(
//                   onPressed: (_) {},
//                   autoClose: true,
//                   flex: 1,
//                   backgroundColor: Colors.red,
//                   foregroundColor: Colors.white,
//                   icon: Icons.delete,
//                   label: 'Delete',
//                 ),
//                 SlidableAction(
//                   autoClose: true,
//                   flex: 1,
//                   onPressed: (value) {
//                     // myList.removeAt(index);
//                     // setState(() {});
//                   },
//                   backgroundColor: Colors.blueAccent,
//                   foregroundColor: Colors.white,
//                   icon: Icons.edit,
//                   label: 'Edit',
//                 ),
//               ],
//             ),
//             child: ListTile(
//               leading: const CircleAvatar(
//                 backgroundImage:
//                     NetworkImage("https://placeimg.com/200/200/people"),
//               ),
//               title: Text(user.name),
//               subtitle: Text(user.company),
//             ),
//           ),
//         );
//         strList.add(user.name);
//       }
//     });

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: AlphabeticScrollPage(
//         // onClickedItem: (contact) {},
//         items: strList,
//       ),
      
//       // AlphabetListScrollView(
//       //   strList: strList,
//       //   highlightTextStyle: const TextStyle(
//       //     color: Colors.yellow,
//       //   ),
//       //   showPreview: true,
//       //   itemBuilder: (context, index) {
//       //     return normalList[index];
//       //   },
//       //   indexedHeight: (i) {
//       //     return 80;
//       //   },
//       //   keyboardUsage: true,
//       //   headerWidgetList: <AlphabetScrollListHeader>[
//       //     AlphabetScrollListHeader(
//       //       widgetList: [
//       //         Padding(
//       //           padding: const EdgeInsets.all(16.0),
//       //           child: TextFormField(
//       //             controller: searchController,
//       //             decoration: InputDecoration(
//       //               border: OutlineInputBorder(
//       //                   borderRadius: BorderRadius.circular(20)),
//       //               suffix: const Icon(
//       //                 Icons.search,
//       //                 color: Colors.grey,
//       //               ),
//       //               labelText: "Search",
//       //             ),
//       //           ),
//       //         )
//       //       ],
//       //       icon: const Icon(Icons.search),
//       //       indexedHeaderHeight: (index) => 80,
//       //     ),
//       //     AlphabetScrollListHeader(
//       //         widgetList: favouriteList,
//       //         icon: const Icon(Icons.star),
//       //         indexedHeaderHeight: (index) {
//       //           return 80;
//       //         }),
//       //   ],
//       // ),
//     ));
//   }
// }


import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants/constants.dart';
import 'models/contact.dart';
import 'models/contact_list.dart';
import 'models/group.dart';
import 'permission_checker.dart';
import 'screens/my_home_screen.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Contact>(ContactAdapter());
  Hive.registerAdapter<ContactList>(ContactListAdapter());
  Hive.registerAdapter<Group>(GroupAdapter());
  Hive.openBox<bool>(permissionStatusBoxName);
  await Hive.openBox<Contact>(contactsBoxName);
  await Hive.openBox<ContactList>(contactListBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionBox =
        Hive.box<bool>(permissionStatusBoxName).get(permissionStatusBoxName);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: permissionBox == null
          ? const PermisionChecker()
          : permissionBox
              ? const MyHomeScreen()
              : Container(),
      routes: {
        MyHomeScreen.id: (_) => const MyHomeScreen(),
      },
    );
  }
}
