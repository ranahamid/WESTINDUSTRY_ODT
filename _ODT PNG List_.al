page 50020 "ODT PNG List"
{
  Caption = 'PNG List';
  ApplicationArea = All;
  UsageCategory = Lists;
  RefreshOnActivate = true;
  SourceTable = "ODT PNG2";
  PageType = List;

  layout
  {
    area(Content)
    {
      repeater(Groupr)
      {
        field("Job No.";"Job No.")
        {
          ApplicationArea = All;
        }
        field("Location Type";"Location Type")
        {
          ApplicationArea = All;
        }
        field("ODT Area Code";"ODT Area Code")
        {
          ApplicationArea = All;
        }
        field("ODT Block";"ODT Block")
        {
          ApplicationArea = All;
        }
        field("ODT 1/4 Unit";"ODT 1/4 Unit")
        {
          ApplicationArea = All;
        }
        field(Series;Series)
        {
          ApplicationArea = All;
        }
        field(Sheet;Sheet)
        {
          ApplicationArea = All;
        }
        field("ODT Unit";"ODT Unit")
        {
          ApplicationArea = All;
        }
      }
    }
  }
}
