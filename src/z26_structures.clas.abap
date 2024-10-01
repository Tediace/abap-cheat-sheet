CLASS z26_structures DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_structures IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF addr_struc,
             name   TYPE string,
             street TYPE string,
             city   TYPE string,
           END OF addr_struc.
    " Creating a data reference variable
    DATA addr_ref1 TYPE REF TO addr_struc.

    " Populating the anonymous structure
    addr_ref1 = NEW #( name   = `Mr. Duncan Pea`
                       street = `Vegetable Lane 11`
                       city   = `349875 Botanica` ).

    addr_ref1->name = `Mrs. Jane Doe`.

    " Declaring an anonymous structure/a data reference variable inline
    DATA(addr_ref2) = NEW addr_struc( name   = `Mr. Duncan Pea`
                                      street = `Vegetable Lane 11`
                                      city   = `349875 Botanica` ).

    addr_ref2->* = VALUE #( BASE addr_ref2->*
                            name = `Mr. John Doe` ).

    out->write( addr_ref2 ).
    """""""""""""""""""""""""""Result"""""""""""""""""""""""""""""""""""""""
    "NAME            STREET               CITY
    "Mr. John Doe    Vegetable Lane 11    349875 Botanica
  ENDMETHOD.
ENDCLASS.
