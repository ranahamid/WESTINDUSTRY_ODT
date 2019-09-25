pageextension 50005 "ODT Job List Extension" extends "Job List"
{
  layout
  {
    modify(Control1)
    {
    FreezeColumn = Description;
    }
  }
  actions
  {
    addafter("Job Task &Lines")
    {
      action(ODTOpenFieldTicketList)
      {
        ApplicationArea = All;
        Caption = 'Field Tickets';
        Image = FiledOverview;
        RunObject = Page "ODT Field Tickets";
        RunPageLink = "Job No."=Field("No.");
      }
      action(ODTPostedFieldTicketList)
      {
        ApplicationArea = All;
        Caption = 'Posted Field Tickets';
        Image = FiledPosted;
        RunObject = Page "ODT Posted Field Tickets";
        RunPageLink = "Job No."=Field("No.");
      }
      action(LegalList)
      {
        ApplicationArea = All;
        Caption = 'Legal';
        Image = List;
        RunObject = Page "ODT Legal List";
        RunPageLink = "Job No."=Field("No.");
      }
      action(PNGList)
      {
        ApplicationArea = All;
        Caption = 'PNG';
        Image = List;
        RunObject = Page "ODT Legal List";
        RunPageLink = "Job No."=Field("No.");
      }
    }
  }
}
