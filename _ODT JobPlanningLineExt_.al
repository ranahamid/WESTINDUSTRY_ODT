tableextension 50007 "ODT JobPlanningLineExt" extends "Job Planning Line" //MyTargetTableId
{
    fields
    {
        field(50000; "ODT Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            TableRelation = Resource where(Type = const(Person), Blocked = Const(FALSE));
        }
        field(50001; "ODT Field Ticket No."; Code[20])
        {
            Description = 'NB05.38';
            Editable = false;
        }
        field(50002; "ODT Field Ticket Line No."; Integer)
        {
            Caption = 'Field Ticket Line No.';
            Description = 'NB03.58';
        }

        field(50117; "Project Manager"; Code[50])
        {
            // Set links to the "Reward ID" from the Reward table.
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            // Set whether to validate a table relationship.
            ValidateTableRelation = true;
            Editable = false;
        }
        field(50118; "Employee"; Code[50])
        {
            // Set links to the "Reward ID" from the Reward table.
            DataClassification = ToBeClassified;
            TableRelation = Resource."No.";
            // Set whether to validate a table relationship.
            ValidateTableRelation = true;
        }
    }
    trigger OnAfterInsert()
    var
        vJob: Record "Job";
    begin
        vJob.Get(Rec."Job No.");
        //Rec.
        //Message('on insert project manager ' + vJob."Project Manager");
        Rec."Project Manager" := vJob."Project Manager";
        Rec.Modify;
    end;
}
