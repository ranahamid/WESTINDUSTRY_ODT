page 50018 "ODT Job LSD List"
{
  PageType = List;
  SourceTable = "ODT Job LSD";
  Caption = 'Job LSD List';
  UsageCategory = Lists;
  ApplicationArea = All;
  Editable = TRUE;

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        field("Job No.";"Job No.")
        {
          ApplicationArea = All;
          Visible = FALSE;
        }
        field("LSD Code";"LSD Code")
        {
          ApplicationArea = All;
        }
        // field("LSD Format Code"; "LSD Format Code")
        // {
        //     ApplicationArea = All;
        // }
        field(Surface;Surface)
        {
          ApplicationArea = All;
        }
        field("Bottom Hole";"Bottom Hole")
        {
          ApplicationArea = All;
        }
        field(Start;Start)
        {
          ApplicationArea = All;
        }
        field(Path;Path)
        {
          ApplicationArea = All;
        }
        field("ODT End";"ODT End")
        {
          ApplicationArea = All;
        }
      }
    }
  }
  actions
  {
  }
}
