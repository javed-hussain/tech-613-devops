# Python Notes

## Collections:

### Lists: 
Ordered mutable list of items of differing data types
``` python
list = ["item1", "item2", "item3"]
list.append("item") # adds item to list
lits.remove("item1") # removes specified item
```
* Many other list function such as, sort(), reverse(), index(x), insert(item, index)
* List items are acced by specifying their index : ` List[3]` (index starts at 0 and can work backwards using -ve numbers, : is a subsect / slice)
* can check if an item is in a list using ` "item" in list` returns true or false
* iterate list using `for item in list:`

 #### List comprehension:
 - a way to transform or filter a list while iterating
``` python
numbers = [1, 2, 3, 4]
squares = [n ** 2 for n in numbers]   # [1, 4, 9, 16]
evens = [n for n in numbers if n % 2 == 0]  # [2, 4]
```

### Dictionaries:
Unordered (insertion-ordered in modern Python), mutable collection of **key–value pairs**. Keys must be unique and immutable (commonly strings, numbers, or tuples); values can be any data type.

```python
student = {
    "name": "Javed",
    "age": 21,
    "course": "Computer Science"
}

student["university"] = "London"   # adds a new key-value pair
del student["age"]                 # removes a key-value pair
```

* Access a value using its key: `student["name"]`
* Use `.get(key)` to access safely — returns `None` instead of an error if the key does not exist: `student.get("grade")`
* Add or update a value: `student["age"] = 22`
* Remove an item: `del student["age"]` or `student.pop("age")`
* Check whether a **key** exists: `"name" in student` returns `True` or `False`
* Useful methods: `.keys()`, `.values()`, `.items()`, `.update()`, `.pop()`, `.clear()`

```python
student = {"name": "Javed", "age": 21, "course": "Computer Science"}

print(student["name"])          # "Javed"
print(student.get("grade"))     # None

student["age"] = 22             # updates value
student["university"] = "London"  # adds new pair
print("name" in student)          # returns true if name key exists in student

for key in student:             # iterates over keys
    print(key, student[key])

for key, value in student.items():  # iterates over key-value pairs
    print(key, value)
```

#### Dictionary comprehension:
A concise way to create or transform dictionaries while iterating.

```python
numbers =[1][2][3][4]

squares = {n: n ** 2 for n in numbers}
# {1: 1, 2: 4, 3: 9, 4: 16}

even_squares = {n: n ** 2 for n in numbers if n % 2 == 0}
# {2: 4, 4: 16}
```
## Functions:

Function definitons:
```python
 def function_name(arguments):
    pass #body of function 
```
