page 50017 "ODT Job Task Status List"
{
  PageType = List;
  SourceTable = "ODT Job Task Status";
  Caption = 'Job Task Status List';
  UsageCategory = Lists;
  ApplicationArea = All;
  Editable = TRUE;
  AdditionalSearchTerms = 'Status, Task';

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        field("Code";Code)
        {
          ApplicationArea = All;
        }
        field(Description;Description)
        {
          ApplicationArea = All;
        }
        field(Closed;Closed)
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
