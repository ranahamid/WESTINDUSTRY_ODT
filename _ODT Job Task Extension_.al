pageextension 50002 "ODT Job Task Extension" extends "Job Task List"
{
  layout
  {
    addafter("Job Posting Group")
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
