import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:top_subreddit/models/subreddit.dart';
import 'package:top_subreddit/repository/repository.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Subreddit posts;
  TextEditingController controller = TextEditingController();

  Future getPosts({String subreddit, String duration}) async {
    var post = await getTopPosts(duration: duration, subreddit: subreddit);
    return post;
  }

  @override
  void initState() {
    getPosts(subreddit: 'EarthPorn', duration: 'day').then((value) {
      setState(() {
        posts = value;
        controller.text = 'EarthPorn';
      });
    });
    super.initState();
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  downloadImage(String url) async {
    try {
      var imageId = await ImageDownloader.downloadImage(
        url,
        destination: AndroidDestinationType.directoryPictures
          ..subDirectory('RedditDownloader'),
      );
      if (imageId == null) {
        return;
      }

      setState(() async {
        path = await ImageDownloader.findPath(imageId);
      });
    } catch (error) {
      print(error);
    }
  }

  // posts[0].data.children[0].data.thumbnail

  String subreddit;
  String duration;
  String dropDownButtonValue = 'day';
  String path;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 3;

    if (width < 600) {
      crossAxisCount = 1;
    } else if (width >= 600 && width < 798) {
      crossAxisCount = 2;
    } else if (width >= 798 && width < 1200) {
      crossAxisCount = 3;
    } else if (width > 1200 && width < 1800) {
      crossAxisCount = 4;
    } else if (width > 1800) {
      crossAxisCount = 5;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Subreddit_Viewer',
              style: GoogleFonts.pacifico(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'by Ikram Hasan',
              style: GoogleFonts.comfortaa(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 34, horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF1F3F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: (crossAxisCount * 150 - 40).toDouble(),
                              child: TextField(
                                controller: controller,
                                style: GoogleFonts.comfortaa(
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Subreddit Name',
                                  hintStyle: GoogleFonts.comfortaa(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Sort By:',
                              style: GoogleFonts.comfortaa(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 16),
                            DropdownButton<String>(
                              value: dropDownButtonValue,
                              items: <String>['day', 'week', 'month', 'year']
                                  .map((e) {
                                String dropDownButtonText = e;
                                if (e == 'day') dropDownButtonText = 'Top Day';
                                if (e == 'week')
                                  dropDownButtonText = 'Top Week';
                                if (e == 'month')
                                  dropDownButtonText = 'Top Month';
                                if (e == 'year')
                                  dropDownButtonText = 'Top Year';
                                return DropdownMenuItem<String>(
                                  child: Text(
                                    dropDownButtonText,
                                    style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  dropDownButtonValue = value;
                                  duration = value;
                                });
                              },
                            ),
                          ],
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            setState(() {
                              posts = null;
                            });
                            subreddit = controller.text;
                            getPosts(
                              subreddit: subreddit,
                              duration: duration,
                            ).then((value) {
                              setState(() {
                                posts = value;
                              });
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                                child: Text(
                              'Update',
                              style: GoogleFonts.comfortaa(fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                posts == null
                    ? Container(
                        height: height - height * 0.2,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: posts.data.children.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          var post = posts.data.children[index];
                          String url = post
                              .data.preview.images[0].resolutions.last.url
                              .replaceAll(';', '')
                              .replaceAll('&amp', '&');
                          return Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F3F6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              onTap: () {
                                kIsWeb
                                    ? launchURL(post.data.url)
                                    : downloadImage(post.data.url);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: img.Image.network(
                                          url,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // height: 60,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 200,
                                            child: Text(
                                              post.data.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.comfortaa(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Icon(Icons.launch),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
