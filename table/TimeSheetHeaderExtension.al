tableextension 50024 TimeSheetHeaderExtension extends "Time Sheet Line"
{
    fields
    {
    }
    trigger OnBeforeInsert();
    begin
        Type := Type::Job;
    end;
}
