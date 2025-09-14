import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/notifier.dart';

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
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  // Background image with gradient
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(widget.backgroundImage, fit: BoxFit.cover),
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
                    left: 20.0,
                    right: 10.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 12.0,
                          backgroundColor: theme.scaffoldBackgroundColor,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(maxWidth: 10.0),
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 15.0,
                              color: theme.iconTheme.color,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_border,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Top card: user info
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
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 8.0,
                              backgroundColor:
                                  isDarkMode
                                      ? Colors.grey[800]
                                      : Colors.grey[300],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.user['username'],
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[300],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 15.0),
                            Icon(
                              Icons.access_time,
                              color: Colors.grey[400],
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '5min',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bottom comments container
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.48,
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
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
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: Text(
                              comment['body'],
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
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
        backgroundColor:
            theme.floatingActionButtonTheme.backgroundColor ??
            (isDarkMode ? Colors.grey[900] : Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 16.0),
              Text(
                '285',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
