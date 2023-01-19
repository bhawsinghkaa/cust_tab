CLASS zcl_test_conn DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_CONN IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    DATA:
      lt_business_data TYPE TABLE OF zZCUST_DDL2,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read_list,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read_lst.

    TRY.

        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination(
                         cl_http_destination_provider=>create_by_cloud_destination(
                         i_name = 'opnscpportal'
                         i_authn_mode = if_a4c_cp_service=>service_specific ) ).

        lo_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
            iv_service_definition_name = 'ZA_CUST_TAB'
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/ZCUST_DDL2_CDS' ).

        " ls_entity_key = VALUE #(
        "          company_code  = 'CompanyCode' ).

        " Navigate to the resource
        "lo_resource =  "->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZCUST_DDL2' )->create_request_for_read( ).
        lo_response = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).


      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection


      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
