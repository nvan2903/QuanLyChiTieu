import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;
  StreamSubscription? _streamSubscription;
  final ImagePicker _picker = ImagePicker();

  void _sendMessage({File? image}) async {
    final message = _controller.text.trim();

    if (message.isNotEmpty || image != null) {
      setState(() {
        _messages.add({
          "text": message.isNotEmpty ? "Bạn: $message" : null,
          "image": image,
          "isUser": true,
        });
        _isTyping = true;
      });

      // Nếu có hình ảnh, sử dụng `textAndImage`, nếu không chỉ sử dụng văn bản
      if (image != null) {
        Gemini.instance.textAndImage(
            text: message, // văn bản nhập từ người dùng
            images: [await image.readAsBytes()] // hình ảnh gửi kèm
        ).then((response) {
          setState(() {
            _messages.add({
              "text": "Gemini: ${response?.content?.parts?.last.text ?? 'Không có phản hồi'}",
              "isUser": false,
            });
            _isTyping = false;
          });
        }).catchError((error) {
          setState(() {
            _messages.add({"text": "Lỗi: Something went wrong.", "isUser": false});
            _isTyping = false;
          });
        });
      } else {
        _streamSubscription = Gemini.instance.streamGenerateContent(message).listen(
              (response) {
            setState(() {
              _messages.add({"text": "Gemini: ${response.output}", "isUser": false});
              _isTyping = false;
            });
          },
          onError: (e) {
            setState(() {
              _messages.add({"text": "Lỗi: Something went wrong.", "isUser": false});
              _isTyping = false;
            });
          },
        );
      }

      _controller.clear();
    }
  }

  Future<void> _sendImage() async {
    final XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      _sendMessage(image: File(imageFile.path));
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gemini Chat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Align(
                    alignment: message["isUser"] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      child: Card(
                        color: message["isUser"] ? Colors.blue.shade100 : Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (message["text"] != null)
                                Text(
                                  message["text"] ?? "",
                                  style: TextStyle(fontSize: 16),
                                  softWrap: true,
                                ),
                              if (message["image"] != null)
                                GestureDetector(
                                  onTap: () {
                                    // Xử lý phóng to hình ảnh khi nhấn vào
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Image.file(message["image"]),
                                        );
                                      },
                                    );
                                  },
                                  child: Image.file(
                                    message["image"],
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (_isTyping)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Gemini đang nhập...',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: _sendImage,
                  color: Colors.blue,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Hãy nhập gì đó...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
