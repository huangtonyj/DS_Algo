# Dynamic Programming

You will have 90 minutes to complete this assessment. Please rename your project to *your* first and last name before you zip it up and submit it on Progress Tracker. 

`firstname_lastname`

Run "bundle exec rspec" on your terminal to check how many specs you've passed.


### Initialize 
Define your cache instance varialbe in `initialize` if you have to.

```ruby
def initialize
  @my_cache = {}
end
```

### Blair numbers
*Blair numbers* is defined as below :

- The first Blair number, <i>b<sub>1</sub></i>, is 1,
- The second Blair number, <i>b<sub>2</sub></i>, is 2,
- The <i>k</i>th Blair number is the sum of the previous two Blair numbers plus the *k* - 1st odd number. For example, <i>b<sub>3</sub></i> = <i>b<sub>2</sub></i> + <i>b<sub>1</sub></i> + 2nd odd = 1 + 2 + 3 = 6.

Your job in this question is to write `blair_nums(n)`, which should return the *nth* Blair number.

### Frogs Hopping
A frog is sitting at the bottom of a staircase with *n* stairs. Tiny little frog can only jump so many steps at once. In particular, it can only hop 1, 2, or 3 steps at a time.

<img src="dp_images/frog_diagram.png" />

Given this information, write a function to return the number of ways the frog can get to the top of the stairs. For example, if there are two stairs in the staircase, there are two ways for the frog to get to the top: hop 2 steps, or hop 1 step and then hop 1 step again. For *n* = 3, there are 4 ways: [1, 1, 1], [1, 2], [2, 1], and [3].

Build the cache that you need using `frog_cache_builder`, and return the correct entry from that cache.

### Knapsack

Knapsack Problem: write a function that takes in an array of weights, an array of values, and a weight capacity and returns the maximum value possible given the weight constraint.  

For example: if weights = [1, 2, 3], values = [10, 4, 8], and capacity = 3, your function should return 10 + 4 = 14, as the best possible set of items to include are items 0 and 1, whose values are 10 and 4 respectively.  Duplicates are not allowed -- that is, you can only include a particular item once.

## Bonus
### Maze Solver

You're given a maze and asked to find a path from its starting location to the finish. The maze is 2-dimensional, and will be represented by an array of characters. Empty squares are represented with `" "`, blocked spaces with `"X"`, your location with `"L"`, and the finish with `"F"`. 

Write a function that takes in the maze array, starting position, and ending position, and returns an array of moves from start to finish. 
