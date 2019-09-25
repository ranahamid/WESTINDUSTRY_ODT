pageextension 50003 "ODT Job Task Card Extension" extends "Job Task Card"
{
  layout
  {
    addafter("No. of Blank Lines")
    {
      field("ODT Line Type";"ODT Line Type")
      {
        ToolTip = 'Specifies Line Type';
        ApplicationArea = All;
      }
      field("ODT Status";"ODT Status")
      {
        ApplicationArea = Location;
        ToolTip = 'Specifies the Status of the Job Task.';
      }
      field("ODT Closed";"ODT Closed")
      {
        ApplicationArea = Location;
        ToolTip = 'Specifies if Job Task is closed.';
      }
    }
  }
  actions
  {
  }
}
