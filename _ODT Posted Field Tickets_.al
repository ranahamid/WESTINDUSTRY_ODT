page 50002 "ODT Posted Field Tickets"
{
  // version NB04.10,WI00.00
  // NB03.16 2016-06-13 ODTJR Addded new page to display Field Ticket List
  Caption = 'Posted Field Tickets';
  CardPageID = "ODT Posted Field Ticket";
  Editable = false;
  DeleteAllowed = FALSE;
  InsertAllowed = false;
  PageType = List;
  UsageCategory = Lists;
  RefreshOnActivate = true;
  SourceTable = "ODT Posted Field Ticket";
  ApplicationArea = All;

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        field("Field Ticket No.";"Field Ticket No.")
        {
          ApplicationArea = All;
        }
        field("Field Ticket Date";"Field Ticket Date")
        {
          ApplicationArea = All;
        }
        // field("Dispatch ID";"Dispatch ID")
        // {
        // }
        field("AFE No.";"AFE No.")
        {
          ApplicationArea = All;
        }
        field("Job No.";"Job No.")
        {
          ApplicationArea = All;
        }
        field("Bill-to Customer No.";"Bill-to Customer No.")
        {
          ApplicationArea = All;
        }
        field("Bill To Customer Name";"Bill To Customer Name")
        {
          ApplicationArea = All;
        }
        field("SUR LSD Format";"SUR LSD Format")
        {
          ApplicationArea = All;
        }
        field("From SUR LSD";"From SUR LSD")
        {
          ApplicationArea = All;
        }
        field("To SUR LSD";"To SUR LSD")
        {
          ApplicationArea = All;
        }
        field("DH LSD Format";"DH LSD Format")
        {
          ApplicationArea = All;
        }
        field("From DH LSD";"From DH LSD")
        {
          ApplicationArea = All;
        }
        field("To DH LSD";"To DH LSD")
        {
          ApplicationArea = All;
        }
        field("Rig No.";"Rig No.")
        {
          ApplicationArea = All;
        }
        field("Reference Field Type";"Reference Field Type")
        {
          ApplicationArea = All;
        }
        field("Reference Field No.";"Reference Field No.")
        {
          ApplicationArea = All;
          Visible = false;
        }
        // field("Rental Order No."; "Rental Order No.")
        // {
        //     ApplicationArea = All;
        // }
        field("Document Type";"Document Type")
        {
          ApplicationArea = All;
        }
        field("Document No.";"Document No.")
        {
          ApplicationArea = All;
        }
      }
    }
  }
  actions
  {
    area(navigation)
    {
      action(Print)
      {
        ApplicationArea = All;
        Caption = 'Print';
        Ellipsis = true;
        Image = Print;
        Promoted = true;
        PromotedCategory = Process;
        PromotedIsBig = true;
        Visible = true;

        trigger OnAction();
        var FieldTicketRep: Report "ODT Posted Field Ticket";
        FieldTicketH: Record "ODT Posted Field Ticket";
        begin
          CurrPage.SETSELECTIONFILTER(FieldTicketH);
          REPORT.RUNMODAL(50001, TRUE, FALSE, FieldTicketH);
        end;
      }
    }
  }
}
