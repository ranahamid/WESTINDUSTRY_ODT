tableextension 50010 "ODT Job Cue" extends "Job Cue"
{
  fields
  {
    field(50000;"ODT Open Jobs";Integer)
    {
      Caption = 'Open Jobs';
      FieldClass = FlowField;
      CalcFormula = count(Job where(Status=const(Open), "Project Manager"=field("User ID Filter")));
    }
    field(50001;"ODT Completed Jobs";Integer)
    {
      Caption = 'Completed Jobs';
      FieldClass = FlowField;
      CalcFormula = count(Job where(Status=const(Completed), "Project Manager"=field("User ID Filter")));
    }
  }
}
