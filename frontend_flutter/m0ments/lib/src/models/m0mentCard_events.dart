abstract class M0mentCardEvent{}

class TestEvent extends M0mentCardEvent{}

class Vote extends M0mentCardEvent{}

class Upvote extends M0mentCardEvent{}

class Downvote extends M0mentCardEvent{}

class SetTitle extends M0mentCardEvent{
  final String newTitle;

  SetTitle(this.newTitle);
}

class SetDescription extends M0mentCardEvent{
  final String newDescr;

  SetDescription(this.newDescr);
}

