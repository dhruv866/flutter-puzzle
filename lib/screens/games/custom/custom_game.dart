import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:puzzle_game/controllers/custom_game_state.dart';
import 'package:puzzle_game/controllers/game_state.dart';
import 'package:puzzle_game/functioning/create_puzzle.dart';
import 'package:puzzle_game/screens/games/custom/customgame.dart';
import 'package:puzzle_game/ui/design.dart';
import 'package:image_picker/image_picker.dart' as imgpicker;

class CustomGameImagePick extends StatefulWidget {
  const CustomGameImagePick({Key? key}) : super(key: key);

  @override
  _CustomGameImagePickState createState() => _CustomGameImagePickState();
}

class _CustomGameImagePickState extends State<CustomGameImagePick> {
  bool showImage = false;
  imgpicker.XFile? pickedImage;

  pickImage() async {
    final imgpicker.ImagePicker _picker = imgpicker.ImagePicker();
    final imgpicker.XFile? image = await _picker.pickImage(
        source: imgpicker.ImageSource.gallery, imageQuality: 0);
    if (image != null) {
      setState(() {
        pickedImage = image;
        context.read<CustomGameState>().updatesStatus(imagestate.loading);
        showImage = true;
      });
      Future.delayed(Duration(seconds: 2), () {
        make_puzzle();
      });
    }
  }

  make_puzzle() async {
    final String bytes = pickedImage!.path;
    final File file = File.fromUri(Uri.file(bytes));
    final Uint8List list = file.readAsBytesSync();
    await context
        .read<GameState>()
        .updateCGImagelist(splitImage(list), context, pickedImage!);
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<CustomGameState>().updatesStatus(imagestate.select);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    contentPadding: EdgeInsets.all(15),
                    backgroundColor: Colors.grey[600],
                    title: Text(
                      'Important',
                      style: boldTextStyle(20),
                    ),
                    children: [
                      Text(
                        '* Pick A Square Image For Better Experience.',
                        style: regularTextStyle(18),
                      ),
                      verticalSpace(10),
                      Text(
                        '* Large Size Image May Take Some Time To Make Game.',
                        style: regularTextStyle(18),
                      ),
                    ],
                  );
                });
          },
          backgroundColor: mainblue.withOpacity(0.5),
          child: Icon(
            Icons.help_outline_outlined,
            size: 30,
            color: offwhite.withOpacity(0.9),
          ),
        ),
        backgroundColor: mainscaffold,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: offwhite,
              size: 40,
            ),
          ),
          actions: [
            Consumer<CustomGameState>(builder: (context, val, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: val.status == imagestate.select
                    ? IconButton(
                        onPressed: () {
                          pickImage();
                        },
                        icon: Icon(
                          Icons.add_a_photo_outlined,
                          color: offwhite,
                          size: 30,
                        ),
                      )
                    : AnimatedSwitcher(
                        duration: Duration(milliseconds: 450),
                        child: val.status == imagestate.loading
                            ? CircularProgressIndicator(
                                color: offwhite,
                              )
                            : IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomGame(pickedImage: pickedImage!),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.done_rounded,
                                  color: offwhite,
                                  size: 30,
                                ),
                              ),
                      ),
              );
            }),
          ],
          title: Text(
            'Pick An Image',
            style: boldTextStyle(22),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: showImage
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceAround,
            children: [
              verticalSpace(80),
              showImage
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Image.file(
                        File(pickedImage!.path),
                        fit: BoxFit.contain,
                      ),
                    )
                  : Text(
                      'No Image',
                      style: boldTextStyle(22).copyWith(
                        color: offwhite.withOpacity(0.5),
                      ),
                    ),
              verticalSpace(50),
              showImage
                  ? TextButton(
                      onPressed: () {
                        pickImage();
                      },
                      child: Text(
                        'New Image',
                        style: regularTextStyle(16),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(mainblue),
                        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
                        elevation: MaterialStateProperty.all(5),
                        shape: MaterialStateProperty.all(StadiumBorder()),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
