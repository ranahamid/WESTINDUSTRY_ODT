tableextension 50001 "ODT JobTaskExt" extends "Job Task" //MyTargetTableId
{
    fields
    {
        field(50116; "Project Manager"; Code[50])
        {
            // Set links to the "Reward ID" from the Reward table.
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
            // Set whether to validate a table relationship.
            ValidateTableRelation = true;
            Editable = false;
        }
        field(50000; "ODT Status"; Code[20])
        {
            Caption = 'PM Status';
            DataClassification = ToBeClassified;
            TableRelation = "ODT Job Task Status".Code;

            trigger OnValidate();
            var
                JobStatus: Record "ODT Job Task Status";
            begin
                IF JobStatus.GET("ODT Status") then "ODT Closed" := JobStatus.Closed;
            end;
        }
        field(50001; "ODT Closed"; boolean)
        {
            Caption = 'Closed';
            DataClassification = ToBeClassified;
            editable = FALSE;
        }
        field(50003; "ODT Line Type"; Option)
        {
            Caption = 'Line Type';
            Description = 'JobJnl';
            OptionCaption = ' ,Budget,Billable,Both Budget and Billable';
            OptionMembers = " ",Budget,Billable,"Both Budget and Billable";

            trigger OnValidate();
            begin
                //IF "Job Planning Line No." <> 0 THEN
                //  ERROR(Text006,FIELDCAPTION("Line Type"),FIELDCAPTION("Job Planning Line No."));
            end;
        }
    }
    trigger OnAfterInsert()
    var
        vJob: Record "Job";
    begin
        vJob.Get(Rec."Job No.");
        //Message('on insert project manager ' + vJob."Project Manager");
        Rec."Project Manager" := vJob."Project Manager";
        Rec.Modify;
    end;
}
