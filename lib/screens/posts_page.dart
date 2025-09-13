import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  final Map user;
  final String backgroundImage;

  const PostsPage({Key? key, required this.user, required this.backgroundImage})
    : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List comments = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments"),
      );

      if (response.statusCode == 200) {
        setState(() {
          comments = json.decode(response.body);
          loading = false;
        });
      } else {
        print("Failed to load comments");
        setState(() => loading = false);
      }
    } catch (e) {
      print("Error fetching comments: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  // Background image
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          widget.backgroundImage, // use selected image
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Top icons
                  Positioned(
                    top: 20.0,
                    left: 10.0,
                    right: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 12.0,
                          backgroundColor: const Color(0xFFF4F4F4),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(maxWidth: 10.0),
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 15.0,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.bookmark_border,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Top card: user email
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 260.0,
                      left: 30.0,
                      right: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Passeios em veneza: como gastar economizar',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const CircleAvatar(radius: 8.0),
                            const SizedBox(width: 8),
                            Text(
                              widget.user['username'], // now shows the username
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFCECDCD),
                              ),
                            ),
                            const SizedBox(width: 15.0),
                            const Icon(
                              Icons.access_time,
                              color: Color(0xFFCECDCD),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              '5min',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF929292),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bottom list of comments
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return ListTile(
                            title: Text(
                              comment['email'],
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              comment['body'],
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 16.0),
              Text('285', style: TextStyle(fontSize: 14.0)),
            ],
          ),
        ),
      ),
    );
  }
}
