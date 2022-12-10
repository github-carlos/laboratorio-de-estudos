function mySqrt(x: number): number {
  let result = 1;
  for (; (result * result) < x; result ++);

  if ((result * result) === x) return result;
  return result - 1;
};

console.log(mySqrt(1))
console.log(mySqrt(2))
console.log(mySqrt(8))
console.log(mySqrt(49))