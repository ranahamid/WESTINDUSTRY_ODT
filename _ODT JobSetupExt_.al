tableextension 50004 "ODT JobSetupExt" extends "Jobs Setup" //MyTargetTableId
{
  fields
  {
    field(50000;"ODT Field Ticket Batch";Code[20])
    {
      Caption = 'Field Ticket Batch';
      DataClassification = ToBeClassified;
      TableRelation = "Job Journal Batch".Name;
    }
    field(50001;"ODT Field Ticket Nos.";Code[20])
    {
      Caption = 'Field Ticket Nos.';
      DataClassification = ToBeClassified;
      TableRelation = "No. Series";
    }
  }
}
