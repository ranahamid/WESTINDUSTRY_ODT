page 50003 "ODT Posted Field Ticket"
{
    // version NB02.01,NB03.45,NB03.57,NB03.58,NB03.75,NB04.10,WI00.00
    // NB03.45 2016-09-21 ODTSD Non-editable Bill-to Cust Field
    // NB03.57 2017-04-13 ODTTM Created by User ID
    // NB03.58 2017-05-31 ODTJR Additional Fields for i2x integration
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = FALSE;
    PageType = Card;
    SourceTable = "ODT Posted Field Ticket";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Field Ticket No."; "Field Ticket No.")
                {
                    ApplicationArea = All;
                    // trigger OnAssistEdit()
                    // begin
                    //     IF AssistEdit(xRec) THEN
                    //         CurrPage.UPDATE;
                    // end;
                }
                field("Field Ticket Date"; "Field Ticket Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Caption = 'Job No.';
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Visible = False;

                    trigger OnValidate();
                    begin
                        ShowMandatoryFields;
                    end;
                }
                field(CompanyName; CompanyName)
                {
                    ApplicationArea = All;
                    Caption = 'Company Name';
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                    Caption = 'Job Task No.';
                    Visible = FALSE;
                }
                field("Project Manager"; "Project Manager")
                {
                    ApplicationArea = All;
                    Caption = 'Project Manager';
                }
                field("ODT AFE"; "ODT AFE")
                {
                    Caption = 'AFE';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT Business Unit"; "ODT Business Unit")
                {
                    Caption = 'Business Unit';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT Cost Centre"; "ODT Cost Centre")
                {
                    Caption = 'Cost Centre';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT Client File"; "ODT Client File")
                {
                    Caption = 'Client File';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT GL"; "ODT GL")
                {
                    Caption = 'GL';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT Major"; "ODT Major")
                {
                    Caption = 'Major';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT Minor"; "ODT Minor")
                {
                    Caption = 'Minor';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT MSA"; "ODT MSA")
                {
                    Caption = 'MSA';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT MSO"; "ODT MSO")
                {
                    Caption = 'MSO';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT Purchase Order"; "ODT Purchase Order")
                {
                    Caption = 'Purchase Order';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("ODT Service Order"; "ODT Service Order")
                {
                    Caption = 'Service Order';
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("Job Description"; "Job Description")
                {
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ApplicationArea = All;
                    Caption = 'Contact';
                    ShowMandatory = ShowBilltoContact;
                }
                field("Company Code"; "Company Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = ShowCompanyCode;
                    Visible = FALSE;
                }
                field("Department/Attention To"; "Department/Attention To")
                {
                    ApplicationArea = All;
                    ShowMandatory = ShowDepartment;
                    Visible = FALSE;
                }
                field(Requisitioner; Requisitioner)
                {
                    ApplicationArea = All;
                    Visible = FALSE;
                }
                field("Crem Member 1"; "Crem Member 1")
                {
                    ApplicationArea = All;
                }
                field("Crem Member 2"; "Crem Member 2")
                {
                    ApplicationArea = All;
                }
                field("Crem Member 3"; "Crem Member 3")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Created by User ID"; "Created by User ID")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
            }
            group("Description of Work")
            {
                field("Summary Description"; "Description of Work")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = ShowSummaryDesc;
                    ShowCaption = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Description 3"; "Description 3")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Description 4"; "Description 4")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Description 5"; "Description 5")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ShowCaption = false;
                }
                field("Description 6"; "Description 6")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ShowCaption = false;
                }
                field("Description 7"; "Description 7")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ShowCaption = false;
                }
                field("Description 8"; "Description 8")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    ShowCaption = false;
                }
            }
            part(Control1101754041; "ODT Posted Field Ticket Line")
            {
                ApplicationArea = All;
                SubPageLink = "Field Ticket No." = FIELD ("Field Ticket No.");
                SubPageView = SORTING ("Field Ticket No.");
            }
        }
        area(factboxes)
        {
            systempart(Control1101754033; Notes)
            {
                Visible = true;
                ApplicationArea = All;
            }
            // part(Control1101754039;50302)
            // {
            //     SubPageLink = Field1=FIELD("Dispatch ID");
            // }
        }
    }
    actions
    {
        area(navigation)
        {
            action(Job)
            {
                ApplicationArea = All;
                Image = Job;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Job Card";
                RunPageLink = "No." = FIELD ("Job No.");
            }
        }
    }
    trigger OnAfterGetCurrRecord();
    begin
        ShowMandatoryFields;
    end;

    trigger OnAfterGetRecord();
    begin
        ShowMandatoryFields;
    end;

    trigger OnClosePage();
    var // FieldTicketError : ;
    begin
        /*IF "Job No." <> '' THEN BEGIN
              {  //NB03.45 -->
                //Check if there are posted sales invoices and credits
                SalesInvoiceHeader.SETRANGE("Job No.","Job No.");
                IF SalesInvoiceHeader.FINDFIRST THEN
                  ERROR('Posted Invoice %1 already exists for Job %2.',SalesInvoiceHeader."No.","Job No.");
                SalesCrMemoHeader.SETRANGE("Job No.","Job No.");
                IF SalesCrMemoHeader.FINDFIRST THEN
                  ERROR('Posted Sales Credit %1 already exists for Job %2.',SalesCrMemoHeader."No.","Job No.");
                //Check if Job Ledger already exists
                JobLedgerEntry.SETCURRENTKEY("Job No.");
                JobLedgerEntry.SETRANGE("Job No.","Job No.");
                IF JobLedgerEntry.FINDFIRST THEN
                  ERROR();
                //<-- NB03.45
               }
                Job.GET("Job No.");
                Job."SUR LSD Format" := "SUR LSD Format";
                Job."DH LSD Format" := "DH LSD Format";
                Job."From DH LSD" := "From DH LSD";
                Job."To DH LSD" := "To DH LSD";
                Job."From SUR LSD" := "From SUR LSD";
                Job."To SUR LSD" := "To SUR LSD";
                Job."Rig No." := "Rig No.";
                Job."AFE #" := "AFE #";
                Job."Reference Field Type" := "Reference Field Type"; //NB03.45
                Job."Reference Field No." := "Reference Field No."; //NB03.45
                Job.MODIFY;
               {
                //NB03.45 -->
                //Update all Sales Headers with the same Job
                SalesHeader.SETRANGE("Job No.","Job No.");
                IF SalesHeader.FINDFIRST THEN
                REPEAT
                  IF SalesHeader."SUR LSD Format" <> "SUR LSD Format" THEN SalesHeader."SUR LSD Format" := "SUR LSD Format";
                  IF SalesHeader."From SUR LSD" <> "From SUR LSD" THEN SalesHeader."From SUR LSD" := "From SUR LSD";
                  IF SalesHeader."To SUR LSD" <> "To SUR LSD" THEN SalesHeader."To SUR LSD" := "To SUR LSD";
                  IF SalesHeader."DH LSD Format" <> "DH LSD Format" THEN SalesHeader."DH LSD Format" := "DH LSD Format";
                  IF SalesHeader."From DH LSD" <> "From DH LSD" THEN SalesHeader."From DH LSD" := "From DH LSD";
                  IF SalesHeader."To DH LSD" <> "To DH LSD" THEN SalesHeader."To DH LSD" := "To DH LSD";
                  IF SalesHeader."Rig No." <> "Rig No." THEN SalesHeader."Rig No." := "Rig No.";
                  IF SalesHeader."AFE #" <> "AFE #" THEN SalesHeader."AFE #" := "AFE #";
                  IF SalesHeader."Reference Field Type" <> "Reference Field Type" THEN SalesHeader."Reference Field Type" := "Reference Field Type";
                  IF SalesHeader."Reference Field No." <> "Reference Field No." THEN SalesHeader."Reference Field No." := "Reference Field No.";
                  SalesHeader.MODIFY;
                UNTIL SalesHeader.NEXT = 0;
                //<-- NB03.45
              }
              END ELSE
                VALIDATE("Bill-to Customer No.");
              */
    end;

    trigger OnInit();
    begin
        ShowMandatoryFields;
    end;

    trigger OnOpenPage();
    begin
        ShowMandatoryFields;
    end;

    var
        Job: Record Job;
        "--NB03.45": Integer;
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        JobLedgerEntry: Record "Job Ledger Entry";
        "--NB03.58": Integer;
        ShowBillingLSDFormat: Boolean;
        ShowCustGLAccCode: Boolean;
        ShowPlantCode: Boolean;
        ShowApproverID: Boolean;
        ShowDepartment: Boolean;
        ShowSummaryDesc: Boolean;
        ShowRequisitioner: Boolean;
        ShowWorkOrderNo: Boolean;
        ShowBillingLSD: Boolean;
        ShowCompanyCode: Boolean;
        ShowRigNo: Boolean;
        ShowAFE: Boolean;
        ShowReferenceType: Boolean;
        ShowReferenceNo: Boolean;
        ShowActivityCode: Boolean;
        ShowReviewerID: Boolean;
        ShowBilltoContact: Boolean;
        Cust: Record Customer;
        WorkOrderCaption: Text[50];
        AFECaption: Text[50];

    local procedure ShowMandatoryFields();
    begin
        if Cust.GET("Bill-to Customer No.") then begin
            //   ShowBillingLSDFormat := Cust."Billing LSD Format Check";
            //   ShowCustGLAccCode := Cust."Cust G/L Account Code Check";
            //   ShowPlantCode := Cust."Plant Code Check";
            //   ShowApproverID := Cust."Approver ID Check";
            //   ShowDepartment := Cust."Department Check";
            //   ShowSummaryDesc := Cust."Summary Description Check";
            //   ShowRequisitioner := Cust."Requisitioner Check";
            //   ShowWorkOrderNo := Cust."Work Order No. Check";
            //   ShowBillingLSD := Cust."Billing LSD Check";
            //   ShowCompanyCode := Cust."Company Code Check";
            //   ShowRigNo := Cust."Rig No. Check";
            //   ShowAFE := Cust."AFE No. Check";
            //   ShowReferenceType := Cust."Reference Field Type Check";
            //   ShowReferenceNo := Cust."Reference Field No. Check";
            //   ShowActivityCode := Cust."Activity Code Check";
            //   ShowReviewerID := Cust."Reviewer ID Check";
            //   ShowBilltoContact := Cust."Bill-to Contact Check";
            //   if Cust."Work Order No. Caption" <> '' then
            //     WorkOrderCaption := Cust."Work Order No. Caption"
            //   else
            //     WorkOrderCaption := 'Work Order No.';
            //   if Cust."AFE Caption" <> '' then
            //     AFECaption := Cust."AFE Caption"
            //   else
            //     AFECaption := 'AFE #';
        end;
    end;
}
