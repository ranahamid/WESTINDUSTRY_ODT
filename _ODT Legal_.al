table 50009 "ODT Legal"
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
      OptionMembers = " ", " Surface", "Bottom Hole", "Start", "End", "Path", "Other";
    }
    field(30;"ODT Area";Code[10])
    {
      Caption = 'Area';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
    }
    field(31;"LSD";Code[2])
    {
      Caption = 'LSD';
    }
    field(40;Block;Code[10])
    {
      Caption = 'Block';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
    }
    field(41;Section;Integer)
    {
      Caption = 'Section';
    }
    field(50;"1/4 Unit";Code[10])
    {
      Caption = 'Block';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
    }
    field(51;"Township";Integer)
    {
      Caption = 'Township';
    }
    field(60;Series;Integer)
    {
      Caption = 'Series';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
    }
    field(61;Range;Integer)
    {
      Caption = 'Range';
    }
    field(70;Sheet;Integer)
    {
      Caption = 'Sheet';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
    }
    field(71;Meridian;Integer)
    {
      Caption = 'Meridian';
    }
    field(80;Unit;Code[10])
    {
      Caption = 'Unit';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
    }
  }
  keys
  {
    key(PK1;"Job No.", "Location Type", "ODT Area", Block, "1/4 Unit", Series, Sheet, Unit)
    {
      ObsoleteState = Removed;
      ObsoleteReason = 'New fields';
    }
    key(PK;"Job No.", "Location Type", LSD, Section, Township, Range, Meridian)
    {
    }
  }
}
