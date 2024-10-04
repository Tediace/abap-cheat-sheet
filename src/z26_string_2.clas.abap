CLASS z26_string_2 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA s1   TYPE string.
    DATA s2   TYPE string.
    DATA s3   TYPE string.
    DATA t    TYPE string.
    DATA itab TYPE TABLE OF string.

    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_string_2 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Determining the Length of Strings
    "- To determine the length of a string, you can use the string function strlen.
    "- Note that the result depends on the type of the string, i. e. the result for a data object of type string includes trailing blanks. a fixed-length string does not include them.
    "- To exclude trailing blanks in all cases, regardless of the data type, you can use the built-in numofchar function.
    "- xstrlen returns the number of bytes of a byte-like argument.

    " strlen
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA(len_c)   = strlen( 'abc   ' ). " 3
    DATA(len_str) = strlen( `abc   ` ). " 6
    out->write( len_str ).
    " numofchar
    len_c   = numofchar( 'abc   ' ). " 3
    len_str = numofchar( `abc   ` ). " 3
    out->write( len_str ).

    DATA(xstr) = CONV xstring( `480065006C006C006F00200077006F0072006C0064002100` ).
    DATA(len_xstr) = xstrlen( xstr ). " 24
    out->write( len_xstr ).

    " Concatenating Strings
    "- Two or more strings can be concatenated using the concatenation operator && and string templates. Alternatively, you can use concatenate statements.
    "- It is also possible to concatenate lines from internal tables with character-like line type into a string to avoid a loop.
    "- a more modern way is to use the string function concat_lines_of.

    "&& and string template
    s1 = |ABAP|. " ABAP
    s2 = |abap { s1 }|. " abap ABAP
    s3 = |{ s1 }. { s2 }!|. " ABAP. abap ABAP!

    " CONCATENATE statements
    CONCATENATE s1 s2 INTO s3. " ABAPabap ABAP

    " Multiple data objects and target declared inline
    CONCATENATE s1 ` ` s2 INTO DATA(s5). " ABAP abap ABAP

    " TODO: variable is assigned but never used (ABAP cleaner)
    CONCATENATE s1 s2 s5 INTO DATA(s6). " ABAPabap ABAPABAP abap ABAP

    " You can also add a separation sign using the addition SEPARATED BY
    CONCATENATE s1 s2 INTO s3 SEPARATED BY ` `. " ABAP abap ABAP

    CONCATENATE s1 s2 INTO s3 SEPARATED BY `#`. " ABAP#abap ABAP

    " Keeping trailing blanks in the result when concatenating fixed length
    " strings. The ones of variable length strings are respected by default.
    " TODO: variable is assigned but never used (ABAP cleaner)
    CONCATENATE 'a  ' 'b  ' 'c  ' INTO DATA(ch) RESPECTING BLANKS. "'a  b  c  '

    " Concatenating lines of internal tables into a string
    CONCATENATE LINES OF itab INTO t SEPARATED BY ` `.

    " Using concat_lines_of
    s1 = concat_lines_of( table = itab ). " Without separator
    s1 = concat_lines_of( table = itab
                          sep   = ` ` ). " With separator
  ENDMETHOD.
ENDCLASS.
