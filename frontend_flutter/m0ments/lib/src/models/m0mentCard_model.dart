class M0mentCard {
  List<String> tags;
  String img;
  String title;
  String descr;
  int id;
  int votes;
  bool upvoted;
  bool downvoted;

  M0mentCard._();
  M0mentCard(
    this.img,
    this.title,
    this.descr,
    this.id,
    this.votes,
    this.upvoted,
    this.downvoted,
    this.tags,
  );

  List getTags() => tags;
  String getImg() => img;
  String getTitle() => title;
  String getDescr() => descr;
  int getId() => id;
  int getVotes() => votes;
  bool isUpvoted() => upvoted;
  bool isDownvoted() => downvoted;

  String toString() {
    return "Img: $img, Title: $title, Describtion: $descr, ID: $id, Votes: $votes, Upvoted: $upvoted, Downvoted: $downvoted, Tags: $tags";
  }

  factory M0mentCard.initial() {
    return M0mentCard._()
      ..img = "lib/src/resources/images/surprised_pikatchu.png"
      ..title = "title"
      ..descr = "describtion"
      ..id = 0
      ..votes = 0
      ..upvoted = false
      ..downvoted = false
      ..tags;
  }
}
