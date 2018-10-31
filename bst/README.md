# Binary Search Trees

You will have 90 minutes to complete this assessment. Please rename your project to *your* first and last name before you zip it up and submit it on Progress Tracker. 

`firstname_lastname`

Run "bundle exec rspec" on your terminal to check how many specs you've passed.

*Note*: Implement BSTNode class before BinarySearchTree class.

## `BinarySearchTree`

**NB: There are multiple ways to implement these various methods. If you need to, feel free to tweak the skeleton and add helper methods in order to write the methods in a way that makes sense to you, as long as it passes the specs. _However, do not change the specs._** 

**In our implementation of the BST, some of these BST methods call on helper methods and allow for the recursion to happen in the helper methods.** 

**It's up to you to decide how you want to implement your methods, as long as it properly executes what it needs to do on a Binary Search Tree.**


#### `#delete`
*hint*: Helper methods are recommended here!

#### `#is_balanced?` and `#depth`
*hint*: Write `#depth` first, as you will use this as a helper method in `#is_balanced?`.

#### `#in_order_traversal`
In order traversal should return the set of `value`s held by the nodes in the `BinarySearchTree` in sorted order. 

Your `#in_order_traversal` method should return an array that contains the data set underlying the BST, in sorted order.
