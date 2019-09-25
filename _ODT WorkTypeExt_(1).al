pageextension 50004 "ODT WorkTypeExt" extends "Work Types" //MyTargetPageId
{
  layout
  {
    addlast(Control1)
    {
      field("Item No.";"ODT Item No.")
      {
        ApplicationArea = All;
      // FieldPropertyName = FieldPropertyValue;
      }
      field("Convert Res. to Item from Timesheet";"ODT Convert Res. to Item")
      {
        ApplicationArea = All;
      // FieldPropertyName = FieldPropertyValue;
      }
    }
  }
  actions
  {
  }
}
