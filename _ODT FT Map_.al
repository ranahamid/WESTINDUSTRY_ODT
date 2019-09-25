page 50009 "ODT FT Map"
{
  // version NB03.75
  Caption = 'Map';
  PageType = CardPart;
  SourceTable = "ODT LSD Directions";

  layout
  {
    area(content)
    {
      group(Control1101754001)
      {
        field(Map;Map)
        {
          ApplicationArea = All;
          ShowMandatory = true;
        }
        field(UploadDirection;UploadDirection)
        {
          ApplicationArea = All;
          Caption = 'Click on Box to upload Map';
          Style = StandardAccent;
          StyleExpr = TRUE;
        }
      }
    }
  }
  actions
  {
  }
  var UploadDirection: Integer;
  procedure ShowDetails();
  begin
    PAGE.RUN(PAGE::"Item Card", Rec);
  end;
}
