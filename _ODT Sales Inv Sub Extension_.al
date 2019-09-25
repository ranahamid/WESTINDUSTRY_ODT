pageextension 50012 "ODT Sales Inv Sub Extension" extends "Sales Invoice Subform"
{
  layout
  {
    addafter(Description)
    {
      field("ODT Employee No.";"ODT Employee No.")
      {
        ApplicationArea = All;
        ToolTip = 'Specifies Employee No.';
      }
    }
  }
  actions
  {
  }
}
