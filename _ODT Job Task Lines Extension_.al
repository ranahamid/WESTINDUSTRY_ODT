pageextension 50007 "ODT Job Task Lines Extension" extends "Job Task Lines"
{
  layout
  {
    addafter("Job Task No.")
    {
      field("ODT Status";"ODT Status")
      {
        ApplicationArea = Location;
        ToolTip = 'Specifies Status.';
      }
      field("ODT Closed";"ODT Closed")
      {
        ApplicationArea = Location;
        ToolTip = 'Specifies Closed.';
      }
    }
  }
  actions
  {
  }
}
