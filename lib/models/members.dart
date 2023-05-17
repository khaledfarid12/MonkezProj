class Members {
  String id;
  String name;
  String email;
  String address;
  String urlphoto;
  String pos;

  Members(
    this.id,
    this.name,
    this.email,
    this.address,
    this.urlphoto,
    this.pos,
  );
}

List<Members> members = [
  Members('1', "kayla", "", "Champs-Élysées \nactor,\nparis, france.",
      "Assets/kyla.png", "wife"),
  Members('2', "Alex", "", "sartouville \n teacher ,\nparis, france.",
      "Assets/father.png", "father"),
  Members('3', "Andria", "", "Saint-Denis \n banker,\nparis, france.",
      "Assets/child.png", "son"),
  Members('4', "Patrick", "", "patrickjohn1020 \nInstructor,\nCanada,Toronto.",
      "Assets/Patrick.png", "husban")
];
