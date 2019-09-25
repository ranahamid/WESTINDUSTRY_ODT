codeunit 50003 "ODT Upgrade Codeunit"
{
  Subtype = Upgrade;

  trigger OnRun()begin
  end;
  trigger OnValidateUpgradePerCompany()var x: Integer;
  begin
    x+=1;
  end;
}
