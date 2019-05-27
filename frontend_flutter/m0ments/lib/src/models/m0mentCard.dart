class M0mentCard {
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
  );

  String getImg() =>  img;
  String etTitle() => title;
  String getDescr() => descr;
  int getId() => id;
  int getVotes() => votes;

  String toString(){
    return "$img, $title, $descr,$id, $votes";
  }
}
