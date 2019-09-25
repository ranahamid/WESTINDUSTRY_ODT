pageextension 50001 "ODT Job Card Extension" extends "Job Card"
{
  layout
  {
    addlast(General)
    //addafter("Bill-to Address 2")
    {
      field("ODT Date Received";"ODT Date Received")
      {
        ToolTip = 'Specifies Date Received';
        ApplicationArea = All;
      }
      field("Global Dimension 1 Code";"Global Dimension 1 Code")
      {
        ToolTip = 'Specifies Dimension';
        ApplicationArea = All;
      }
      field("ODT Shortcut Dimension 3 Code";"ODT Shortcut Dimension 3 Code")
      {
        ToolTip = 'Specifies Dimension';
        ApplicationArea = All;
      }
      field("ODT Field Rep No.";"ODT Field Rep No.")
      {
        ToolTip = 'Specifies Field Rep No.';
        ApplicationArea = All;
      }
      field("ODT Field Rep";"ODT Field Rep")
      {
        ToolTip = 'Specifies Field Rep';
        ApplicationArea = All;
      }
      field("ODT Main Contact No.";"ODT Main Contact No.")
      {
        ToolTip = 'Specifies Main Contact No.';
        ApplicationArea = All;
      }
      field("ODT Main Contact";"ODT Main Contact")
      {
        ToolTip = 'Specifies Main Contact"';
        ApplicationArea = All;
      }
      field("ODT Contact No.";"ODT Contact No.")
      {
        ToolTip = 'Specifies Main Contact No.';
        ApplicationArea = All;
      }
      field("ODT Contact";"ODT Contact")
      {
        ToolTip = 'Specifies Contact"';
        ApplicationArea = All;
      }
      field("ODT Project Instructions";"ODT Project Instructions")
      {
        ToolTip = 'Specifies Project Instructions';
        ApplicationArea = All;
        MultiLine = TRUE;
      }
    }
    addafter(General)
    {
      group(Billing)
      {
        field("ODT AFE";"ODT AFE")
        {
          ToolTip = 'Specifies AFE';
          ApplicationArea = All;
        }
        field("ODT Business Unit";"ODT Business Unit")
        {
          ToolTip = 'Specifies Business Unit';
          ApplicationArea = All;
        }
        field("ODT Cost Centre";"ODT Cost Centre")
        {
          ToolTip = 'Specifies Cost Centre';
          ApplicationArea = All;
        }
        field("ODT GL";"ODT GL")
        {
          ToolTip = 'Specifies GL';
          ApplicationArea = All;
        }
        field("ODT Major";"ODT Major")
        {
          ToolTip = 'Specifies Major';
          ApplicationArea = All;
        }
        field("ODT Minor";"ODT Minor")
        {
          ToolTip = 'Specifies Minor';
          ApplicationArea = All;
        }
        field("ODT MSA";"ODT MSA")
        {
          ToolTip = 'Specifies MSA';
          ApplicationArea = All;
        }
        field("ODT MSO";"ODT MSO")
        {
          ToolTip = 'Specifies MSO';
          ApplicationArea = All;
        }
        field("ODT Purchase Order";"ODT Purchase Order")
        {
          ToolTip = 'Specifies Purchase Order';
          ApplicationArea = All;
        }
        field("ODT Service Order";"ODT Service Order")
        {
          ToolTip = 'Specifies Service Order';
          ApplicationArea = All;
        }
        field("ODT Client File";"ODT Client File")
        {
          ToolTip = 'Specifies Client File';
          ApplicationArea = All;
          VISIBLE = FALSE;
        }
        field("ODT Contract No.";"ODT Contract No.")
        {
          ToolTip = 'Specifies Contract No.';
          ApplicationArea = All;
        }
        field("ODT Work Order";"ODT Work Order")
        {
          ToolTip = 'Specifies Work Order No.';
          ApplicationArea = All;
        }
        Field("ODT WBS";"ODT WBS")
        {
          ToolTip = 'Specifies WBS';
          ApplicationArea = All;
        }
      }
    }
  }
  actions
  {
    addbefore("&Dimensions")
    {
      action(ODTOpenFieldTicketList)
      {
        ApplicationArea = All;
        Caption = 'Field Tickets';
        Image = FiledOverview;
        RunObject = Page "ODT Field Tickets";
        RunPageLink = "Job No."=Field("No.");
        Promoted = TRUE;
        PromotedIsBig = TRUE;
        PromotedCategory = Category7;
      }
      action(ODTPostedFieldTicketList)
      {
        ApplicationArea = All;
        Caption = 'Posted Field Tickets';
        Image = FiledPosted;
        RunObject = Page "ODT Posted Field Tickets";
        RunPageLink = "Job No."=Field("No.");
        Promoted = TRUE;
        PromotedIsBig = TRUE;
        PromotedCategory = Category7;
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
        RunObject = Page "ODT PNG List";
        RunPageLink = "Job No."=Field("No.");
      }
    }
  }
}
