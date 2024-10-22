CLASS z26_dynamic_programming_2 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_dynamic_programming_2 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " ---------------------------------------------------------------------

    "------------ Data reference variables ------------

    " Declaring data reference variables
    DATA ref1 TYPE REF TO i.
    DATA ref2 TYPE REF TO i.

    ref1 = NEW #( 789 ).

    " Assignments
    ref2 = ref1.

    " Casting

    " Complete type
    DATA(ref3) = NEW i( 321 ).

    " Generic type
    DATA ref4 TYPE REF TO data.

    " Upcast
    ref4 = ref3.

    " Downcasts
    DATA ref5 TYPE REF TO i.

    " Generic type
    DATA ref6 TYPE REF TO data.

    ref6 = NEW i( 654 ).
    ref5 = CAST #( ref6 ).
    "Result
    "ref6 = 654
    "ref5 = 654
    "Explanation
    "Conversion from type data to interger is call downcasting
    "we can convert data from generic into specific type data like I(interger)
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    " Casting operator in older syntax
    ref5 ?= ref6.
    " Note: The cast operators can also but need not be specified for upcasts.
    ref4 = CAST #( ref3 ).
  ENDMETHOD.
ENDCLASS.
