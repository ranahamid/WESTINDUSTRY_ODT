pageextension 50000 "ODT Jobs Setup Extension" extends "Jobs Setup"
{
  layout
  {
    addafter("Job Nos.")
    {
      field("ODT Field Ticket Nos.";"ODT Field Ticket Nos.")
      {
        ApplicationArea = Location;
        ToolTip = 'Specifies Field Ticket Nos.';
      }
    }
  }
  actions
  {
  }
}
