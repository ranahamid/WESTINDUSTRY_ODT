codeunit 50001 "ODT General Events"
{
  trigger OnRun()begin
  //Tony
  end;
  [EventSubscriber(ObjectType::Table, Database::"Job Journal Line", 'OnAfterValidateEvent', 'Job Task No.', False, False)]
  local procedure OnAfterValidateEventJobJnlLineType(var Rec: Record "Job Journal Line";
  var xRec: Record "Job Journal Line")var JobTask: Record "Job Task";
  begin
    IF JobTask.GET(Rec."Job No.", Rec."Job Task No.")THEN Rec."Line Type":=JobTask."ODT Line Type";
  //end;                                                              
  end;
  [EventSubscriber(ObjectType::Codeunit, 1004, 'OnAfterFromJnlToPlanningLine', '', False, False)]
  //local procedure OnAfterFromJnlToPlanningLine(var JobPlanningLine: Record "Job Planning Line"; var JobJnlLine: Record "Job Journal Line")
  procedure OnAfterFromJnlToPlanningLine(var JobPlanningLine: Record "Job Planning Line";
  JobJournalLine: Record "Job Journal Line")var JobTask: Record "Job Task";
  begin
    With JobPlanningLine Do Begin
      "ODT Employee No.":=JobJournalLine."ODT Employee No.";
      "ODT Field Ticket No.":=JobJournalLine."ODT Field Ticket No.";
      "ODT Field Ticket Line No.":=JobJournalLine."ODT Field Ticket Line No.";
      "Line Type":=JobJournalLine."Line Type";
    END;
  //end;                                                              
  end;
  [EventSubscriber(ObjectType::Codeunit, 1004, 'OnAfterFromJnlLineToLedgEntry', '', False, False)]
  //local procedure OnAfterFromJnlToPlanningLine(var JobPlanningLine: Record "Job Planning Line"; var JobJnlLine: Record "Job Journal Line")
  procedure OnAfterFromJnlLineToLedgEntry(var JobLedgerEntry: Record "Job Ledger Entry";
  JobJournalLine: Record "Job Journal Line")var JobTask: Record "Job Task";
  begin
    With JobLedgerEntry Do Begin
      "ODT Employee No.":=JobJournalLine."ODT Employee No.";
      "ODT Field Ticket No.":=JobJournalLine."ODT Field Ticket No.";
      "ODT Field Ticket Line No.":=JobJournalLine."ODT Field Ticket Line No.";
      Description:=JobJournalLine.Description;
    END;
  //end;                                                              
  end;
  [EventSubscriber(ObjectType::Codeunit, 1002, 'OnCreateSalesHeaderOnBeforeUpdateSalesHeader', '', False, False)]
  procedure OnCreateSalesHeaderOnBeforeUpdateSalesHeader(var SalesHeader: Record "Sales Header";
  var Job: Record Job;
  var IsHandled: Boolean)var JobTask: Record "Job Task";
  PostedFieldTicket: Record "ODT Posted Field Ticket";
  begin
    SalesHeader."ODT Project Manager":=Job."Project Manager";
    SalesHeader."ODT Job Description":=Job.Description;
    SalesHeader."ODT AFE":=Job."ODT AFE";
    SalesHeader."ODT Business Unit":=Job."ODT Business Unit";
    SalesHeader."ODT Cost Centre":=Job."ODT Cost Centre";
    SalesHeader."ODT Client File":=Job."ODT Client File";
    SalesHeader."ODT GL":=Job."ODT GL";
    SalesHeader."ODT Major":=Job."ODT Major";
    SalesHeader."ODT Minor":=Job."ODT Minor";
    SalesHeader."ODT MSA":=Job."ODT MSA";
    SalesHeader."ODT MSO":=Job."ODT MSO";
    SalesHeader."ODT Purchase Order":=Job."ODT Purchase Order";
    SalesHeader."ODT Service Order":=Job."ODT Service Order";
  //end;                                                              
  end;
  [EventSubscriber(ObjectType::Codeunit, 1002, 'OnBeforeInsertSalesLine', '', False, False)]
  //local procedure OnAfterFromJnlToPlanningLine(var JobPlanningLine: Record "Job Planning Line"; var JobJnlLine: Record "Job Journal Line")
  procedure OnBeforeInsertSalesLine(var SalesLine: Record "Sales Line";
  var SalesHeader: Record "Sales Header";
  Job: Record Job;
  JobPlanningLine: Record "Job Planning Line")var JobTask: Record "Job Task";
  PostedFieldTicket: Record "ODT Posted Field Ticket";
  begin
    With SalesLine Do Begin
      "ODT Employee No.":=JobPlanningLine."ODT Employee No.";
    END;
  //end;                                                              
  end;
  [EventSubscriber(ObjectType::Codeunit, 1012, 'OnBeforeJobLedgEntryInsert', '', False, False)]
  //local procedure OnAfterFromJnlToPlanningLine(var JobPlanningLine: Record "Job Planning Line"; var JobJnlLine: Record "Job Journal Line")
  procedure OnBeforeJobLedgEntryInsert(var JobLedgerEntry: Record "Job Ledger Entry";
  JobJournalLine: Record "Job Journal Line")var JobTask: Record "Job Task";
  begin
    With JobLedgerEntry Do Begin
      "ODT Employee No.":=JobJournalLine."ODT Employee No.";
      "ODT Field Ticket No.":=JobJournalLine."ODT Field Ticket No.";
      "ODT Field Ticket Line No.":=JobJournalLine."ODT Field Ticket Line No.";
      Description:=JobJournalLine.Description;
      "Line Type":=JobJournalLine."Line Type";
    //"Shortcut Dimension 1 Code" := JobLedgEntry."Shortcut Dimension 1 Code";
    //"Unit Cost" := JobLedgEntry."Unit Cost";
    END;
  //end;                                                              
  end;
  [EventSubscriber(ObjectType::Codeunit, 1004, 'OnAfterFromJobLedgEntryToPlanningLine', '', False, False)]
  //local procedure OnAfterFromJnlToPlanningLine(var JobPlanningLine: Record "Job Planning Line"; var JobJnlLine: Record "Job Journal Line")
  procedure OnAfterFromJobLedgEntryToPlanningLine(var JobPlanningLine: Record "Job Planning Line";
  JobLedgEntry: Record "Job Ledger Entry")var JobTask: Record "Job Task";
  begin
    With JobPlanningLine Do Begin
      "ODT Employee No.":=JobLedgEntry."ODT Employee No.";
      "ODT Field Ticket No.":=JobLedgEntry."ODT Field Ticket No.";
      "ODT Field Ticket Line No.":=JobLedgEntry."ODT Field Ticket Line No.";
      //Line type options are not the same on 2 tables
      "Line Type":=JobLedgEntry."Line Type" - 1;
      //"Shortcut Dimension 1 Code" := JobLedgEntry."Shortcut Dimension 1 Code";
      "Unit Cost":=JobLedgEntry."Unit Cost";
    END;
  //end;                                                              
  end;
  //OnAfterFromJobLedgEntryToPlanningLine...OnAfterFromJobLedgEntryToPlanningLine...OnAfterFromJobLedgEntryToPlanningLine
  var
}
