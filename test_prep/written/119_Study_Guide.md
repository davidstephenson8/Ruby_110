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

- range indexing (slicing)
- negative indicies
- assigning elements
# Hash operations: indexing, string and symbol keys
- indexing
- string keys
- symbol keys
# String methods: chars, concat, count, downcase, downcase!, freeze, include?, replace, reverse, reverse!, size, slice, slice!, split, strip, strip!, upcase, upcase!, upto
- chars
- concat
- count
- downcase(!)
- freeze
- include?
- replace
- reverse(!)
- size
- slice(!)
- split
- strip(!)
- upcase(!)
- upto
# Array methods: all?, any?, each, each_with_index, each_with_object, fetch, first, include?, join, last, map, map!, partition, pop, push, reverse, reverse!, select, select!, shift, slice, slice!, sort, sort!, unshift
- all?
- any?
- each
- each_with_index
- each_with_object
- fetch
- first
- include?
- join
- last
- map(!)
- partition
- pop
- push
- reverse(!)
- select(!)
- shift
- slice(!)
- sort(!)
- unshift
# Hash methods: all?, any?, each_key, each_value, empty?, include?, key, key?, keys, map, select, select!, value?, values
- all?
- any?
- each_key
- each_value
- empty?
- include?
- key
- key(?)
- keys
- map
- select(!)
- value?
- values
# iteration, break and next
- break
- next
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
# this method chain gets an input from the user and returns it as a string, removes the newline character, uppercases each character in the string and returns is as a new string

gets.chomp.uppercase

```