class M0mentCard {
  List<String> tags;
  String img;
  String title;
  String descr;
  int id;
  int votes;

  M0mentCard._();
  M0mentCard(
    this.img,
    this.title,
    this.descr,
    this.id,
    this.votes,
    this.tags,
  );

  List getTags() => tags;
  String getImg() => img;
  String etTitle() => title;
  String getDescr() => descr;
  int getId() => id;
  int getVotes() => votes;

  String toString() {
    return "Img: $img, Title: $title, Describtion: $descr, ID: $id, Votes: $votes, Tags: $tags";
  }

  factory M0mentCard.initial() {
    return M0mentCard._()
      ..img = "lib/src/resources/images/surprised_pikatchu.png"
      ..title = "title"
      ..descr = "describtion"
      ..id = 0
      ..votes = 0
      ..tags;
  }
}
