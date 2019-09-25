pageextension 50013 "ODT PostedSalesInv SubExt" extends "Posted Sales Invoice Subform"
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
