@EndUserText.label: 'Company Code Data'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_CUST_TAB'
@UI: { headerInfo: {
        typeName: 'Company Code',
        typeNamePlural: 'Company Codes' ,
        title: { type: #STANDARD, value: 'company_code', criticality: 'open_post' },
        description: { value: 'name' }
        } }
define root custom entity ZD_CUST_TAB
{

      @UI.facet    : [
        {
            label  : 'Details',
            id     : 'parent',
            purpose: #STANDARD,
            type   : #COLLECTION,
            position: 10
        },
        {
            id     : 'child',
            type   : #IDENTIFICATION_REFERENCE,
            purpose: #STANDARD,
            parentId: 'parent',
            position: 10
      } ]


      @UI.lineItem : [{ position: 10, criticality: 'open_post' }]
      @EndUserText.label        : 'Company Code'
  key company_code : bukrs;

      @UI.lineItem : [{ position: 20 }]
      @EndUserText.label        : 'CC Name'
      @UI.selectionField: [{ position: 10 }]
      name         : abap.char( 25 );

      @UI.lineItem : [{ position: 30 }]
      @EndUserText.label        : 'City'
      @UI.identification: [{ position: 10 }]
      city         : abap.char( 25 );

      @UI.lineItem : [{ position: 40 }]
      @EndUserText.label        : 'Country'
      @UI.identification: [{ position: 20 }]
      country      : abap.char( 3 );

      open_post    : abap.int1;

}
