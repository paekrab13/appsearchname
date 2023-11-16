// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../model/list_info.dart';
import '../model/name_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ignore: non_constant_identifier_names
  // List<NameModel> display_list = List.from(search_name_list);
  final myController = TextEditingController();
  Map? mapResponse;
  Map? dataResonse;
  List? listResponse;

  Future updateListFromApi(String name) async {
    http.Response response;
    // response = await http.get(Uri.https('www.melivecode.com', '/api/users/$name'));
    response = await http.get(Uri.parse('https://reqres.in/api/users?page=$name'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse?['data'];
      });
    }
  }

  // void updateList(String value) {
  //   setState(() {
  //     display_list =
  //         search_name_list.where((element) => element.firstname!.toLowerCase().contains(value.toLowerCase())).toList();
  //   });
  // }
  @override
  void initState() {
    updateListFromApi('1');

    super.initState();
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
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: myController,
              // onChanged: (value) => updateList(value),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF302360),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                  hintText: 'ex: Kittinan',
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.purple.shade900),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateListFromApi(myController.text);
              },
              child: Text('Search'),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: listResponse?.length,
                    itemBuilder: (context, index) => ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title: Text(
                            '${listResponse?[index]['first_name'].toString()}',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${listResponse?[index]['last_name'].toString()}',
                            style: TextStyle(color: Colors.white60),
                          ),
                          trailing: Text(
                            '${listResponse?[index]['email'].toString()}',
                            style: TextStyle(color: Colors.amber),
                          ),
                        )))
          ],
        ),
      ),
    );
  }
}
