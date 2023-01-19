CLASS zcl_cust_tab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CUST_TAB IMPLEMENTATION.


  METHOD if_rap_query_provider~select.


    DATA:
      lt_output_data   TYPE TABLE OF zd_cust_tab,
      lt_business_data TYPE TABLE OF zzcust_ddl2,
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

        "Get the paging info
        DATA(lo_paging) = io_request->get_paging(  ).

        " Execute the request and retrieve the business data
        lo_request = lo_client_proxy->create_resource_for_entity_set( 'ZCUST_DDL2' )->create_request_for_read( ).
        lo_request->set_top( lo_paging->get_page_size(  ) ).
        lo_request->set_skip( lo_paging->get_offset(  ) ).

        " Get filter data
        DATA(lr_range_filter) = io_request->get_filter(  )->get_as_ranges( ).
        IF lr_range_filter IS NOT INITIAL.
          lo_request->set_filter(  lo_request->create_filter_factory(  )->create_by_range( iv_property_path = lr_range_filter[ 1 ]-name it_range = lr_range_filter[ 1 ]-range ) ).
        ENDIF.

        "Get the data from the response
        lo_response = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = lt_business_data ).
        io_response->set_data( lt_business_data ).
        io_response->set_total_number_of_records( lines( lt_business_data ) ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection


      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
