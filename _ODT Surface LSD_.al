page 50005 "ODT Surface LSD"
{
  // version NB03.75,WI00.00
  CardPageID = "ODT LSD Card";
  Editable = false;
  InsertAllowed = false;
  ModifyAllowed = false;
  PageType = List;
  SourceTable = "ODT LSD";
  SourceTableView = WHERE(Type=CONST(Surface));

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
}
