CLASS z26_misc_build_in DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_misc_build_in IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Boolean function that returns a truth value. In this case, it is a single-character value of type string.
    " When true, it returns the string X. When false, it returns a blank.
    " The result is not to be compared with abap_true and abap_false (because of c to string conversion).
    " To get the technical type c (with the values 'X' and ''), you can use the xsdbool function.

    " boolc returns an X or a blank of type string
    DATA(int) = 0.
    " X
    DATA(boolc1) = CONV abap_bool( boolc( int IS INITIAL ) ).

    "#X#
    DATA(boolc2) = |#{ boolc( int IS INITIAL ) }#|.

    "# #
    DATA(boolc3) = |#{ boolc( int IS NOT INITIAL ) }#|.

    " Using the translate function to return a value other than X/blank
    " 1
    DATA(boolc4) = translate( val  = boolc( int BETWEEN -3 AND 3 )
                              from = `X`
                              to   = `1` ).

    " 0
    DATA(boolc5) = translate( val  = boolc( int <> 0 )
                              from = ` `
                              to   = `0` ).
  ENDMETHOD.
ENDCLASS.
