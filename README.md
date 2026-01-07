# UbiWell paper template

This template is stored as a repo on GitHub so we can refine it over time, like any software.

To assist in refining the template, clone and commit as usual.

To use it to write a paper, however, *do not clone this repo;* follow the instructions below.

## Getting started
We prepare and edit the paper in Overleaf.
Each Overleaf project matches exactly one Git repo.
To write a paper in Overleaf, you must first create a new GitHub repository for this paper, initialize it with a copy of this repository, then create a new Overleaf project from that repository.
For example, suppose this is a paper about `fribbles` in project `stress`.
Our naming convention indicates repo names should look like 
(project name)-(document type)-(document name)-(venue and last two digits of year).
Thus, `stress-paper-fribbles-imwut23`
 will be the name of the GitHub repo and of the Overleaf project.
Steps:

1. Visit this [repository](https://github.com/ubiwell/ubiwell-paper-template) on GitHub.

1. Click the green button **Use this template**.

1. Give the new repo the name `stress-paper-fribbles-imwut23`, and add a description. Ensure it is Private, and choose the appropriate org (in most cases use the UbiWell Lab org; or discuss with Professor Mishra).

1. Click the **Settings** (gear icon) then **Manage access** to grant *Write* (or even *Maintain*) access to collaborators or teams.

1. Then, on [Overleaf](https://www.overleaf.com/), click **New project** and select **Import from GitHub**; pick that repo you just created. Make sure to share the Overleaf repository with the relevant collaborators and team members. Northeastern now offers Overleaf professional plan to all its members -- see [here](www.overleaf.com/edu/northeastern).

1. Overleaf will compile the paper; by default, it compiles in ['simple' template](#template-formats).

1. **Edit this README to remove this "Getting Started" section**, and replace it with your own text.
For example, embed a link to the CFP or submission site.



<!-------  KEEP THE FOLLOWING IN YOUR README  -------->

## Editing the paper

Now you can edit the paper.

1. Edit `main.tex` to select the [template format](#template-formats) you need.
As instructed within that file, delete the comments and code for formats you do not use, then adjust the remainder to suit your format and your paper.
Read about [bibs](bibs/README.md) to adjust the bibliography style.

1. Edit the paper body in `body.tex`.
A single-file approach makes search-replace operations easier.
Only the abstract and acknowledgements are separate.
But read about [figs](figs/README.md) and [tabs](tabs/README.md).

1. Periodically use Overleaf's menu to commit the paper to GitHub: **Menu**... **GitHub**... **Push Overleaf Changes to GitHub**.
(Overleaf does not automatically push to or pull from GitHub.)
Definitely commit at all major milestones - such as sharing a draft with coauthors, or immediately after submission.


## Template formats

### Simple template

The template defaults to a 'simple' one-column full-page format.
To use it, delete all the ACM and IEEE comments and code, then edit the geometry and other settings to your liking.

### ACM template

To use ACM style, delete all the simple and IEEE comments and code, move the `\maketitle` command after the abstract, then edit the 'author' section using ACM style.
Read the [ACM style documentation](https://www.acm.org/publications/proceedings-template) - it is complex, and full use of this style requires many additional settings.



### IEEE template

To use IEEE style, delete all the simple and ACM comments and code, then edit the 'author' section using IEEE style.
Read the IEEE style documentation for [journals](https://journals.ieeeauthorcenter.ieee.org/create-your-ieee-journal-article/authoring-tools-and-templates/ieee-article-templates/templates-for-transactions/) or for [conferences](https://www.ieee.org/conferences/publishing/templates.html) - it is complex, and full use of this style requires many additional settings.


## Draftmode

Anywhere in the paper you may use `\ifsubmit` to determine whether to format in 'submit' mode (clean, ready to submit) or 'draft' mode (with meta-comments and alternate formatting).

Draft mode is the default; to change, modify `main.tex` to uncomment one of the following:

```
% \submitfalse	% 'draft' mode
% \submittrue	% 'submit' mode
```

## Anonymization

Many paper venues require "double-blind" submission, in which the author names are hidden to the reviewers.
In `main.tex` there is a section about anonymization; swap the following two lines to your desired setting.
The second line takes precedence.

```
\anonymizedfalse    % do not anonymize authors
\anonymizedtrue     % anonymize authors
```

It also contains example code for a command that represents the system name - automatically anonymized when in anonymized mode.

## Comments

The preamble defines three commands that can be used to add meta-comments to the paper:

* `\hey` for short inline comments
* `\note` for paragraph comments
* `\bibtex` to indicate a need to insert a citation.

They disappear in 'submit' mode.

Anything inside `\hide{...}` does not appear in either mode; it is useful for commenting-out large chunks of text.


## Spellcheck

Overleaf provides its own spell-check capability.


## Submission

After submission: rename the submitted pdf file `SUBMIT.pdf` and commit it to the repo.
Add a tag with `git tag SUBMIT` and push it with `git push --tags`.
After reviews come back, save them as `REVIEWS.txt`.

## Resubmission

If the paper was rejected and will be revised for resubmission, copy the reviewer's comments into `REVIEWS.txt`, commit and push, add a tag like `REJECTED-imwut23`.  Push with `git push --tags`.

Then copy the Overleaf project and, from Overleaf, create a corresponding (new) GitHub repo to back it.
Choose the names of project and repo carefully! to distinguish them from the prior versions.

## Publication

After camera-ready pdf has been sent to publisher, commit `CAMERA.pdf`.

Later, when the paper appears, download pdf from the publisher and commit `FINAL.pdf`.

Add a tag with `git tag FINAL` and push it with `git tag push --tags`.
(Or, do the equivalent via the GitHub web interface.)
