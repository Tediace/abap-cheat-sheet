CLASS z26_string_3 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_string_3 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Splitting Strings
    DATA(s1) = `Hallo,world,123`.
    DATA s2 TYPE string.
    DATA s3 TYPE string.
    DATA s4 TYPE string.

    SPLIT s1 AT `,` INTO s2 s3 s4. " s2 = Hallo / s3 = world / s4 = 123
    out->write( s1 ).
    " Less data objects than possible splittings
    SPLIT s1 AT `,` INTO s2 s3. " s2 = Hallo / s3 = world,123
    out->write( s2 ).
    out->write( s3 ).
    " Splitting into internal table
    DATA itab TYPE TABLE OF string.
    SPLIT s1 AT ',' INTO TABLE itab. " Strings are added to itab in individual lines without comma
    out->write( itab ).
    " RESULT
    " Hallo
    " world
    " 123
    " String function segment returning the occurrence of a segment
    " index parameter: number of segment
    s2 = segment( val   = s1
                  index = 2
                  sep   = `,` ). " world
    out->write( s2 ).

    " String functions
    DATA(s) = to_upper( `abap` ). " ABAP
    s = to_lower( `SOME_FILE.Txt` ). " some_file.txt

    " TRANSLATE statements
    s = `Hallo`.
    TRANSLATE s TO UPPER CASE. " HALLO
    TRANSLATE s TO LOWER CASE. " hallo

    " For the transformation of the source directly, you can
    " also specify an existing, changeable data object as
    " the source in a simple assignment as follows.
    s = to_upper( s ).
  ENDMETHOD.
ENDCLASS.
