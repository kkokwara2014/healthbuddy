class RoleModel {
  final String? id;
  final String name;

  RoleModel({this.id, required this.name});
}

List<RoleModel> roles = [
  RoleModel(id: "1", name: "Admin"),
  RoleModel(id: "2", name: "Doctor"),
  RoleModel(id: "3", name: "User"),
];
