CLASS z26_construtor_expr DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_construtor_expr IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " VALUE
    TYPES: BEGIN OF struc_type,
             a TYPE i,
             b TYPE c LENGTH 3,
           END OF struc_type.

    DATA struc TYPE struc_type.

    " Using VALUE constructor expression
    " Note: The data type can be retrieved from the context. Then, # can
    " be specified.
    struc = VALUE #( a = 1
                     b = 'aaa' ).

    out->write( struc ).
    """"""""""""""""""""""""""""RESULT""""""""""""""""""""""""""""""""""""""
    " A    B
    " 1    aaa

    " Using an inline declaration
    " In the following example, the type cannot be retrieved from the
    " context(#). Therefore, an explicit specification of the type is
    " required (struc_type).
    DATA(struc2) = VALUE struc_type( a = 2
                                     b = 'bbb' ).

    out->write( struc2 ). " result same with struc
    "-------------- VALUE constructor used for nested/deep data objects  --------------

    " Creating a nested structure
    DATA: BEGIN OF nested_struc,
            a TYPE i,
            BEGIN OF struct,
              b TYPE i,
              c TYPE c LENGTH 3,
            END OF struct,
          END OF nested_struc.

    " Populating a nested structure
    nested_struc = VALUE #( a      = 1
                            struct = VALUE #( b = 1
                                              c = 'aaa' ) ).
    out->write( nested_struc ).

    DATA itab TYPE TABLE OF struc_type WITH EMPTY KEY.
    " Populating an internal table
    itab = VALUE #( ( a = 1 b = 'aaa' )
                    ( a = 2 b = 'bbb' ) ).

    " Two more lines are added, existing content is preserved, the internal table is not
    " initialized
    "syntax base make existing content added
    itab = VALUE #( BASE itab
                    ( a = 3 b = 'ccc' )
                    ( a = 4 b = 'ddd' )
                    ( a = 5 b = 'eee' )
                    ( a = 6 b = 'fff' ) ).

    out->write( itab ).
    """"""""""""""""""""""""""""RESULT""""""""""""""""""""""""""""""""""""""
    "A    B
    "1    aaa
    "2    bbb
    "3    ccc
    "4    ddd
    "5    eee
    "6    fff
    DATA(itab5) = itab.
    itab = VALUE #( ( LINES OF itab5 STEP 2 ) ). "Adding every second line
*                ( LINES OF itab6 USING KEY primary_key ) ). "Specifying a table key
    out->write( itab ).
    """"""""""""""""""""""""""""RESULT""""""""""""""""""""""""""""""""""""""
    "A    B
    "1    aaa
    "3    ccc
    "5    eee
  ENDMETHOD.
ENDCLASS.
