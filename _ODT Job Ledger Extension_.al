pageextension 50010 "ODT Job Ledger Extension" extends "Job Ledger Entries"
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
