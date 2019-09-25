table 50010 "ODT PNG"
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
      OptionMembers = " ", " Surface", "Bottom Hole", "Start", "End", "Path", "Other";
    }
    field(30;"ODT Area";Code[10])
    {
      Caption = 'Area';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
    }
    field(31;"ODT Area Code";Code[1])
    {
      Caption = 'Area';
    }
    field(40;Block;Code[10])
    {
      Caption = 'Block';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
    }
    field(41;"ODT Block";Code[1])
    {
      Caption = 'Block';
    }
    field(50;"1/4 Unit";Code[10])
    {
      Caption = 'Block';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
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
    field(80;Unit;Code[10])
    {
      Caption = 'Unit';
      ObsoleteState = Removed;
      ObsoleteReason = 'Moved field';
    }
    field(81;"ODT Unit";Integer)
    {
      Caption = 'Unit';
    }
  }
  keys
  {
    key(PK1;"Job No.", "Location Type", "ODT Area", Block, "1/4 Unit", Series, Sheet, Unit)
    {
      ObsoleteState = Removed;
      ObsoleteReason = 'Changed fields';
    }
    key(PK;"Job No.", "Location Type", "ODT Area Code", "ODT Block", "ODT 1/4 Unit", Series, Sheet, "ODT Unit")
    {
    }
  }
}
