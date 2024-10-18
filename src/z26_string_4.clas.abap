CLASS z26_string_4 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_string_4 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Shifting Content
    " SHIFT statements
    " Note that all results below refer to s1 = `hallo`.
    DATA(s1) = `hallo`. " Type string

    SHIFT s1. " No addition; string shifted one place to the left: allo
    SHIFT s1 BY 2 PLACES. " Without direction, left by default: llo
    SHIFT s1 BY 3 PLACES RIGHT. " With direction, variable length strings are extended: '   hallo'

    " Note that all results below refer to ch4 = 'hallo'.
    DATA(ch4) = 'hallo'. " Type c length 5

    SHIFT ch4 BY 3 PLACES RIGHT. " Fixed length string: '   ha'

    " CIRCULAR addition: characters that are moved out of the string are
    " added at the other end again
    SHIFT ch4 BY 3 PLACES LEFT CIRCULAR. " lohal
    SHIFT ch4 UP TO `ll`. " Shift characters up to a specific character set: llo

    " Deleting leading and trailing characters
    DATA(s2) = `   hallo   `.
    DATA(s3) = s2.

    SHIFT s2 LEFT DELETING LEADING ` `. "'hallo   '
    SHIFT s3 RIGHT DELETING TRAILING ` `. "'      hallo' (length is kept)

    " Removing trailing blanks in strings without leading blanks;
    " you can use the following sequence of statements
    DATA(s4) = `hallo   `.
    DATA(s5) = s4.
    SHIFT s4 RIGHT DELETING TRAILING ` `. "'   hallo'
    SHIFT s4 LEFT DELETING LEADING ` `. "'hallo'

    " To remove trailing blanks, you can also use the following method of the
    " cl_abap_string_utilities class.
    cl_abap_string_utilities=>del_trailing_blanks( CHANGING str = s5 ).
    ASSERT s4 = s5.
    " Note the c2str_preserving_blanks method for preserving trailing blanks
    " when assigning text fields to data objects of type string.

    " String functions with parameters
    s1 = `hallo`.

    s2 = shift_left( val    = s1
                     places = 3 ). " lo
    s2 = shift_left( val      = s1
                     circular = 2 ). " lloha

    " Note that shift_right does not extend a variable length string.
    s2 = shift_right( val    = s1
                      places = 3 ). " ha
    s2 = shift_right( val = `abc   `
                      sub = ` ` ). "'abc'
    s2 = shift_right( val = `abc   ` ). "'abc' (same result as above)
  ENDMETHOD.
ENDCLASS.
