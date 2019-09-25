pageextension 50011 "ODT Sales Order Sub Extension" extends "Sales Order Subform"
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
