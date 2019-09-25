page 50007 "ODT LSD List"
{
  UsageCategory = Lists;
  Caption = 'LSD List';
  CardPageID = "ODT LSD Card";
  PageType = List;
  SourceTable = "ODT LSD";
  SourceTableView = SORTING("LSD Code")ORDER(Ascending);
  ApplicationArea = All;
  AdditionalSearchTerms = 'field ticket';

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        // field("LSD Format Code"; "LSD Format Code")
        // {
        //     ApplicationArea = All;
        // }
        field("LSD Code";"LSD Code")
        {
          Caption = 'LSD Code';
          ApplicationArea = All;
        }
        field("Surface LSD";"Surface LSD")
        {
          Caption = 'Surface LSD';
          ApplicationArea = All;
        }
      // field("Bottom Hole"; "Bottom Hole")
      // {
      //     Caption = 'Bottom Hole';
      //     ApplicationArea = All;
      // }
      // field(Start; Start)
      // {
      //     Caption = 'Start';
      //     ApplicationArea = All;
      // }
      // field(Path; Path)
      // {
      //     Caption = 'Path';
      //     ApplicationArea = All;
      // }
      // field("ODT End"; "ODT End")
      // {
      //     Caption = 'End';
      //     ApplicationArea = All;
      // }
      // field("SUR Dispatch Requests";"SUR Dispatch Requests")
      // {
      //     Caption = 'Used as Surface';
      //     DrillDownPageID = 50310;
      // }
      // field("DH Dispatch Requests";"DH Dispatch Requests")
      // {
      //     Caption = 'Used as Downhole';
      // }
      // field("Used as Load LSD";"Used as Load LSD")
      // {
      // }
      // field("Used as Delivery LSD";"Used as Delivery LSD")
      // {
      // }
      // field("Used as Charge LSD";"Used as Charge LSD")
      // {
      // }
      }
    }
  }
  actions
  {
  }
  trigger OnNewRecord(BelowxRec: Boolean);
  begin
    "Surface LSD Format":=lLSDFormat;
    "Surface LSD":=lLSDCode;
  end;
  var lLSDFormat: Code[10];
  lLSDCode: Code[50];
  procedure ReceiveLSDInfo(LSDFormat: Code[10];
  LSDCode: Code[50]);
  begin
    lLSDFormat:=LSDFormat;
    lLSDCode:=LSDCode;
  end;
}
