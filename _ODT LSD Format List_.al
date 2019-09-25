page 50014 "ODT LSD Format List"
{
  PageType = List;
  SourceTable = "ODT LSD Format";
  Caption = 'LSD Format List';
  UsageCategory = Lists;
  ApplicationArea = All;
  AdditionalSearchTerms = 'field ticket, lsd';

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
        field(Format;Format)
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
