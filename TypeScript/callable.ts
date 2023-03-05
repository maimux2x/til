{
  interface NumOp {
    (n: number, m: number): number;
  }

  const add: NumOp = function(n, m) {
    return n + m;
  };

  const subtract: NumOp = (n, m) => n - m;

  console.log(
    add(1, 2),
    subtract(7, 2),
  );
}

{
  const add: {(n: number, m: number): number} = function(n, m) {
    return n + m;
  };
  const subtract: {(n: number, m: number): number} = (n, m) => n - m;

  console.log(
    add(1, 2),
    subtract(7, 2),
  );
}

{
  const add: (n: number, m: number) => number = function (n, m) {
    return n + m;
  };
  const subtract: (n: number, m: number) => number = (n, m) => n - m;

  console.log(
    add(1, 2),
    subtract(7, 2),
  );
}