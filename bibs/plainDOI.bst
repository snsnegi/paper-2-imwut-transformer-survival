%% plainDOI.bst by David Kotz, kotz@dartmouth.edu
%% Updated February 2009, March 2019, December 2019
%%   modified from
% BibTeX standard bibliography style `plain'
   % Version 0.99b (8-Dec-10 release) for BibTeX versions 0.99a or later.
   % Copyright (C) 1984, 1985, 1988, 2010 Howard Trickey and Oren Patashnik.
   % Unlimited copying and redistribution of this file are permitted as long as
   % it is unmodified.  Modifications (and redistribution of modified versions)
   % are also permitted, but only if the resulting file is renamed to something
   % besides btxbst.doc, plain.bst, unsrt.bst, alpha.bst, and abbrv.bst.
   % This restriction helps ensure that all standard styles are identical.
   % The file btxbst.doc has the documentation for this style.

ENTRY
  { address
    articleno
    author
    booktitle
    chapter
    day
    doi
    edition
    editor
    fixme
    howpublished
    institution
    journal
    key
    month
    note
    number
    numpages
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    volume
    year
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
	{ add.period$ write$
	  newline$
	  "\newblock " write$
	}
	{ output.state before.all =
	    'write$
	    { add.period$ " " * write$ }
	  if$
	}
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{ newline$
  fixme empty$
    'skip$
    { "FIXME in " cite$ * ": " * fixme * warning$ }
  if$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
	'skip$
	{ after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

%=================== Mendeley-fix code start ======================

%%%%%%%%%%%%%%%%%% month-fix code start %%%%%%%%%%%%%%%%%
% DFK: fix broken 'month' field exported by Mendeley.
% Mendeley sometimes exports {10} instead of 10 or "October";
% Mendeley sometimes exports {oct} instead of oct or "October".
% on return, stack contains the proper month name.
FUNCTION {month.fixed.by.dfk}
{
  month empty$
  { "" }
  { month "1"  = {"January"}
    { month "2"  = {"February"}
      { month "3"  = {"March"}
        { month "4"  = {"April"}
          { month "5"  = {"May"}
            { month "6"  = {"June"}
              { month "7"  = {"July"}
                { month "8"  = {"August"}
                  { month "9"  = {"September"}
                    { month "10" = {"October"}
                      { month "11" = {"November"}
                        { month "12" = {"December"}
                          { month "jan" = {"January"}
                            { month "feb" = {"February"}
                              { month "mar" = {"March"}
                                { month "apr" = {"April"}
                                  { month "may" = {"May"}
                                    { month "jun" = {"June"}
                                      { month "jul" = {"July"}
                                        { month "aug" = {"August"}
                                          { month "sep" = {"September"}
                                            { month "oct" = {"October"}
                                              { month "nov" = {"November"}
                                                { month "dec" = {"December"}
                                                  { month } if$
                                                } if$
                                              } if$
                                            } if$
                                          } if$
                                        } if$
                                      } if$
                                    } if$
                                  } if$
                                } if$
                              } if$
                            } if$
                          } if$
                        } if$
                      } if$
                    } if$
                  } if$
                } if$
              } if$
            } if$
          } if$
        } if$
      } if$
    } if$
  } if$
}
%%%%%%%%%%%%%%%%%% month-fix code end %%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% search-replace code start %%%%%%%%%%%%%%%%%
% count the real number of characters:
%  input: string (top)
%  output: integer number of characters in that string
% from https://ctan.org/pkg/tamethebeast (Figure 4, adapted)
INTEGERS{ slen }
FUNCTION{string.length.by.dfk}
{
  #0 'slen :=
  {duplicate$ duplicate$ #1 slen substring$ = not}
    {slen #1 + 'slen :=}
  while$
  pop$ slen
}

% search-and-replace within a string
%  input: original string, text to find, text to replace (top)
%  output: the updated string
% from https://ctan.org/pkg/tamethebeast (Figure 5)
STRINGS{replace find text}
INTEGERS{find_length}
FUNCTION{find.replace.by.dfk}
{ 'replace :=
  'find :=
  'text :=
  find string.length.by.dfk 'find_length :=
  ""
    { text empty$ not }
    { text #1 find_length substring$ find =
        {
          replace *
          text #1 find_length + global.max$ substring$ 'text :=
        }
        { text #1 #1 substring$ *
          text #2 global.max$ substring$ 'text :=
        }
      if$
    }
  while$
}
%%%%%%%%%%%%%%%%%% search-replace code end %%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% string-truncate code start %%%%%%%%%%%%%%%%%
% truncate a string at the first space
%  input: original string
%  output: the updated string
% variables: text, slen, defined by search-replace code
% (by DFK)
FUNCTION{truncate.at.space.by.dfk}
{
  'text :=    % the original string
  #1 'slen := % length of prefix of that string
  {text #1 slen substring$ text = not     % text[1:slen] != text
   text slen #1 substring$ " "  = not     % text[slen:slen] != space
   and}                                   % loop until space or end of string
    { slen #1 + 'slen := }
  while$

  % is the slen'th character a space?
  text slen #1 substring$ " " =
    { text #1 slen #1 - substring$ }  % return text[1:slen-1]
    { text }                          % return original string
  if$
}
%%%%%%%%%%%%%%%%%% string-truncate code end %%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% DOI- and URL-format code start %%%%%%%%%%%%%%%%%
% Return a 'fixed' copy of the 'DOI' field, because Mendeley 'protects' 
% certain characters that appear in DOI strings.  We need to undo that!
% This function should not be called when DOI field is missing$.
% (by DFK)
FUNCTION {doi.fixed.by.dfk}
{
  DOI
  "{\_}" "_" find.replace.by.dfk
  "{\%}" "%" find.replace.by.dfk
}

% Return a 'fixed' copy of the 'URL' field, because Mendeley 'protects'
% certain characters that appear in URL strings, includes a newline (%0A)
% at the end of some URLs, and concatenates multiple URLs into one string.
% We unprotect characters, delete %0A, and truncate at the first space.
% This function should not be called when URL field is missing$.
% (by DFK)
FUNCTION {url.fixed.by.dfk}
{
  URL
  truncate.at.space.by.dfk
  "%0A" "" find.replace.by.dfk
}

%% DOI and URL (by DFK)
%% give preference to DOI, if present
FUNCTION {format.doi.or.url.by.dfk}
{ doi empty$
    { url empty$
	{ "" }
	{ "Online at \url{" url.fixed.by.dfk * "}" * }
      if$
    }
    { "DOI \DOIbbl{" doi.fixed.by.dfk * "}" * }
  if$
}
%%%%%%%%%%%%%%%%%% DOI- and URL-format code end %%%%%%%%%%%%%%%%%

%=================== Mendeley-fix code end ======================


INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
	{ namesleft #1 >
	    { ", " * t * }
	    { numnames #2 >
		{ "," * }
		'skip$
	      if$
	      t "others" =
		{ " et~al." * }
		{ " and " * t * }
	      if$
	    }
	  if$
	}
	't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names
      editor num.names$ #1 >
	{ ", editors" * }
	{ ", editor" * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
	{ t #1 #2 substring$ "--" = not
	    { "--" *
	      t #2 global.max$ substring$ 't :=
	    }
	    {   { t #1 #1 substring$ "-" = }
		{ "-" *
		  t #2 global.max$ substring$ 't :=
		}
	      while$
	    }
	  if$
	}
	{ t #1 #1 substring$ *
	  t #2 global.max$ substring$ 't :=
	}
      if$
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
	{ "" }
	{ "there's a month but no year in " cite$ * warning$
	  month.fixed.by.dfk
	}
      if$
    }
    { month empty$
	'year
	{ day empty$
            { month.fixed.by.dfk " " * year * }
            { month.fixed.by.dfk " " * day * ", " * year * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {format.btitle}
{ title emphasize
}

% DFK: concat top two stack items with intervening space IF both are non-empty
FUNCTION {concat.with.space}
{ duplicate$ empty$
    { % second is empty; discard it and leave just the first
      pop$
    }
    { % second is non-empty; is the first?
      swap$ duplicate$ empty$
        { pop$ }          % first was empty; discard it
        { " " * swap$ * } % first was non-empty; append a space, swap and concat
      if$
    }
  if$
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
      series empty$
	'skip$
	{ " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
	{ series field.or.null }
	{ output.state mid.sentence =
	    { "number" }
	    { "Number" }
	  if$
	  number tie.or.space.connect
	  series empty$
	    { "there's a number but no series in " cite$ * warning$ }
	    { " in " * series * }
	  if$
	}
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
	{ edition "l" change.case$ " edition" * }
	{ edition "t" change.case$ " edition" * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
	{ #1 'multiresult := }
	{ t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
	{ "pages" pages n.dashify tie.or.space.connect }
	{ "page" pages tie.or.space.connect }
      if$
    }
  if$
}

% DFK: print the article number and, if available, numpages
FUNCTION {format.articleno.numpages}
{ articleno empty$
    { "" }
    { numpages empty$
        { "article~" articleno * }
        { "article~" articleno * " (" * numpages * "~pages)" * }
       if$
    }
  if$
}

% DFK: use articleno/numpages if available, else pages
FUNCTION {format.articleno.pages}
{ articleno empty$
    { format.pages }
    { format.articleno.numpages }
  if$
}

% DFK: print articleno/number when available
FUNCTION {format.vol.num.articleno.pages}
{ number empty$
    { volume empty$
        { "" }             % neither volume nor number
        { "v." volume * }  % I dislike an unaccompanied volume number.
      if$
    }
    { volume empty$
        { "there's a number but no volume in " cite$ * warning$ "" }
        { volume "(" * number * ")" * }
      if$
    }
  if$
  % add articleno, numpages, pages if available
  format.articleno.pages concat.with.space
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
	{ "chapter" }
	{ type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
	'skip$
	{ ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
	{ "In " booktitle emphasize * }
	{ "In " format.editors * ", " * booktitle emphasize * }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {missing.link.check}
{ DOI empty$ URL empty$
  and
    { "Missing both DOI and URL in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
	{ "need key or journal for " cite$ * " to crossref " * crossref *
	  warning$
	  ""
	}
	{ "In {\em " journal * "\/}" * }
      if$
    }
    { "In " key * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
	'skip$
	{ editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
	    { " et~al." * }
	    { " and " * editor #2 "{vv~}{ll}" format.name$ * }
	  if$
	}
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "Volume" volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
	{ series empty$
	    { "need editor, key, or series for " cite$ * " to crossref " *
	      crossref * warning$
	      "" *
	    }
	    { "{\em " * series * "\/}" * }
	  if$
	}
	{ key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
	{ booktitle empty$
	    { "need editor, key, or booktitle for " cite$ * " to crossref " *
	      crossref * warning$
	      ""
	    }
	    { "In {\em " booktitle * "\/}" * }
	  if$
	}
	{ "In " key * }
      if$
    }
    { "In " format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.num.articleno.pages output
      format.date "year" output.check
    }
    { format.article.crossref output.nonnull
      format.articleno.pages output
    }
  if$
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
	{ "author and editor" editor either.or.check }
	'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output
  organization output
  new.block
  format.title "title" output.check
  howpublished address new.block.checkb
  howpublished output
  address output
  format.date output
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {electronic}
{ output.bibitem
  format.authors output
  organization output
  title new.block.checka
  format.title output
  new.block
  note output
  format.doi.or.url.by.dfk output
  "visited " format.date * output
  fin.entry
  empty.misc.check
  missing.link.check
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
	{ "author and editor" editor either.or.check }
	'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
      address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.articleno.pages output
      address empty$
	{ organization publisher new.sentence.checkb
	  organization output
	  publisher output
	  format.date "year" output.check
	}
	{ address output.nonnull
	  format.date "year" output.check
	  new.sentence
	  organization output
	  publisher output
	}
      if$
    }
    { format.incoll.inproc.crossref output.nonnull
      format.articleno.pages output
    }
  if$
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
	'skip$
	{ organization output.nonnull
	  address output
	}
      if$
    }
    { format.authors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
	{ address new.block.checka
	  address output
	}
	'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  format.date output
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  "Master's thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output
  organization output
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  howpublished output
  format.date output
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
  empty.misc.check
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.btitle "title" output.check
  new.block
  "PhD thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
	{ publisher new.sentence.checka }
	{ organization publisher new.sentence.checkb
	  organization output
	}
      if$
      publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.sentence
      editor empty$
	'skip$
	{ organization output }
      if$
      publisher output
    }
  if$
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  note "note" output.check
  format.date output
  format.doi.or.url.by.dfk output
  fin.entry
}

FUNCTION {online}{electronic}
FUNCTION {internet}{electronic}
FUNCTION {webpage}{electronic}
FUNCTION {www}{electronic}

FUNCTION {default.type} { misc }

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
	{ "   " * }
	'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
	{ "et al" * }
	{ t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
	{ "to sort, need author or key in " cite$ * warning$
	  ""
	}
	{ key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
	{ key empty$
	    { "to sort, need author, editor, or key in " cite$ * warning$
	      ""
	    }
	    { key sortify }
	  if$
	}
	{ editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
	{ key empty$
	    { "to sort, need author, organization, or key in " cite$ * warning$
	      ""
	    }
	    { key sortify }
	  if$
	}
	{ "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
	{ key empty$
	    { "to sort, need editor, organization, or key in " cite$ * warning$
	      ""
	    }
	    { key sortify }
	  if$
	}
	{ "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
	'editor.organization.sort
	{ type$ "manual" =
	    'author.organization.sort
	    'author.sort
	  if$
	}
      if$
    }
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "% plainDOImend.bst by David Kotz."		write$ newline$
  "% You must add this to your latex preamble:" write$ newline$
  "%    \usepackage{url}"                       write$ newline$
  "% or, if you want hyperlinks:"		write$ newline$
  "%    \usepackage{hyperref}" 			write$ newline$
  newline$
  "\begin{thebibliography}{"  longest.label  * "}" *			write$ newline$
  "\urlstyle{rm} % format URLs in normal font"				write$ newline$
  "\DeclareUrlCommand\DOIasURL{\urlstyle{rm}} % format DOIs same"	write$ newline$
  "\ifx\undefined\hypersetup% hyperref is not loaded"			write$ newline$
  " \newcommand\DOIbbl[1]{\DOIasURL{#1}}"				write$ newline$
  "\else% hyperref is loaded, we can put a link under the DOI"		write$ newline$
  " \newcommand\DOIbbl[1]{\href{http://dx.doi.org/#1}{\DOIasURL{#1}}}"	write$ newline$
  "\fi"									write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
