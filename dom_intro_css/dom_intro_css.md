# The HTML DOM and CSS

## The Mozilla Developer Network
### Or: Your best friend.

The MDN is the best source on the internet for information about the client side part of web development.  It is a detailed reference for HTML, CSS, and Javascript.  When you find information that tells you to use a CSS property you're not sure about, don't just copy paste code, go to MDN and read in detail about what that property does.  There are many other sites with useful information, MDN has the correct and detailed information that you can use to understand what you are doing.  The MDN is a thorough reference, so expect to have to focus to understand some of the pages there.

[https://developer.mozilla.org/en-US/](https://developer.mozilla.org/en-US/)

## Agenda
1. HTML Elements and the DOM Tree
2. What is CSS, and why does it exist?
3. Basic CSS Properties
4. Referring to Elements: CSS Selectors
5. The Box Model
6. Display, Float, and Position
6. The Cascade
7. Inheritance

##HTML Elements and the DOM Tree
### An HTML Page
Every HTML page that we make here will follow the same pattern:

```
<!DOCTYPE html>
<html>
</html>
```

1. There is a Doctype, which tells the browser which version of HTML we are using.  We will only be writing modern HTML, so we only need DOCTYPE html.  Other doctypes are for telling the browser to pretend it is outdated.

2. Then there is an html element.

We know there's more to HTML than that, so let's dive into what the html element is.

### An HTML Element

Each HTML element has a _starting tag_, which is a tag name, followed by an attribute list, wrapped in `< >`:

`<tag_name attr1="attr1value" attr2="attr2value">`

The attribute list is a list of key->value pairs, where the keys are unquoted strings with no whitespace, and the values are either unquoted strings with no whitespace or quoted strings that can have whitespace.  For your own sanity, I suggest you wrap all element values in quotes.

Let's look at a couple examples:

`<img src="imageurl.png">`

This should look familiar.  `img` is the tab name, and the `src` attribute has the value `imageurl.png`.

Some elements, like `img`, are _void elements_.  They have no _content_ and no _closing tag_.  The rest, like `div`, have a starting tag with a tag name and attributes, then contents, then a closing tag.  The closing tag is a forward slash, then the tag name, all wrapped in angle brackets: `</html>`.

The contents an element can have vary by element.  Let's go to the MDN and compare the acceptable contents of the `<html>` element and the `<div>` element.

[https://developer.mozilla.org/en-US/](https://developer.mozilla.org/en-US/)

We can see that the permitted content for the `html` tag is one `head` element followed by one `body` element.  The permitted content for the `div`, on the other hand, is any kind of _flow content_, which could be any of a great big list of elements, or it could be text.  Using MDN, you can read about _flow content_ vs _sectioning content_ vs _phrasing content_, if you're interested.

```
<!DOCTYPE html>
<html attribute_name="I'm the value of an attribute">
  <body>
    <div> 
      <h3>First div!</h3>
      <ul>
        <li> First Item </li>
        <li> Second Item </li>
        <li> Third Item </li>
      </ul>
    </div>
    <div> 
      <h2>Here are some contents of the second div!</h2>
      <p> First paragraph. </p>
      <p> Second paragraph. </p>
    </div>
  </body>
</html>
```

As you can see, adding elements and content just put it on the page, without any kind of control over the layout or the colors.  To move elements around the page and give the content of our HTML form, we use CSS, short for Cascading Style Sheets.

Remember that the `html` element has a `head` element as well as a `body`.  In that `head` element, we're going to put a `style` element.

```
<!DOCTYPE html>
<html>
  <head>
	  <style>
      div {
        color: blue;
      }
      #firstdiv { 
        float: left;
        margin-right: 40px;
        color: #8A2908;
      }
      #firsth2 {
        margin-top: 2px;
      }
    </style>
  </head>
  <body>
    <div id=firstdiv> 
      <h2 id=firsth2>First div!</h2>
      <ul>
        <li> First Item </li>
        <li> Second Item </li>
        <li> Third Item </li>
      </ul>
    </div>
    <div> 
      <h2>Here are some contents of the second div!</h2>
      <p> First paragraph. </p>
      <p> Second paragraph. </p>
    </div>
  </body>
</html>
```

As you can see, we've moved the first div to the left of the second, and we've colored the text in both the divs.

In the sites we make, we will not be putting CSS in a style element like this.  We will be using separate css files.

```
<!DOCTYPE html>
<html>
  <head>
  	  <link rel="stylesheet" type="text/css" href="6.css">
  </head>
  <body>
    <div id=firstdiv> 
      <h2 id=firsth2>First div!</h2>
      <ul>
        <li> First Item </li>
        <li> Second Item </li>
        <li> Third Item </li>
      </ul>
    </div>
    <div> 
      <h2>Here are some contents of the second div!</h2>
      <p> First paragraph. </p>
      <p> Second paragraph. </p>
    </div>
  </body>
</html>
```

Now we can change the content and the styling remains the same:

```
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="6.css">
  </head>
  <body>
    <div id=firstdiv> 
      <h2 id=firsth2>Here are some of my fave sites!</h2>
      <ul>
        <li><a href="https://developer.mozilla.org/en-US/docs/Web">The Mozilla Developer Network</a></li>
        <li><a href="http://paulirish.com">Paul Irish's Blog</a></li>
        <li><a href="http://www.flickr.com/photos/girliemac/sets/72157628409467125/">
          Http Status Cats</a></li>
      </ul>
    </div>
    <div> 
      <h2>Raphael Sofaer's Site</h2>
      <p> I am a teacher! </p>
      <p> Now we are learning about CSS! </p>
    </div>
  </body>
</html>
```
##What is CSS, and why does it exist?

Using CSS allows us to separate the contents of the page from the styling and layout of the page.  Let's look at an example of how separate they can be:

[http://www.csszengarden.com/](http://www.csszengarden.com/)

The CSS Zen Garden is a site that allows us to look at the same HTML with a variety of different CSS files and see how wholly the site is changed by just changing the CSS.

Now we can change content without worrying about styling, change styling without worrying about content, and working in a team where some developers are more focused on styling is much easier.

## Anatomy of a CSS Rule

```
selector {
	rule_name: value;
	rule_name: value;
}
```

##Basic CSS Properties
Let's try using some basic CSS properties:

* background-color: <color>;
* color: <color>;
* border: <br-width> <br-style> <br-color>;
* border-radius: 

##Referring to Elements: CSS Selectors
####Element Selector

```
div{
	border: medium groove green;
}
```
We can use a tag name to select all the elements of that type and apply rules to them.

#### ID selector

```
#firstdiv{
	color: red;
}
```

The id selector uses a hash character `#`, then a string, to select the element that has exactly that string value for its id attribute.  id attributes MUST be unique.  Do not make a static id attribute in an ERB loop, as that will result in a non-unique attribute.

####Class selector

```
.blue-border{
	border: thick ridge blue;
}
```

The class selector uses `.` and a string to select all the elements that has that class.  Classes are defined through the HTML class attribute.  The value of the attribute is a space separated list of classes.

```
.red-text.light{
	color: lightsalmon;
}
```

We can use multiple selectors together. `.red-text.light` selects elements with both the `red-text` and the `light` classes.  

####Descendant selector
```
div#seconddiv div{
  border: thick outset lightseagreen;
}
```

A space, or descendant selector, combines two selectors.  This selector gets all `div` elements which are descendants of a `div` element that has id `seconddiv`.
#### Child Selector
```
div > a{
  font-weight: bolder;
}
```

The `>`, or child selector, is distinct from the descendant selector.  This gets all `a` elements which are children of any `div` element.

##The Box Model

Elements in a web page are modeled as boxes.  They have a content box with a height and width, then a padding surrounding that, then a border around the padding, then margin around the border.

![The Box Model](boxmodel.png)

The margins of sibling elements can overlap, and the margin of a parent can overlap with the margin of the first and last child elements.

##More Properties: Display, Float, and Position

### Display
The display style property controls what sort of box the element is given.  Some elements, like `a`, have `inline` boxes by default.  Try putting `inline` on a set of `li` elements. They can be rendered inline with other elements.  Other elements, like `div`, have `block` boxes by default.  They are not rendered inline with other elements.  You can also set `display: none;` to hide an element completely.

### Float
The `float` property starts out as `none` for all elements, no elements float by default.  We can use `float: left;` or `float: right;` to move an element to the left or right.  It is removed from the normal flow of the page and pushed in the direction it was floated until it reaches the edge of its containing box or another floated element.  

### Position
The `position` property controls how the element is positioned:
>__static__:
This keyword let the element use the normal behavior, that is it is laid out in its current position in the flow.  The top, right, bottom, and left properties do not apply.

>__relative__:
This keyword lays out all elements as though the element were not positioned, and then adjust the element's position, without changing layout (and thus leaving a gap for the element where it would have been had it not been positioned). The effect of position:relative on table-*-group, table-row, table-column, table-cell, and table-caption elements is undefined.

>__absolute__:
Do not leave space for the element. Instead, position it at a specified position relative to its closest positioned ancestor or to the containing block. Absolutely positioned boxes can have margins, they do not collapse with any other margins.

>__fixed__:
Do not leave space for the element. Instead, position it at a specified position relative to the screen's viewport and doesn't move when scrolled. When printing, position it at that fixed position on every page.

Each of these have uses	 of their own.  `static` is the default one, `fixed` is useful for fixed navigation elements, and `absolute` and `relative` positioning are useful for having close control over how the page is layed out.

##The Cascade and Specificity

What happens when two css rules seem to conflict?


```

<div class="class-on-div">
	I'm in a div
</div>

div{
	color: red;
}
.class-on-div{
	color: green;
}
div.class-on-div{
	color: blue;
}

```

The CSS Cascade algorithm decides which rules that apply to an element take precedence.

From least priority to highest priority:

1. Browser default styles
1. Browser default styles with `!important`
1. User defined styles (usually from browser settings)
1. Web page defined styles
1. Web page defined styles with `!important`
1. User defined styles with `!important`

Don't use `!important`.

If two rules are equal in the cascade, their specificity decides which is used.  Once again from least to highest specificity:

1. Universal selectors (*)
1. Type selectors (div)
1. Class selectors (.class-name)
1. Attributes selectors ([attr-name=attr-value])
1. Pseudo-classes (:link, :visited, :hover, and many others)
1. ID selectors (#id-name)
1. Inline style (setting the style attribute in the element)

There's a precisely laid out algorithm you can read about specificity, which details what happens with complicated selectors, but specificity is pretty intuitive.

Never set style attributes in an element.

##Inheritance

Some properties, like `color`, are inherited by default.  Others, like `border`, are not inherited.  If a property is inherited, an element will use the value of the property on its parent element unless it has a value of its own set.  The MDN pages for each css property tell whether they are inherited, but it is also fairly intuitive.

## Further Reading
CSS Resources and Tutorials:
[http://css.maxdesign.com.au/index.htm](http://css.maxdesign.com.au/index.htm)

Taming Lists:
[http://alistapart.com/article/taminglists/](http://alistapart.com/article/taminglists/)

The Mozilla Developer Network:
[https://developer.mozilla.org/en-US/](https://developer.mozilla.org/en-US/)

Colour Lovers, Palettes and Color Schemes:
[http://www.colourlovers.com/](http://www.colourlovers.com/)

FlatUI Colors:
[http://flatuicolors.com/](http://flatuicolors.com/)
