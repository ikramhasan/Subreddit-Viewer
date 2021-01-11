import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:top_subreddit/models/subreddit.dart';

getTopPosts({
  String subreddit,
  String duration,
}) async {
  String url = 'https://www.reddit.com/r/$subreddit/top/.json?t=$duration';
  var response = await http.get(url);
  var rawJson = jsonDecode(response.body);
  var post = Subreddit.fromJson(rawJson);
  return post;
}
