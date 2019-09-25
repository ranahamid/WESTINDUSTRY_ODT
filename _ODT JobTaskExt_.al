tableextension 50001 "ODT JobTaskExt" extends "Job Task" //MyTargetTableId
{
  fields
  {
    field(50000;"ODT Status";Code[20])
    {
      Caption = 'PM Status';
      DataClassification = ToBeClassified;
      TableRelation = "ODT Job Task Status".Code;

      trigger OnValidate();
      var JobStatus: Record "ODT Job Task Status";
      begin
        IF JobStatus.GET("ODT Status")then "ODT Closed":=JobStatus.Closed;
      end;
    }
    field(50001;"ODT Closed";boolean)
    {
      Caption = 'Closed';
      DataClassification = ToBeClassified;
      editable = FALSE;
    }
    field(50003;"ODT Line Type";Option)
    {
      Caption = 'Line Type';
      Description = 'JobJnl';
      OptionCaption = ' ,Budget,Billable,Both Budget and Billable';
      OptionMembers = " ", Budget, Billable, "Both Budget and Billable";

      trigger OnValidate();
      begin
      //IF "Job Planning Line No." <> 0 THEN
      //  ERROR(Text006,FIELDCAPTION("Line Type"),FIELDCAPTION("Job Planning Line No."));
      end;
    }
  }
}
