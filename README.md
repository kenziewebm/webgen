# webgen
webgen is a lightweight website generator.

![examples/example.wg](https://github.com/kenziewebm/webgen/blob/master/webgen.png?raw=true)

## usage
simply run
```
webgen input.wg > output.html
```

## setup

to avoid referencing the script and getting yourself in directory hell, install webgen globally by
```sh
make install
```
and then you can simply use `webgen` in your terminal everywhere.

you can always uninstall webgen later using
```sh
make uninstall
```

## dependancies
webgen requires the 'aha' and 'bat' packages for syntax highlighting.
if these packages are not available, code blocks will not have syntax highlighting.

## wg syntax

tag | effect
---|---
.title | Defines the title of the website
.s, .sec |  Defines a section
.ss, .ssec | Defines a subsection
.head, .h | Defines a subheading
.p | Defines a paragraph
.noparse | Excludes the content from parsing (useful for embedding HTML code)
.style | Defines the website style (light, dark, or custom CSS file)
.code | Defines a code block with syntax highlighting (specify the language)
.link | Defines a hyperlink
.img | Inserts an image
.hr | inserts an horizontal line
.quote | Starts a quote (you can also specify `.quote greentext`)

`.noparse` and `.code` blocks are ended with `.end`. `.quote` blocks are ended with `.endquote`, this is because im too stupid to figure out another way

example wg file:

```wg
.title My Website
.s Introduction
.p Welcome to my website!
.ssec About
.p This website was created using webgen.
.code bash
#!/usr/bin/env bash
echo "Hello, World!"
.end
```

the above wg file will generate the following html:

```html
<title>My Website</title>
<h1>1. Introduction</h1>
<p>Welcome to my website!
<h2>1.1. About</h2>
<p>This website was created using webgen.
<code><pre>
lang: bash
<hr>
<span style="color:#a0a1a7;">#</span><span style="color:#a0a1a7;">!/usr/bin/env bash</span>
<span style="color:#0184bc;">echo</span><span style="color:#383a42;"> </span><span style="color:#50a14f;">&quot;</span><span style="color:#50a14f;">Hello, World!</span><span style="color:#50a14f;">&quot;</span>
</pre></code>
<hr><small>made with <a href="https://github.com/aquakenzie/webgen">webgen</a> <3</small>
```

see [examples](https://github.com/kenziewebm/webgen/tree/master/examples) for more.

## websites that use webgen (friends :3)
[azerg](https://arezg.neocities.org/alt/) <3

## license
see LICENSE.md

