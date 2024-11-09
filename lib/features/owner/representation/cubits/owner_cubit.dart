import 'dart:io';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

class OwnerCubit extends Cubit<OwnerStates> {
  //repo instance
  final OwnerRepo ownerRepo;

  //setup Cloudinary server
  var cloudinary = Cloudinary.fromStringUrl(
      'cloudinary://${dotenv.get('IMG_API_KEY')}:${dotenv.get('IMG_API_SECRET')}@${dotenv.get('IMG_CLOUD_NAME')}');

  OwnerCubit({required this.ownerRepo}) : super(OwnerInitial());

  Future<void> addVenueToDatabase({
    required String name,
    required String lat,
    required String lon,
    required String ownerId,
    required List<int> startDate,
    required List<int> endDate,
    required List<int> time,
    List<String>? pics,
  }) async {
    try {
      //loading...
      emit(OwnerLoading('Uploading Your Event, Please Wait...'));

      //add to db
      await ownerRepo.addVenueToDatabase(
        name: name,
        lat: lat,
        lon: lon,
        startDate: startDate,
        endDate: endDate,
        time: time,
        ownerId: ownerId,
        pics: pics,
      );

      //done
      emit(OwnerLoaded());
    } catch (e) {
      //error
      emit(OwnerError(e.toString()));
    }
  }

  Future<List<String>> addImagesToServer(List<XFile> images) async {
    try {
      //loading...
      emit(OwnerLoading('Uploading Images, Please Wait...'));

      //server config
      cloudinary.config.urlConfig.secure = true;

      List<String> urls = [];
      urls.clear();

      // request upload to server
      for (int i = 0; i < images.length; i++) {
        var response = await cloudinary.uploader().upload(
              File(images[i].path),
              params: UploadParams(
                uniqueFilename: true,
                overwrite: true,
              ),
            );
        urls.add(response!.data!.secureUrl ?? '');
      }

      return urls;
    } catch (e) {
      //error
      emit(OwnerError(e.toString()));
      return [];
    }
  }
}
