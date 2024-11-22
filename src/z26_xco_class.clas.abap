CLASS z26_xco_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z26_xco_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA c_string  TYPE string VALUE 'abap'.
    DATA ld_string TYPE string.
    CONSTANTS c_seperator   TYPE string  VALUE ` `.
    """""""""""""""""""""""""Lower/Upper"""""""""""""""""""""""""""""""""""""""""
    " Classic
    " ABAP
    TRANSLATE c_string TO UPPER CASE.

    " Modern
    " ABAP
    ld_string = to_upper( c_string ).

    " XCO
    " ABAP
    ld_string = xco_cp=>string( c_string )->to_upper_case( )->value.

    """""""""""""""""""""""""Substring"""""""""""""""""""""""""""""""""""""""""
    " Classic
    " BAP
    ld_string = c_string+1(3).

    " Modern
    "BAP
    ld_string = substring( val = c_string off = 1 len = 3 ).

    " XCO
    " BAP
    ld_string = xco_cp=>string( c_string )->from( 2 )->to( 3 )->value.

    """""""""""""""""""""""""_Split"""""""""""""""""""""""""""""""""""""""""
    " Classic
    SPLIT c_string AT c_seperator INTO TABLE DATA(lt_parts).

    " Modern

    " XCO
    lt_parts = xco_cp=>string( c_string )->split( c_seperator )->value.

    " Upon execution, LV_HASH_VALUE will have the value C79C561BB2CC3D0430A54B3D014C89C3089FE089.
    DATA(lv_hash_value) = xco_cp=>string( 'MY_STRING'
      )->as_xstring( xco_cp_hash=>algorithm->sha_1
      )->value.

    out->write( lv_hash_value ).
    """"""""""""""""""""""""""""References""""""""""""""""""""""""""""""""""""""
    "https://software-heroes.com/en/blog/abap-xco-strings-en
    "https://help.sap.com/docs/btp/sap-business-technology-platform/string
  ENDMETHOD.
ENDCLASS.
