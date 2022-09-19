import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'firestore_methods.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key, this.durationInDay}) : super(key: key);
  final durationInDay;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _titleController = TextEditingController();
  bool isLoading = false;

  void sendPost() async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods()
          .uploadPost(_titleController.text, widget.durationInDay);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Add Post')),
            SizedBox(height: 6),
            AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : InkWell(
                      onTap: () {
                        sendPost();
                      },
                      child: Container(
                        width: 200,
                        height: 40,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Text(
                          'Send Post',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
