# UbiWell paper template

All tables should be saved as `.tex` files in this directory.

## Tables

It is generally cleaner to put the contents of a table, particularly a large or complex table, in a separate `.tex` file in the `tabs` subdirectory.
Indeed, the `\addtable` command expects it.
For example,

```
\addtable{foobar}{1.0}{This is a table about foos and bars. It will be scaled to the width of 1.0 text line.}
```

This command loads `tabs/foobar.tex` and creates a label that can be referenced like `\tabref{foobar}` ("Table 2".)

Always place the `\addtable` *before* any `\tabref`.
Generally, I place a table immediately prior to the paragraph that first references that table.
This approach avoids the (inelegant) result in which a table appears on a page before its first reference.
