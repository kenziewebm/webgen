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

Example WG file:

```wg
.title My Website
.s Introduction
.p Welcome to my website!
.ssec About
.p This website is created using the webgen compiler.
.code bash
#!/usr/bin/env bash
echo "Hello, World!"
.end
.link https://github.com/webgen Github Repository
```

The above WG file will generate the following HTML:

```html
<title>My Website</title>
<h1>1. Introduction</h1>
<p>Welcome to my website!</p>
<h2>1.1 About</h2>
<p>This website is created using the webgen compiler.</p>
<code><pre>
<span style="color: #c8c8c8;">#!/usr/bin/env bash</span>
<span style="color: #c8c8c8;">echo "Hello, World!"</span>
</pre></code>
<a href="https://github.com/webgen">GitHub Repository</a>
```

see the `examples` directory for more.

## note
Note: The webgen compiler requires the 'aha' and 'bat' packages for syntax highlighting. If these packages are not available, code blocks will not have syntax highlighting.

## license
see LICENSE.md

