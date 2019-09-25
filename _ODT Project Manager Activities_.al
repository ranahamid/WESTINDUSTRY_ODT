pageextension 50014 "ODT Project Manager Activities" extends "Project Manager Activities"
{
  layout
  {
    addfirst("Work in Process")
    {
      field("ODT Open Jobs";"ODT Open Jobs")
      {
        ApplicationArea = All;
      }
      field("ODT Completed Jobs";"ODT Completed Jobs")
      {
        ApplicationArea = All;
      }
    }
  }
  actions
  {
  }
  trigger OnOpenPage()begin
    setfilter("User ID Filter", UserId);
  end;
}
