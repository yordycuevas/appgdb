import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("employees")
        .doc(id)
        .set(employeeInfoMap);
  }

  Future<Stream<QuerySnapshot>> getEmployeeDetails() async {
    return await FirebaseFirestore.instance.collection("employees").snapshots();
  }

  Future updateEmployeeDetails(String id, Map<String, dynamic> updateInfo)async{
    return await FirebaseFirestore.instance.collection("employees").doc(id).update(updateInfo);
  }

  Future deleteEmployeeDetails(String id) async {
  try {
    await FirebaseFirestore.instance.collection("employees").doc(id).delete();
    print("Documento eliminado correctamente.");
  } catch (e) {
    print("Error al eliminar el documento: $e");
  }
}
}
