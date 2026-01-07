# UbiWell paper template

All figures should be saved as graphics files (or in some cases, `.tex` files) in this directory.

## Figures

Most figures are images, and must be stored in a separate file.
For neatness, please keep them all in the `figs` subdirectory.
Indeed, the `\addfigure` command expects it.
For example,

```
\addfigure{foobar}{1.0}{This is a figure about foos and bars.  It will be scaled to the width of 1.0 text line.}
```

This command looks for a file named like `figs/foobar.png` (or another graphics-related filename extension) and creates a label that can be referenced like `\figref{foobar}` ("Figure 3".)

Always place the `\addfigure` *before* any `\figref`.
Generally, I place a figure immediately prior to the paragraph that first references that figure.
This approach avoids the (inelegant) result in which a figure appears on a page before its first reference.

Some figures are actually a combination of multiple images, using some LaTeX code to set them up.
In that case, use

```
\addfiguretex{fribble}{1.0}{This is a figure constructed by inputting a latex file called 'figs/fribble.tex'.}
```
