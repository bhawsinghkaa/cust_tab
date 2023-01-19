/********** GENERATED on 09/16/2022 at 08:09:28 by CB0000000012**************/
@OData.entitySet.name: 'ZCUST_DDL2'
@OData.entityType.name: 'ZCUST_DDL2Type'
define root abstract entity ZZCUST_DDL2
{
  key company_code : abap.char( 4 );
      @OData.property.valueControl: 'name_vc'
      name         : abap.char( 25 );
      name_vc      : rap_cp_odata_value_control;
      @OData.property.valueControl: 'city_vc'
      city         : abap.char( 25 );
      city_vc      : rap_cp_odata_value_control;
      @OData.property.valueControl: 'country_vc'
      country      : abap.char( 3 );
      country_vc   : rap_cp_odata_value_control;
      @OData.property.valueControl: 'open_post_vc'
      open_post    : abap.int1;
      open_post_vc : rap_cp_odata_value_control;
}
