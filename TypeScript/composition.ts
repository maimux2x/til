class Square {
  readonly name = 'square';
  side: number;

  constructor(side: number) {
    this.side = side;
  }

  getArea = () => new Rectangle(this.side, this.side).getArea();
}