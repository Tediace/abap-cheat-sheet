CLASS z26_string DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA s1 TYPE string.
    DATA s2 TYPE string.

    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS z26_string IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " Defining the format of a date
    " The output is just an example and depends on your settings.
    DATA(d) = |The date is { cl_abap_context_info=>get_system_date( ) DATE = USER }.|. " The date is 01/01/2024. format MM/DD/YYYY
    d = |{ cl_abap_context_info=>get_system_date( ) DATE = RAW }|. " 20240101 format YYYYMMDD
    d = |{ cl_abap_context_info=>get_system_date( ) DATE = ISO }|. " 2024-01-01 format YYYY/MM/DD
    d = |{ cl_abap_context_info=>get_system_date( ) DATE = ENVIRONMENT }|. " 01/01/2024 format MM/DD/YYYY
    out->write( d ).

    "---------------------- TIME ----------------------
    " Defining the format of a time
    " The output is just an example and depends on your settings.
    DATA(tm) = |The time is { cl_abap_context_info=>get_system_time( ) TIME = ISO }.|. " The time is 14:37:24. format dd:mm:ss
    tm = |{ cl_abap_context_info=>get_system_time( ) TIME = RAW }|. " 143724 format ddmmss
    tm = |{ cl_abap_context_info=>get_system_time( ) TIME = USER }|. " 14:37:24 format dd:mm:ss
    tm = |{ cl_abap_context_info=>get_system_time( ) TIME = ENVIRONMENT }|. " 14:37:24 format dd:mm:ss
    out->write( tm ).

    "---------------------- TIMESTAMP ----------------------
    " Defining the format of a time stamp
    " The output is just an example and depends on your settings.
    DATA(ts) = |{ utclong_current( ) TIMESTAMP = SPACE }|. " 2024-01-01 14:39:50.4069170
    ts = |{ utclong_current( ) TIMESTAMP = ISO }|. " 2024-01-01T14:39:50,4071110
    ts = |{ utclong_current( ) TIMESTAMP = USER }|. " 01/01/2024 14:39:50.4072010R
    ts = |{ utclong_current( ) TIMESTAMP = ENVIRONMENT }|. " 01/01/2024 14:39:50.4073230
    ts = |{ utclong_current( ) }|. " 2024-01-01 14:39:50.4074060
    out->write( ts ).

    "---------------------- TIMEZONE ----------------------
    " Defining the format of a time stamp using the rules for time zones
    DATA(tz) = |{ utclong_current( ) TIMEZONE = 'UTC' }|. " 2024-12-30 14:43:20.6534640
    tz = |{ utclong_current( ) TIMEZONE = 'CET' COUNTRY = 'DE ' }|. " 30.12.2024 15:43:20,6536320
    tz = |{ utclong_current( ) TIMEZONE = 'EST' COUNTRY = 'US ' }|. " 12/30/2024 09:43:20.6889180 AM
    out->write( tz ).

    "---------------------- CASE ----------------------
    " Lowercase and uppercase
    s1 = |AbCdEfG|.
    s2 = |{ s1 CASE = LOWER }|. " abcdefg
    s2 = |{ s1 CASE = UPPER }|. " ABCDEFG
    out->write( s2 ).

    "---------------------- WIDTH/ALIGN ----------------------
    s1 = `##`.
    s2 = |{ s1 WIDTH = 10 ALIGN = LEFT }<---|.   "'##        <---'
    s2 = |{ s1 WIDTH = 10 ALIGN = CENTER }<---|. "'    ##    <---'
    out->write( s2 ).

    "---------------------- PAD ----------------------
    " Used to pad any surplus places in the result with the specified character.
    s2 = |{ s1 WIDTH = 10 ALIGN = RIGHT PAD = `.` }<---|. "'........##<---'
    out->write( s2 ).

    "---------------------- DECIMALS ----------------------
    s1 = |{ CONV decfloat34( - 1 / 3 ) DECIMALS = 3 }|. "'-0.333'
    out->write( s1 ).

    "---------------------- SIGN ----------------------
    " Defining the format of the +/- sign when the string represented
    " by the embedded expression represents a numeric value
    "- left without space, no +
    s1 = |{ +1 SIGN = LEFT }|. " 1
    "- and + left without space
    s1 = |{ 1 SIGN = LEFTPLUS }|. "+1
    "- left without space, blank left for +
    s1 = |{ 1 SIGN = LEFTSPACE }|. " 1
    "- right without space, no +
    s1 = |{ -1 SIGN = RIGHT }|. " 1-
    "- and + right without space
    s1 = |{ 1 SIGN = RIGHTPLUS }|. " 1+
    "- left without space, blank right for +
    s1 = |{ +1 SIGN = RIGHTSPACE }|. " 1
    out->write( s1 ).

    "---------------------- ZERO ----------------------
    " Defining the format of the numeric value zero.
    " Only to be specified if the embedded expression has a numeric data type.
    s1 = |'{ 0 ZERO = NO }' and '{ 0 ZERO = YES }'|. "'' and '0'
    out->write( s1 ).

    "---------------------- XSD ----------------------
    " Formatting is applied to an embedded expression (elementary data types) in asXML format that is
    " assigned to its data type. Check the information in the ABAP Keyword Documentation about the asXML
    " mapping of elementary ABAP types.
    DATA xstr TYPE xstring VALUE `41424150`.
    DATA dat  TYPE d       VALUE '20240101'.
    DATA tim  TYPE t       VALUE '123456'.
    DATA(utc) = utclong_current( ). " e.g. 2024-01-01 13:51:38.5708800

    s1 = |{ xstr XSD = YES }|. " QUJBUA==
    s1 = |{ dat XSD = YES }|. " 2024-01-01
    s1 = |{ tim XSD = YES }|. " 12:34:56
    s1 = |{ utc XSD = YES }|. " 2024-01-01T13:51:38.57088Z
    out->write( s1 ).

    "---------------------- STYLE ----------------------
    " Defining the style of decimal floating point numbers;
    " see the details in the ABAP Keyword Documentation.
    DATA(dcfl34) = CONV decfloat34( '-123.45600' ).
    s1 = |{ dcfl34 }|. "-123.456
    " Creates the predefined format
    s1 = |{ dcfl34 STYLE = SIMPLE }|. "-123.456
    "+/- added to the right, removes trailing zeros
    s1 = |{ dcfl34 STYLE = SIGN_AS_POSTFIX  }|. " 123.456-
    " Retains trailing zeros
    s1 = |{ dcfl34 STYLE = SCALE_PRESERVING }|. "-123.45600
    " Scientific notation; at least a two digit exponent with a plus/minus sign
    s1 = |{ dcfl34 STYLE = SCIENTIFIC }|. "-1.23456E+02
    " Scientific notation; only one integer digit with the value 0
    s1 = |{ dcfl34 STYLE = SCIENTIFIC_WITH_LEADING_ZERO }|. "-0.123456E+03
    " Scientific notation; exponent has 3 digits for decfloat16 and 4 digits for decfloat34
    s1 = |{ dcfl34 STYLE = SCALE_PRESERVING_SCIENTIFIC }|. "-1.2345600E+0002
    " Technical format
    s1 = |{ dcfl34 STYLE = ENGINEERING }|. "-123.456E+00
    out->write( s1 ).

    "---------------------- ALPHA ----------------------
    " Adds or removes leading zeros from strings of digits; the data type
    " must be string, c, or n
    " Adding leading zeros
    " Additionally specifying WIDTH
    " Note: The specified length is only used if it is greater than
    " the length of provided string (without leading zeros)
    s1 = |{ '1234' ALPHA = IN WIDTH = 10 }|. " 0000001234
    s1 = |{ '00000000000000000000000012' ALPHA = IN WIDTH = 10 }|. " 0000000012
    " Fixed-length string provided, WIDTH not specified
    s1 = |{ '   12' ALPHA = IN }|. " 00012
    " Removing leading zeros
    s1 = |{ '00001234' ALPHA = OUT }|. " 1234
    " Do not apply formatting
    s1 = |{ '00001234' ALPHA = RAW }|. " 00001234
    out->write( s1 ).
  ENDMETHOD.
ENDCLASS.
