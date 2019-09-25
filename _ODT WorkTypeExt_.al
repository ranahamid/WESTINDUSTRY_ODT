tableextension 50005 "ODT WorkTypeExt" extends "Work Type" //MyTargetTableId
{
  fields
  {
    field(50000;"ODT Item No.";Code[20])
    {
      Caption = 'Item No.';
      DataClassification = ToBeClassified;
      TableRelation = Item where(Type=const(Service));
    }
    field(50001;"ODT Convert Res. to Item";Boolean)
    {
      Caption = 'Convert Res. to Item from time sheet';
      DataClassification = ToBeClassified;
    }
  }
}
