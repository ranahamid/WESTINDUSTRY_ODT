page 50016 "ODT Field Tickets"
{
  // version NB04.10,WI00.00
  // NB03.16 2016-06-13 ODTJR Addded new page to display Field Ticket List
  CardPageID = "ODT Field Ticket Job Mapping";
  Caption = 'Field Tickets';
  //Editable = false;
  InsertAllowed = false;
  PageType = List;
  UsageCategory = Lists;
  RefreshOnActivate = true;
  SourceTable = "ODT Field Ticket Job Mapping";
  ApplicationArea = All;

  layout
  {
    area(content)
    {
      repeater(Group)
      {
        field("Field Ticket No.";"Field Ticket No.")
        {
          ApplicationArea = All;
        }
        field("Field Ticket Date";"Field Ticket Date")
        {
          ApplicationArea = All;
        }
        field("Job No.";"Job No.")
        {
          ApplicationArea = All;
        }
        field("Bill-to Customer No.";"Bill-to Customer No.")
        {
          ApplicationArea = All;
          Visible = False;
        }
        field("Bill To Customer Name";"Bill To Customer Name")
        {
          ApplicationArea = All;
        }
        field("Project Manager";"Project Manager")
        {
          ApplicationArea = All;
        }
      }
    }
  }
  actions
  {
    area(navigation)
    {
    }
  }
}
