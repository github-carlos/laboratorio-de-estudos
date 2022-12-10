
function quickSort(list: Array<number>): Array<number> {
  if (list.length < 2) {
    return list;
  }
  const pivot = list[0];
  const leftSide = list.filter((item) => item < pivot);
  const rightSide = list.filter((item) => item > pivot);

  return [...quickSort(leftSide), pivot, ...quickSort(rightSide)];
}

console.log(quickSort([6, 2, 1, 0, 10, 20]));
console.log(quickSort([]));