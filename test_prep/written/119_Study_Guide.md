- [String and Array operations: indexing, range indexing (slicing), negative indexes, assigning elements](#string-and-array-operations-indexing-range-indexing-slicing-negative-indexes-assigning-elements)
- [Hash operations: indexing, string and symbol keys](#hash-operations-indexing-string-and-symbol-keys)
- [String methods: chars, concat, count, downcase, downcase!, freeze, include?, replace, reverse, reverse!, size, slice, slice!, split, strip, strip!, upcase, upcase!, upto](#string-methods-chars-concat-count-downcase-downcase-freeze-include-replace-reverse-reverse-size-slice-slice-split-strip-strip-upcase-upcase-upto)
- [Array methods: all?, any?, each, each\_with\_index, each\_with\_object, fetch, first, include?, join, last, map, map!, partition, pop, push, reverse, reverse!, select, select!, shift, slice, slice!, sort, sort!, unshift](#array-methods-all-any-each-each_with_index-each_with_object-fetch-first-include-join-last-map-map-partition-pop-push-reverse-reverse-select-select-shift-slice-slice-sort-sort-unshift)
- [Hash methods: all?, any?, each\_key, each\_value, empty?, include?, key, key?, keys, map, select, select!, value?, values](#hash-methods-all-any-each_key-each_value-empty-include-key-key-keys-map-select-select-value-values)
- [iteration, break and next](#iteration-break-and-next)
- [selection and transformation](#selection-and-transformation)
- [nested data structures and nested iteration](#nested-data-structures-and-nested-iteration)
- [shallow copy and deep copy](#shallow-copy-and-deep-copy)
- [method chaining](#method-chaining)


# String and Array operations: indexing, range indexing (slicing), negative indexes, assigning elements
- indexing

[Source](https://launchschool.com/lessons/6a5eccc0/assignments/17756d47)

- indicies represent each character in the string or each element of the array. They are numbered starting from 0. 

```ruby
["a", "b", "c", "d"]

# In this array, string object "a" is at index 0, the string object "b" at index 1 and so forth.
```  

- range indexing (slicing)
  - Range indexing is another way to return characters from a string. It's actually an alternative syntax to use the String#slice method. 
```ruby
string = "John Stockton sends the Utah Jazz to the NBA finals"

string[2, 2] # returns "hn"
string[24, 9] # returns "Utah Jazz"
```
  - the first number in range indexing determines the index you start on, the second determines the number of characters that are returned by the method.  
- negative indicies
  - negative indices are counted from the end of the string. So -1 represents the last character in a string, -2 represents the second to last and so on
- assigning elements
  - typically use #[]= method. 
# Hash operations: indexing, string and symbol keys
- indexing
- string keys
- symbol keys
# String methods: chars, concat, count, downcase, downcase!, freeze, include?, replace, reverse, reverse!, size, slice, slice!, split, strip, strip!, upcase, upcase!, upto
- ``String#chars``
  - this method splits the string into its component characters and returns an array with each separate character in the string as an element in the array. 
- ``String#concat``
- ``String#count``
- ``String#downcase(!)``
- ``String#freeze``
- ``String#include?``
- ``String#replace``
- ``String#reverse(!)``
- ``String#size``
- ``String#slice(!)``
- ``String#split``
- ``String#strip(!)``
- ``String#upcase(!)``
- ``String#upto``
# Array methods: all?, any?, each, each_with_index, each_with_object, fetch, first, include?, join, last, map, map!, partition, pop, push, reverse, reverse!, select, select!, shift, slice, slice!, sort, sort!, unshift
- ``Array#all?``
- ``Array#any?``
- ``Array#each``
- ``Array#each_with_index``
- ``Array#each_with_object``
- ``Array#fetch``
- ``Array#first``
- ``Array#include?``
- ``Array#join``
- ``Array#last``
- ``Array#map(!)``
- ``Array#partition``
- ``Array#pop``
- ``Array#push``
- ``Array#reverse(!)``
- ``Array#select(!)``
- ``Array#shift``
- ``Array#slice(!)``
- ``Array#sort(!)``
- ``Array#unshift``
# Hash methods: all?, any?, each_key, each_value, empty?, include?, key, key?, keys, map, select, select!, value?, values
- ``Hash#all?``
- ``Hash#any?``
- ``Hash#each_key``
- ``Hash#each_value``
- ``Hash#empty?``
- ``Hash#include?``
- ``Hash#key``
- ``Hash#key(?)``
- ``Hash#keys``
- ``Hash#map``
- ``Hash#select(!)``
- ``Hash#value?``
- ``Hash#values``
# iteration, break and next
- ``break``
- ``next``
# selection and transformation
- selection
- transformation
# nested data structures and nested iteration
- nested data structures
- nested iteration
# shallow copy and deep copy
- shallow copy
- deep copy
# method chaining

[Source](https://launchschool.com/books/ruby/read/methods#chainingmethods)

- method chaining
  - if a method returns a value, another method can be called directly on that value. This is called "chaining." For example

```ruby
# this method chain gets an input from the user and returns it as a string, 
#removes the newline character, uppercases each character in the string and returns is as a new #string

gets.chomp.uppercase
```

- each method returns a value that is then passed to the next succesive method. 