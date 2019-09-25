tableextension 50009 "ODT SalesInvoiceLineExt" extends "Sales Invoice Line" //MyTargetTableId
{
  fields
  {
    field(50000;"ODT Employee No.";Code[20])
    {
      Caption = 'Employee No.';
      DataClassification = ToBeClassified;
      TableRelation = Resource where(Type=const(Person), Blocked=Const(FALSE));
    }
  }
}
