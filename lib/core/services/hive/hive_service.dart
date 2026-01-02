import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:match_aura/core/constants/hive_table_constant.dart';
import 'package:match_aura/features/auth/data/models/auth_hive_model.dart';
import 'package:path_provider/path_provider.dart';


final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});


class HiveService {
  // init
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    // C:/sdore/fdsfn/foeindf/lost_od_nkdf  // file path
    final path = '${directory.path}/${HiveTableConstant.dbName}';
    Hive.init(path);
    _registerAdapther();
    await openBoxes();
    
    
  }


  // Register Adapters
  void _registerAdapther(){
      if(!Hive.isAdapterRegistered(HiveTableConstant.authTypeId)){
        Hive.registerAdapter(AuthHiveModelAdapter());
      }
  }

  // Open Boxes
  Future<void> openBoxes() async {
      await Hive.openBox<AuthHiveModel>(HiveTableConstant.authTable);
  }


  // Close boxes
  Future<void> close() async {
    await Hive.close();
  }


  Box<AuthHiveModel> get _authBox =>
    Hive.box<AuthHiveModel>(HiveTableConstant.authTable);

  Future<AuthHiveModel> registerUser(AuthHiveModel  model) async{
    await _authBox.put(model.authId,model);
    return model;
  }  

  //login
  Future<AuthHiveModel?> loginUser(String email,String password) async{
    final users = _authBox.values.where(
      (user)=>user.email==email && user.password==password,
    );
    if(users.isNotEmpty){
      return users.first;
    }
    return null;
  }

  //logOut
  Future<void> logoutUser() async{
    
  }

  AuthHiveModel? getCurrentUser(String authId){
    return _authBox.get(authId);
  }

  bool isEmailExists(String email){
    final users = _authBox.values.where((user)=>user.email==email);
    return users.isNotEmpty;
  }
}
