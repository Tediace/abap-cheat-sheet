CLASS z26_internal_table DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_internal_table IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(str_table) = VALUE string_table( ( `aZbzZ` ) ( `cdZze` ) ( `Zzzf` ) ( `ghz` ) ).

    FIND ALL OCCURRENCES OF `Z`
         IN TABLE str_table
         RESULTS DATA(res_tab)
         RESPECTING CASE.

    out->write( res_tab ).

    FIND FIRST OCCURRENCE OF `Z`
         IN TABLE str_table
         RESULTS DATA(res_struc)
         RESPECTING CASE.

    out->write( res_struc ).

    FIND FIRST OCCURRENCE OF `Z`
         IN TABLE str_table
         MATCH LINE DATA(line)    " 1
         MATCH OFFSET DATA(off)   " 1
         MATCH LENGTH DATA(len)   " 1
         RESPECTING CASE.

    DATA(lv_string) = line && off && len.
    out->write( lv_string ).

    " Replacement in internal tables with REPLACE ... IN TABLE

    DATA(str_table_original) = VALUE string_table( ( `aZbzZ` ) ( `cdZze` ) ( `Zzzf` ) ( `ghz` ) ).
    DATA(str_table_2) = str_table_original.

    REPLACE ALL OCCURRENCES OF `Z`
            IN TABLE str_table_2
            WITH `#`
            RESULTS DATA(res_table)
            RESPECTING CASE.

    out->write( res_table ).
    out->write( str_table_2 ).

    str_table = str_table_original.

    REPLACE FIRST OCCURRENCE OF `Z`
            IN TABLE str_table
            WITH `#`
            RESULTS DATA(res_structure)
            RESPECTING CASE.

    out->write( str_table ).
    out->write( res_structure ).

    out->write( repeat( val = `-`
                        occ = 70 ) ).
    " result - do 70  times

    DATA(percentage) = 10 / 10 * 100.
    out->write(
        |In the test runs of this example, the fastest read access with the secondary table key takes approximately | &&
|{ percentage DECIMALS = 2 }% of the time it takes for the fastest read using a free key.| ).
  ENDMETHOD.
ENDCLASS.
