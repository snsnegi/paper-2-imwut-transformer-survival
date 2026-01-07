# UbiWell paper template

We use BibTeX to format our bibliographies.

All bibliography files should be saved as `.bib` files in this directory; bibliography styles should be saved as `.bst` files in this directory.
Thus, you need to install the appropriate `bst` style file and appropriate bibliography `bib` files.

## bibtex style

If it is not an ACM/IEEE paper, download a *copy* of the relevant bib style file from the submission template, add it to your paper's `bibs` folder, and edit the `\bibliographystyle` line of your `main.tex`.

## bibtex libraries

We maintain bibtex in Zotero ([UbiWell Lab](https://www.zotero.org/groups/4795056/ubiwell))

I plan to create project-specific Zotero groups soon.

### linking Overleaf projects Zotero

Overleaf allows you to directly link a Zotero library to an Overleaf project:

1. In your Overleaf project, select the `bibs` folder.
2. Click the **Upload** icon
3. Click **From Zotero** 
4. Choose the relevant Zotero group, e.g., `stress-interest`.
5. Name the new file with a corresponding name, e.g., `stress-interest.bib`
6. Edit `main.tex` to add `stress-interest` to the `\bibliography` line.

Repeat if you need other group bibliographies.

If changes are later made on Zotero, 

1. Click on the bib file, e.g., `bibs/stress-interest.bib`.
2. Click **Refresh** to ask Overleaf to pull the latest bibtex from Zotero.

### local bibtex libraries

References that are highly specific to one paper, or references that are really just to URLs (with `@www` style), should go that paper's `local.bib` file.
Your paper can load from multiple bibtex files: `\bibliography{local,ubiwell,stress-interest}`
