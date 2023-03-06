class Square extends Rectangle {
  readonly name = 'square';
  side: number;

  constructor(side: number) {
    super(side, side);
  }
}