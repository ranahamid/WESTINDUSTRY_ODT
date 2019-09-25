pageextension 50015 "ODT Sales Invoice Extension" extends "Sales Invoice"
{
  layout
  {
    addbefore("Currency Code")
    {
      field("ODT AFE";"ODT AFE")
      {
        Caption = 'AFE';
        ApplicationArea = All;
      }
      field("ODT Business Unit";"ODT Business Unit")
      {
        Caption = 'Business Unit';
        ApplicationArea = All;
      }
      field("ODT Cost Centre";"ODT Cost Centre")
      {
        Caption = 'Cost Centre';
        ApplicationArea = All;
      }
      field("ODT Client File";"ODT Client File")
      {
        Caption = 'Client File';
        ApplicationArea = All;
      }
      field("ODT GL";"ODT GL")
      {
        Caption = 'GL';
        ApplicationArea = All;
      }
      field("ODT Major";"ODT Major")
      {
        Caption = 'Major';
        ApplicationArea = All;
      }
      field("ODT Minor";"ODT Minor")
      {
        Caption = 'Minor';
        ApplicationArea = All;
      }
      field("ODT MSA";"ODT MSA")
      {
        Caption = 'MSA';
        ApplicationArea = All;
      }
      field("ODT MSO";"ODT MSO")
      {
        Caption = 'MSO';
        ApplicationArea = All;
      }
      // field("ODT Purchase Order"; "ODT Purchase Order")
      // {
      //     Caption = 'Purchase Order';
      //     ApplicationArea = All;
      // }
      field("ODT Service Order";"ODT Service Order")
      {
        Caption = 'Service Order';
        ApplicationArea = All;
      }
    }
  }
  actions
  {
  }
}
