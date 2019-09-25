tableextension 50007 "ODT JobPlanningLineExt" extends "Job Planning Line" //MyTargetTableId
{
  fields
  {
    field(50000;"ODT Employee No.";Code[20])
    {
      Caption = 'Employee No.';
      DataClassification = ToBeClassified;
      TableRelation = Resource where(Type=const(Person), Blocked=Const(FALSE));
    }
    field(50001;"ODT Field Ticket No.";Code[20])
    {
      Description = 'NB05.38';
      Editable = false;
    }
    field(50002;"ODT Field Ticket Line No.";Integer)
    {
      Caption = 'Field Ticket Line No.';
      Description = 'NB03.58';
    }
  }
}
