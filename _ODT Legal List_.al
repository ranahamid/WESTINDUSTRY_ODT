page 50019 "ODT Legal List"
{
  Caption = 'Legal List';
  ApplicationArea = All;
  UsageCategory = Lists;
  RefreshOnActivate = true;
  SourceTable = "ODT Legal2";
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
        field("LSD";"LSD")
        {
          ApplicationArea = All;
        }
        field(Section;Section)
        {
          ApplicationArea = All;
        }
        field(Township;Township)
        {
          ApplicationArea = All;
        }
        field(Range;Range)
        {
          ApplicationArea = All;
        }
        field(Meridian;Meridian)
        {
          ApplicationArea = All;
        }
      }
    }
  }
}
