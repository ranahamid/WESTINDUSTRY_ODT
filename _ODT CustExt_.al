tableextension 50003 "ODT CustExt" extends "Customer" //MyTargetTableId
{
  fields
  {
    field(50030;"ODT FT Approval Required";Boolean)
    {
      Caption = 'Field Ticket Approval Required';
      DataClassification = ToBeClassified;
    }
  }
}
