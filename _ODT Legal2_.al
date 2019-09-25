table 50011 "ODT Legal2"
{
  Caption = 'Legal';
  DrillDownPageId = "ODT Legal List";
  LookupPageId = "ODT Legal List";
  DataCaptionFields = "Job No.", "Location Type", "LSD";

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
    field(31;"LSD";Code[2])
    {
      Caption = 'LSD';
    }
    field(41;Section;Integer)
    {
      Caption = 'Section';
    }
    field(51;"Township";Integer)
    {
      Caption = 'Township';
    }
    field(61;Range;Integer)
    {
      Caption = 'Range';
    }
    field(71;Meridian;Integer)
    {
      Caption = 'Meridian';
    }
  }
  keys
  {
    key(PK;"Job No.", "Location Type", LSD, Section, Township, Range, Meridian)
    {
    }
  }
}
