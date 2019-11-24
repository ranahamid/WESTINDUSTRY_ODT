pageextension 50022 TimeSheetLinesExt extends "Time Sheet"
{
    layout
    {
    }
    actions
    {
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Type := Type::Job;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        Type := Type::Job;
    end;
}
