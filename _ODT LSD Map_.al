page 50011 "ODT LSD Map"
{
  // version NB03.75,WI00.00
  PageType = Card;
  SourceTable = "ODT LSD Directions";

  layout
  {
    area(content)
    {
      group(General)
      {
        field(Map;Map)
        {
          ApplicationArea = All;
          ShowMandatory = true;
        }
      }
    }
  }
  actions
  {
  }
  trigger OnOpenPage();
  begin
    CurrPage.EDITABLE:=true;
  end;
}
