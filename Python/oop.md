- [Classes](#classes "Classes")

## Classes [^](#topics "Topics")

Creating

```python
class Example:
    def __init__(self, name):
        self.name = name
        self.role = software

    def function1(self):
        ...
    def function2(self, param):
        ...
```

Calling

```python
var = Example(name)
```

Special Class Methods

```python
# Constructor
    __init__

# Print string when printing instance
    __str__

```

Class @ = shared between instances

```python
# Call function in all instances when used in one
    @class def function(class):
        ...

# Call function without instance
    @staticmethod def function():
        ...

# Getter
    @property def function(self):
        ...

# Setter
    @variable.setter def function(self, value):
        self.variable = value
        ...

# Delete
    @variable.deleter def function(self):
        del self.variable
```

Subclasses = inherit properties/methods of parent classes

```python
# Creating
    class Sub(Parent):
        pass
        def __init__(self, parent_param, param):
            self.param = param

# Call parent method within method
    def method(self):
        super().__init__(parent_method) + x
```

Check instance

```python
isinstance(instance)
type(instance) is class
```
