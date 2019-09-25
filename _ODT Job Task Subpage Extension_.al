pageextension 50006 "ODT Job Task Subpage Extension" extends "Job Task Lines Subform"
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
      field("ODT Line Type";"ODT Line Type")
      {
        ApplicationArea = Location;
        ToolTip = 'Specifies Closed.';
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
