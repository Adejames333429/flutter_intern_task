import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts(); // call it when widget loads
  }

  Future<void> fetchPosts() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      headers: {"User-Agent": "FlutterApp/1.0", "Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
      });
    } else {
      print("Failed to load posts: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts")),
      body:
          posts.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(posts[index]["title"]),
                    subtitle: Text(posts[index]["body"]),
                  );
                },
              ),
    );
  }
}
