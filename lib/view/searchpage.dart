// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

import '../model/list_info.dart';
import '../model/name_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ignore: non_constant_identifier_names
  List<NameModel> display_list = List.from(search_name_list);
  void updateList(String value) {
    setState(() {
      display_list = search_name_list
          .where((element) =>
              element.firstname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1f1545),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1f1545),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search for name',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => updateList(value),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF302360),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  hintText: 'ex: Kittinan',
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.purple.shade900),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: display_list.length,
                    itemBuilder: (context, index) => ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title: Text(
                            '${display_list[index].firstname}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${display_list[index].lastname}',
                            style: TextStyle(color: Colors.white60),
                          ),
                          trailing: Text(
                            '${display_list[index].age} year',
                            style: TextStyle(color: Colors.amber),
                          ),
                        )))
          ],
        ),
      ),
    );
  }
}
