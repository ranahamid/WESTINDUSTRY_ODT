pageextension 50008 "ODT Job Journal Line Extension" extends "Job Journal"
{
  layout
  {
    addafter("No.")
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
