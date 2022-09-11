function search(nums: number[], target: number): number {
  if (nums.length === 1) {
    return nums[0] === target ? 0 : -1;
  }

  let left = 0;
  let right = nums.length - 1;

  let middle = left + Math.floor((right - left) / 2);

  while (nums[middle] !== target && middle !== -1) {
    if (left === right) {
      middle = -1;
      continue;
    }

    if (nums[middle] > target) {
      right = middle - 1;
    }

    if (nums[middle] < target) {
      left = middle + 1;
    }
    middle = left + Math.floor((right - left) / 2);
  }
  return middle;
}
