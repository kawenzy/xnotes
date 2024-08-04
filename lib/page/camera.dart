import 'dart:io' show Directory;
import 'package:camerawesome/pigeon.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:xenotes/page/gallery.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  // final _faceDetectionController = BehaviorSubject<FaceDetectionModel>();
  // Preview? _preview;
  // final options = FaceDetectorOptions(
  //   enableContours: true,
  //   enableClassification: true,
  //   enableLandmarks: true,
  // );
  // late final faceDetector = FaceDetector(options: options);

  @override
  Widget build(BuildContext context) {
    return CameraAwesomeBuilder.awesome(
      saveConfig: SaveConfig.photo(
        exifPreferences: ExifPreferences(saveGPSLocation: true),
        pathBuilder: (s) async {
          final dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DCIM);
          final Directory dirf =
              await Directory('$dir/xenotes')
                  .create(recursive: true);
          if (s.length == 1) {
            final String filepath =
                '${dirf.path}/${DateTime.now().microsecond}.jpg';
            return SingleCaptureRequest(filepath, s.first);
          }
          return MultipleCaptureRequest({
            for (final ss in s)
              ss: '${dirf.path}/${DateTime.now().microsecond}.jpg'
          });
        },
      ),
      sensorConfig: SensorConfig.multiple(
          sensors: [Sensor.type(SensorType.ultraWideAngle)]),
      onMediaTap: (mediacapture) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Gallery(),));
      },
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return CameraAwesomeBuilder.awesome(
//       saveConfig: SaveConfig.photoAndVideo(
//         initialCaptureMode: CaptureMode.photo,
//         videoOptions: VideoOptions(
//             quality: VideoRecordingQuality.fhd,
//             enableAudio: true,
//             android: AndroidVideoOptions(
//                 bitrate: 6000000,
//                 fallbackStrategy: QualityFallbackStrategy.higher)),
//         exifPreferences: ExifPreferences(saveGPSLocation: true),
//         photoPathBuilder: (s) async {
//           final Directory? dir = await getExternalStorageDirectory();
//           final Directory dirf =
//               await Directory('${dir!.path}/xenotes')
//                   .create(recursive: true);
//           if (s.length == 1) {
//             final String filepath =
//                 '${dirf.path}/${DateTime.now().microsecond}.jpg';
//             return SingleCaptureRequest(filepath, s.first);
//           }
//           return MultipleCaptureRequest({
//             for (final ss in s)
//               ss: '${dirf.path}/${DateTime.now().microsecond}.jpg'
//           });
//         },
//         videoPathBuilder: (sensors) async {
//           final Directory? dir = await getExternalStorageDirectory();
//           final Directory dirf =
//               await Directory('${dir!.path}/xenotes')
//                   .create(recursive: true);
//           if (sensors.length == 1) {
//             final String filepath =
//                 '${dirf.path}/${DateTime.now().microsecond}.mp4';
//             return SingleCaptureRequest(filepath, sensors.first);
//           }
//           return MultipleCaptureRequest({
//             for (final ss in sensors)
//               ss: '${dirf.path}/${DateTime.now().microsecond}.mp4'
//           });
//         },
//       ),
//       sensorConfig: SensorConfig.multiple(
//           sensors: [Sensor.type(SensorType.ultraWideAngle)]),
//       onMediaTap: (mediacapture) {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const Gallery(),));
//       },
//     );
//   }
// }
