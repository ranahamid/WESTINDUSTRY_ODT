table 50002 "ODT Job LSD"
{
  DataClassification = ToBeClassified;
  DrillDownPageId = "ODT Job LSD List";
  LookupPageId = "ODT Job LSD List";

  fields
  {
    field(1;"Job No.";code[20])
    {
      Caption = 'Job No.';
      DataClassification = ToBeClassified;
    }
    field(3;"LSD Format Code";Code[50])
    {
      Caption = 'LSD Format Code';
      DataClassification = ToBeClassified;
    }
    field(2;"LSD Code";Code[50])
    {
      Caption = 'LSD Code';
      DataClassification = ToBeClassified;
      TableRelation = "ODT LSD"."LSD Code";
    }
    field(11;"Bottom Hole";Code[50])
    {
      Caption = 'Bottom Hole';
      Editable = false;
      //TableRelation = "ODT LSD"."Bottom Hole" Where ("LSD Format Code" = Field ("LSD Format Code"), "LSD Code" = Field ("LSD Code"));
      TableRelation = "ODT LSD"."LSD Code";
    }
    field(12;Start;Code[50])
    {
      Caption = 'Start';
      Editable = false;
      TableRelation = "ODT LSD"."LSD Code";
    }
    field(13;Path;Code[50])
    {
      Caption = 'Path';
      Editable = false;
      TableRelation = "ODT LSD"."LSD Code";
    }
    field(14;"ODT End";Code[50])
    {
      Caption = 'End';
      Editable = false;
      TableRelation = "ODT LSD"."LSD Code";
    }
    field(15;Surface;Code[50])
    {
      Caption = 'Surface';
      Editable = false;
      TableRelation = "ODT LSD"."LSD Code";
    }
  }
  keys
  {
    key(PK;"Job No.", "LSD Code", "LSD Format Code")
    {
      Clustered = true;
    }
  }
}
