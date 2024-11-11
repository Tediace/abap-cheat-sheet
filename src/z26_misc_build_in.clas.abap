CLASS z26_misc_build_in DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_misc_build_in IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    """""""""""""""""""""""""""""""ABAP BOOL"""""""""""""""""""""""""""""""""""""
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
    "hint boolc4 = 1
    "check value int between -3 and 3
    "if condition match than x changed into 1

    " 0
    DATA(boolc5) = translate( val  = boolc( int <> 0 )
                              from = ` `
                              to   = `0` ).
    """"""""""""""""""""""""""""""XBOOLEAN""""""""""""""""""""""""""""""""""""
    " Boolean function that returns a truth value. Similar to boolc, it returns the value X for true, and a blank for false.
    " Unlike boolc, the return value is of type c of length 1, and can be compared with abap_true and abap_false.

    " abap_true
    DATA(xsdb1) = xsdbool( 3 > 1 ).

    "#X#
    DATA(xsdb2) = |#{ xsdbool( 1 = 1 ) }#|.

    "##
    DATA(xsdb3) = |#{ xsdbool( 1 <> 1 ) }#|.

    " Comparison with boolc
    " not equal
    IF boolc( 1 = 0 ) = xsdbool( 1 = 0 ).
      DATA(res) = `equal`.
    ELSE.
      res = `not equal`.
    ENDIF.

    " Using xsdbool instead of, for example, an IF control
    " structure or an expression with the COND operator
    " abap_true
    DATA(xsdb4) = xsdbool( -1 < 1 ).

    DATA truth_value1 TYPE abap_bool.
    IF -1 < 1.
      truth_value1 = abap_true.
    ELSE.
      truth_value1 = abap_false.
    ENDIF.

    DATA(truth_value2) = COND #( WHEN -1 < 1 THEN abap_true ELSE abap_false ).
    """""""""""""""""""""""""""""CONTAINS"""""""""""""""""""""""""""""""""""""
    " contains
    " For checking a text string based on (optional) parameters
    " - val: Text string to be searched
    " - sub/start/end: Specifying a substring to be searched in val
    " - off/len: Specifying the search range
    " - case: Specifying the case-sensitivity (the search is case-sensistive by default)
    " - pcre: Specifying a regular expression
    " contains_any_of/contains_any_not_of
    " The functions only check individual characters passed to sub/start/end (or, in case of the negation, any characters that are not contained).
    " The pcre parameter is not available.

    "-------------------- contains --------------------
    " Specifying the minimum mandatory parameters
    " Unlike most of the following examples, this one uses an IF control structure to
    " visualize the truth value.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA cont1 TYPE abap_bool.
    " abap_true
    IF contains( val = `-123456`
                 sub = `-` ).
      cont1 = abap_true.
    ELSE.
      cont1 = abap_false.
    ENDIF.

    " case (abap_true is the default)
    " abap_false
    DATA(cont2) = xsdbool( contains( val   = `ABCDE`
                                     start = `ab`
                                     case  = abap_true ) ).

    " abap_true
    DATA(cont3) = xsdbool( contains( val   = `ABCDE`
                                     start = `ab`
                                     case  = abap_false ) ).

    " end
    " abap_true
    DATA(cont4) = xsdbool( contains( val  = `UVWXYZ`
                                     end  = `xyz`
                                     case = abap_false ) ).

    " start
    " abap_false
    DATA(cont5) = xsdbool( contains( val   = `123`
                                     start = `2` ) ).

    " off/len can also be specified individually
    " Not specifying off means 0 by default
    " abap_false
    DATA(cont6) = xsdbool( contains( val = `##ab## ##cd##`
                                     sub = `cd`
                                     len = 5 ) ).

    " abap_true
    DATA(cont7) = xsdbool( contains( val = `##ab## ##cd##`
                                     sub = `cd`
                                     off = 7
                                     len = 5 ) ).

    " occ: False if there are more occurrences than specified for occ; i.e. in the following
    " example, specifying the values 1, 2, 3 returns true
    " abap_true is returned for the first 3 loop passes, abap_false for the fourth
    DO 4 TIMES.
      DATA(cont8) = xsdbool( contains( val = `ab#ab#ab#cd#ef#gh`
                                       sub = `ab`
                                       occ = sy-index ) ).
    ENDDO.

    " pcre
    " In the example, a blank is searched.
    " abap_true
    DATA(cont9) = xsdbool( contains( val  = `Hallo world`
                                     pcre = `\s` ) ).

    "-------------------- contains_any_of --------------------
    " abap_true
    DATA(cont10) = xsdbool( contains_any_of( val = `abcdefg`
                                             sub = `xyza` ) ).

    " abap_false
    DATA(cont11) = xsdbool( contains_any_of( val = `abcdefg`
                                             sub = `xyz` ) ).

    DATA(hi) = `1hallo`.
    DATA(abc) = `abcdefghijklmnopqrstuvwxyz`.
    " abap_false
    DATA(cont12) = xsdbool( contains_any_of( val   = hi
                                             start = abc ) ).

    " abap_true
    DATA(cont13) = xsdbool( contains_any_of( val = hi
                                             end = abc ) ).

    "-------------------- contains_any_not_of --------------------
    " abap_true
    DATA(cont14) = xsdbool( contains_any_not_of( val   = hi
                                                 start = abc ) ).

    " abap_false
    DATA(cont15) = xsdbool( contains_any_not_of( val = hi
                                                 end = abc ) ).
    """"""""""""""""""""""""""""""""MATCHES""""""""""""""""""""""""""""""""""
*    Comparing a search range of a value with a regular expression.
*    More optional parameters are available (e.g. case, off, len).
     "Checking validity of an email address

    " abap_true
    DATA(matches) = xsdbool( matches( val  = `jon.doe@email.com`
                                      pcre = `\w+(\.\w+)*@(\w+\.)+(\w{2,4})` ) ).
    "useful link
    "https://regexr.com/3e48o -- regex online test pattern
   """"""""""""""""""""""""""""""""""LINE EXISTS"""""""""""""""""""""""""""""""""
    TYPES: BEGIN OF s,
             comp1 TYPE i,
             comp2 TYPE c LENGTH 3,
           END OF s.
    DATA itab TYPE TABLE OF s WITH EMPTY KEY.
    itab = VALUE #( ( comp1 = 1 comp2 = 'aaa' )
                    ( comp1 = 2 comp2 = 'bbb' )
                    ( comp1 = 3 comp2 = 'ccc' ) ).
    DATA(str_tab) = VALUE string_table( ( `abc` ) ( `def` ) ( `ghi` ) ).

    " abap_true
    DATA(line_exists1) = xsdbool( line_exists( itab[ 1 ] ) ).

    " abap_false
    DATA(line_exists2) = xsdbool( line_exists( itab[ 4 ] ) ).

    " abap_true
    DATA(line_exists3) = xsdbool( line_exists( itab[ comp1 = 2 ] ) ).

    " abap_true
    DATA(line_exists4) = xsdbool( line_exists( str_tab[ 2 ] ) ).

    " abap_false
    DATA(line_exists5) = xsdbool( line_exists( str_tab[ table_line = `xxx` ] ) ).
  ENDMETHOD.
ENDCLASS.
