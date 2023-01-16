# Fundamentals

## Topics

- [Main](#main "Main")
- [Format](#format "Format")
- [Datatypes](#datatypes "Datatypes")
- [Variables](#variables "Variables")
- [Lists](#lists "Lists")
- [Tuples](#tuples "Tuples")
- [Dictionaries](#dictionaries "Dictionaries")
- [Sets](#sets "Sets")
- [Conditions](#conditions "Conditions")
- [Iterate](#iterate "Iterate")
- [Exceptions](#exceptions "Exceptions")
- [With](#with "With")
- [Functions](#functions "Functions")
- [List Comprehension](#list-comprehension "List Comprehension")

## Main [^](#topics "Topics")

Only runs as a whole script (i.e. not for imports)

```python
if __name__ == '__main__':
    ...
```

## Format [^](#topics "Topics")

Comments (single line only)

```python
# ignored code
```

Blocks (indents use 4 spaces or 1 tab)

```python
...:
    ...
```

Print (console logging)

```python
print(x)
print(x, ends='replace default \n')
```

Input (prompt)

```python
input('Enter string: ')
```

## Datatypes [^](#topics "Topics")

`1. Number = integers & floats`

```python
# Numerical operators
    + - * / %
```

- _Division always results in a float_
- _Modulus takes sign of second value_

```python
# Integer division
    //
```

- _Rounds down to match decimal point_

```python
# Exponentials
    **
```

```python
# Parenthesis precedence
    ()
```

`2. Boolean = True (1) | False (0)`

```python
# Boolean operators
    and | or | not
```

```python
# Comparison operators
    < | <= | > | >= | == | !=
```

- _Casts value as Boolean for eval, returns non-cast value for use_
- _Allows chaining (x < y < z)_

```python
# is vs ==
    is checks reference equality
    == checks value equality
```

```python
# Falsy
    0 | '' | [] | () | {} | None
```

`3. String = "" | ''`

```python
# Multi-line strings
    """ ... """
```

```python
# Indexing
    [:]
```

```python
# Length
    len(x)
```

```python
# Concatenation
    "s1" + "s2"
    "s1" "s2"
```

```python
# Template Literals
    f"string {x}"
    "string {}".format(x)
```

`4. None = special object`

- _== does not work since None has no attributes, use is_

`Type Conversion`

```python
# Change type
    bool(x) | int(x) | float(x) | str(x)
```

```python
# Check type
    type(x)

# Check available methods
    dir(datatype)

# Explains method
    help(method)
```

## Variables [^](#topics "Topics")

Variables are assigned, not declared

```python
# Swap values
    x, y = y, x
```

```python
# Walrus operator (:=)
    Define variables within assignments/conditions
```

## Lists [^](#topics "Topics")

List = []

```python
# Indexing
    list[i]
```

```python
# Check if value in list
    x in list
```

```python
# Length
    len(list)
```

```python
# Slice
    list[start:end:steps]
    list[:x] # start to x
    list[x:] # x to end
    list[::x] # in steps of x
    list[::-1] # reverse
```

```python
# Copy
    list2 = list1[:]
```

```python
# Delete
    del list[i]
```

```python
# Concatenation
    list1.extend(list2)
    list*num # repeats values
```

```python
# Important Methods
    .append(x) # adds value
    .pop() # remove last value
    .slice(start inclusive, end exclusive, steps)
    .index(x) # index of first occurrence of x
    .remove(x) # remove first occurrence of x
    .insert(i, x) # inserts x at list[i]
    .replace(old, new, count)
```

## Tuples [^](#topics "Topics")

Tuple = immutable list within ()

- _List indexing/methods apply_

```python
# Must end with , if there is only one value
    () # empty
    (x,) # one value
    (x,y,z) # multiple values
```

```python
# Unpack using variables
    x,y,z = (1,2,3)
    # x = 1 | y = 2 | z = 3
```

```python
# Extended unpacking
    x,*y,z = (1,2,3,4)
    # x = 1 | y = [2,3] | z = 4
```

## Dictionaries [^](#topics "Topics")

Dictionary = {key:value}

- _Keys can only be immutable datatypes (number | string | tuple)_

```python
# Find value
    dict[key]
```

```python
# List all keys/values
    list(dict.keys()) # keys list
    [*dict] # keys list
    list(dict.values()) # values list
```

```python
# Check for key
    x in dict # KeyError for non-existent key
    .get(x) # None for non-existent key
    .get(x, default) # sets default
```

```python
# Change value
    dict[key] = value
```

```python
# Change key-value pair
    {key:value, **{new_key:new_value}}
```

```python
# Delete
    del dict[key]
```

```python
# Important Methods
    .update({key:value}) # add key-value pair
    .setdefault(key, value) # adds key if key does not exist
```

## Sets [^](#topics "Topics")

Set = keys without values using set() or {}

- _Keys cannot be duplicates or mutable_

```python
# Add
    .add(x)
```

```python
# Remove
    set - x
```

```python
# Concatenate
    set1 | set2
```

```python
# Copy
    set1 = set2
```

```python
# Checks
    x in set # value
    & # overlap between sets
    ^ # difference between sets
    >= # superset of set
    <= # subset of set
```

## Conditions [^](#topics "Topics")

```python
# Ternary
    x if condition else y
```

```python
# Ternary assignment
    (x:=y) if condition else (a:=b)
```

```python
# Elif
    if condition:
        x
    elif condition:
        y
    else:
        z
```

## Iterate [^](#topics "Topics")

```python
# For loop
    for i in iterable:
        ...
```

```python
# While loop
    while condition:
        ...
```

```python
# Exits
    continue # continue loop without current iteration
    break # stop loop
```

- _avoid infinite loops:_
  - _indents closes loop_
  - _range(lower inc, upper exc, step)_

## Exceptions [^](#topics "Topics")

Attempt

```python
try:
    raise IndexError('message')
    except IndexError as e:
        ...
    except (TypeError, NameError):
        ...
else:
    ...
finally:
    ...
```

## With [^](#topics "Topics")

Go through a file

```python
with open('file') as f:
    for line in f:
        ...
```

Read file string

```python
with open('file') as f:
    f.read()
```

Write string to new file

```python
with open('file', 'new') as f:
    f.write(str(x))
```

Read file object

```python
with open('file') as f:
    json.load(f)
```

Write object to new file

```python
with open('file', 'new') as f:
    f.write(json.dumps(x))
```

## Functions [^](#topics "Topics")

Defining

```python
def function(x, y):
    ...
```

```python
# Default inputs
    def function(x='default value'):
        ...
```

```python
# Create tuple from many arguments
    def function(*args):
        ...
```

```python
# Create object from keyword arguments
    def function(**keywords):
        ...
```

Calling

```python
function(x, y)
```

```python
# Keywords can be called in any order
    function(y=1,x=2)
```

```python
# Tuple arguments
    function(*tuple)
```

```python
# Object arguments
    function(**object)
```

Return (default = None)

```python
def function(x):
    return None
```

- _Multiple values become tuple_

Function Scope = local variables

- _Access to global scope but local priority_

First class Functions = function returns function

```python
def function1(x):
    function2(y): return x+y
    return function2

variable = function1(10)
variable(5) = 15
```

Anonymous Functions = single-line functions

```python
(lambda x, y: x + y)(x,y)
```

High Order Functions = iteration functions

```python
# Map
    list(map(function, iter))

# Max
    list(map(max, iter1, iter2))

# Filter
    list(filter(lambda x: condition, iter))

# Reduce
    .reduce(lambda x,y: x + y, iter, 0)
```

## List Comprehension [^](#topics "Topics")

List Comprehension = transform iterate filter

```python
list2 = [expression for e in list1 condition]
```

```python
# Set comprehension
    set = {x for x in iter}
```

```python
# Nested comprehension
    nested = [z for x in iterable1 y for y in iterable2 x + y]
```
