page 50012 "ODT Downhole LSD"
{
  // version NB03.75,WI00.00
  CardPageID = "ODT LSD Card";
  Editable = true;
  PageType = List;
  SourceTable = "ODT LSD";
  SourceTableView = WHERE(Type=CONST(Downhole));

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        field("LSD Format Code";"LSD Format Code")
        {
          ApplicationArea = All;
        }
        field("LSD Code";"LSD Code")
        {
          ApplicationArea = All;
          Caption = 'Downhole LSD Code';
        }
        field("Surface LSD";"Surface LSD")
        {
          ApplicationArea = All;
          Editable = false;
        }
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
