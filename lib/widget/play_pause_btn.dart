import 'package:avatar_glow/avatar_glow.dart';
import 'package:nrtfm/constant/color.dart';
import 'package:nrtfm/provider/audio_player/audio_player.dart';
import 'package:nrtfm/utils/barrel.dart';

class PlayPauseBtn extends StatefulWidget {
  final bool ispaused;
  final String isSongState;
  final double iconSize;
  final double radius;
  final double endRadius;
  final double size;
  const PlayPauseBtn({
    Key? key,
    required this.ispaused,
    required this.isSongState,
    required this.iconSize,
    required this.radius,
    required this.size,
    required this.endRadius,
  }) : super(key: key);

  @override
  State<PlayPauseBtn> createState() => _PlayPauseBtnState();
}

class _PlayPauseBtnState extends State<PlayPauseBtn> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        widget.isSongState == "Loading"
            ? SizedBox(
                height: widget.size,
                width: widget.size,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(207, 88, 87, 87)),
                ),
              )
            : const SizedBox(),
        AvatarGlow(
          glowColor: const Color.fromARGB(255, 248, 219, 219),
          animate: !widget.ispaused,
          endRadius: widget.endRadius,
          child: CircleAvatar(
            backgroundColor: Kcolor.primaryColor,
            radius: widget.radius,
            child: InkWell(
              splashColor: Kcolor.transparent,
              highlightColor: Kcolor.transparent,
              onTap: () {
                if (widget.ispaused) {
                  Provider.of<MusicPlayer>(context, listen: false).play();
                } else {
                  Provider.of<MusicPlayer>(context, listen: false).stop();
                }
              },
              child: Center(
                child: widget.ispaused
                    ? Icon(
                        Icons.play_arrow,
                        color: Kcolor.white,
                        size: widget.iconSize,
                      )
                    : Icon(
                        Icons.pause,
                        color: Kcolor.white,
                        size: widget.iconSize,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
