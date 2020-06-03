class CardDetail {
  CardDetail(this.shape, this.number);
  String shape;
  int number;
}

List<CardDetail> cardStack = [
  CardDetail('square', 3),
  CardDetail('circle', 10),
  CardDetail('star', 3),
  CardDetail('square', 2),
  CardDetail('triangle', 1),
  CardDetail('cross', 12),
  CardDetail('square', 3)
];

List<int> dummyIntegers = [
  1,
  2,
  3,
  4,
  5,
];
