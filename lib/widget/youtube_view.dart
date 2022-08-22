import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
// import 'package:loccon/utils/youtube_validator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeView extends StatefulWidget {
  final String youtubeUrl;
  YoutubeView({required this.youtubeUrl});
  @override
  _YoutubeViewState createState() => _YoutubeViewState();
}

class _YoutubeViewState extends State<YoutubeView> {
  bool _isValidUrl = false;
  bool _isLoader = false;
  bool? _youtubeUrl ;
  String? videoId;
  YoutubePlayerController? _controller;



  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);



    // _validateYoutube(widget.youtubeUrl).then((value) {
    //   if (value) {
    //     setState(() {
    //       _isValidUrl = value;
          videoId = YoutubePlayer.convertUrlToId(
              // 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
              widget.youtubeUrl

          );

          if(videoId == null){
            // setState(() {
            //   _isValidUrl =false;
            // });
            // videoPlayerController = VideoPlayerController.network(
            //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
            //     // widget.youtubeUrl
            // );
            //
            // initVideo();
            // print("========dqwdekfndfdsfdsfds ${videoPlayerController}");
            // print("========dqwdekfndfdsfdsfds ${videoPlayerController!.value.isInitialized}");

            videoPlayerController = VideoPlayerController.network(
                // 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
              widget.youtubeUrl
            )
              ..initialize().then((_) {
                // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                setState(() {});
                _isLoader = true;
                _isValidUrl = true;
                _youtubeUrl = false;
                chewieController = ChewieController(
                  videoPlayerController: videoPlayerController!,
                  autoPlay: true,
                  looping: false,
                    allowFullScreen : false,
                    allowPlaybackSpeedChanging : false

                );
                /*chewieController!.addListener(() {
                  if (chewieController!.isFullScreen) {
                    print('full screen enabled');
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                    ]);
                  }
                });*/
              });

          }else{
            // setState(() {
            _controller = YoutubePlayerController(
              initialVideoId: videoId!,
              flags: const YoutubePlayerFlags(autoPlay: true,),
            );
              _isValidUrl = true;
            _youtubeUrl = true;
            _isLoader = true;
            // });
          }

          print("videoId $videoId");

    //     });
    //   }
    // });
  }



  @override
  void dispose() {
    super.dispose();

    // SystemChrome.setPreferredOrientations(
    //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    if(videoId == null) {
      print("videoId if $videoId");
      // videoPlayerController!.pause();
      videoPlayerController!.dispose();
      // chewieController!.dispose();
    }else{
      print("videoId else $videoId");
      _controller!.dispose();
    }


  }

  @override
  Widget build(BuildContext context) {

    return
      _isLoader ?

    Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: _youtubeUrl! ?

      YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,

        // showVideoProgressIndicator: false,
        // bottomActions: [],
        // topActions: [
        // ],
      ):

      _isValidUrl ?
      Chewie(
        controller: chewieController!,

      )

      // AspectRatio(
      //   aspectRatio: videoPlayerController!.value.aspectRatio,
      //   child: VideoPlayer(videoPlayerController!),
      // )

          :

      Container(height: 200,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(.8),
        ),
        alignment: Alignment.center,
        child: Text('Broken Link or Video removed',
          style: TextStyle(color: Colors.white, fontSize: 18),),
      )
      ,
    )
    :

      Container(
          height: 200,
          child: Center(
              child: CircularProgressIndicator(
                  color: Colors.red)));
    // Container(height: 220,
    //   decoration: BoxDecoration(
    //     color: Colors.black.withOpacity(.8),
    //   ),
    //   alignment: Alignment.center,
    //   child: Text('Broken Link or Video removed',
    //     style: TextStyle(color: Colors.white, fontSize: 18),),
    // )

    ;
  }
  //
  // initVideo()  {
  //
  //
  //   videoPlayerController!.initialize();
  //  setState(() {
  //
  //  });
  //
  //   // setState(() {
  //     // print("videoPlayerController ${videoPlayerController}");
  //     // print("videoPlayerController ${}");
  //     _isLoader = true;
  //     _isValidUrl = true;
  //     _youtubeUrl = false;
  //     chewieController = ChewieController(
  //       videoPlayerController: videoPlayerController!,
  //       autoPlay: true,
  //       looping: false,
  //     );
  //   // }
  //   // );
  //
  //
  //
  // }
}