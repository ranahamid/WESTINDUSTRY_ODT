table 50012 "ODT PNG2"
{
  fields
  {
    field(10;"Job No.";Code[20])
    {
      Caption = 'Job No.';
      TableRelation = Job;
    }
    field(20;"Location Type";Option)
    {
      Caption = 'Location Type';
      OptionMembers = " ", "Surface", "Bottom Hole", "Start", "End", "Path", "Other";
    }
    field(31;"ODT Area Code";Code[1])
    {
      Caption = 'Area';
    }
    field(41;"ODT Block";Code[1])
    {
      Caption = 'Block';
    }
    field(51;"ODT 1/4 Unit";Code[1])
    {
      Caption = '1/4 Unit';
    }
    field(60;Series;Integer)
    {
      Caption = 'Series';
    }
    field(70;Sheet;Integer)
    {
      Caption = 'Sheet';
    }
    field(81;"ODT Unit";Integer)
    {
      Caption = 'Unit';
    }
  }
  keys
  {
    key(PK;"Job No.", "Location Type", "ODT Area Code", "ODT Block", "ODT 1/4 Unit", Series, Sheet, "ODT Unit")
    {
    }
  }
}
