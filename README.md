# webgen
webgen is a lightweight website generator that converts a custom markup language (wg) into html. It provides a simple way to create static websites.

## usage
simply run
```
webgen input.wg > output.html
```

Options:
-h, --help  Display usage information

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
.code | Defines a code block with syntax highlighting (language specified)
.link | Defines a hyperlink
.img | Inserts an image
.hr | inserts an horizontal line

Example WG file:

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

The above WG file will generate the following HTML:

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

see the `examples` directory for more.

## note
Note: The webgen compiler requires the 'aha' and 'bat' packages for syntax highlighting. If these packages are not available, code blocks will not have syntax highlighting.

## license
see LICENSE.md

