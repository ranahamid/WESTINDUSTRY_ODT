table 50008 "ODT Job Task Status"
{
  Caption = 'Job Task Status';
  DrillDownPageID = "ODT Job Task Status List";
  DataCaptionFields = Code;

  fields
  {
    field(1;Code;Code[20])
    {
      Caption = 'Code';

      trigger OnValidate();
      begin
        Description:=Code;
      end;
    }
    field(5;Description;Text[50])
    {
      Caption = 'Description';
    //TableRelation = Customer;
    }
    field(10;Closed;Boolean)
    {
      Caption = 'Closed';
    //TableRelation = Customer;
    }
  }
  keys
  {
    key(Key1;Code)
    {
    }
  }
  trigger OnInsert();
  var begin
  end;
  var
// RMSetup : Record Table23001315;
}
