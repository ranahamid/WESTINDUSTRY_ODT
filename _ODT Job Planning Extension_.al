pageextension 50009 "ODT Job Planning Extension" extends "Job Planning Lines"
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
      field("ODT Field Ticket No.";"ODT Field Ticket No.")
      {
        ApplicationArea = All;
        ToolTip = 'Specifies Field Ticket No.';
      }
      field("ODT Field Ticket Line No.";"ODT Field Ticket Line No.")
      {
        ApplicationArea = All;
        ToolTip = 'Specifies Field Ticket Line No.';
      }
    }
  }
  actions
  {
  }
}
