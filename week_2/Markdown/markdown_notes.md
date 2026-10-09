# Markdown
Can create a content page using ctr shift p and the create table of contents - uses headings to build the table

- [Markdown](#markdown)
    - [Headings](#headings)
    - [Lists](#lists)
    - [Text formating](#text-formating)
    - [Links](#links)
      - [Images](#images)
    - [Coded Blocks](#coded-blocks)
    - [Tables:](#tables)
    - [Math](#math)



### Headings

more hashes = smaller heading up to 6

### Lists
* item 1
* item 2
* item 3

Ordered/numbered lists
1. x
2. y
3. z
   * can be indented and combined with other list types

Line breaks can be enforced with <br>

Checkboxes 
- [x] first checkbox
- [ ] second
- [x] third

### Text formating
* **bold** requires double asterix. 
* _italic_ uses underscores or single asterix
* ~~strikethrough~~ uses double ~
* these can be ~~_**combined**_~~
* >block quotes uses >

### Links
Inline Links: use [ ] for the words of the link and put the link next to it inside () eg [Search for it.](www.github.com)

Reference Links: (example)

Here's [a link to something else][another place].
Here's [yet another link][another-link].
And now back to [the first link][another place].

[another place]: www.github.com
[another-link]: www.google.com

#### Images
Works the same as links but with an ! before the []
![link](Images/Link.jpeg)
(can drag an image into text editer using shift)

### Coded Blocks

We can write coded blocks of text using ```javascript```
```javascript
function greet(name) {
  return `Hello, ${name}.`;
}

console.log(greet("world"));
```
python example:
```python
def hello():
    print("hello world")
```

### Tables:

Written as shown below or with use : on either end of the dashes for allignment

| Shortcut | Action |
|:----------:|:--------:|
| `⌘ ⇧ Z` | Toggle zen mode |
| `Escape` | Exit zen mode |
| `?` | Keyboard shortcuts |

### Math
represent math symbols using dollar signs eg
$z^2$

Inline math: $E = mc^2$

Block equations:
$$
\sum_{i=1}^{n} i = \frac{n(n+1)}{2}
$$

