page 50000 "ODT Field Ticket Job Mapping"
{
    Caption = 'Field Ticket';
    PageType = Card;
    SourceTable = "ODT Field Ticket Job Mapping";
    UsageCategory = Documents;
    ApplicationArea = All;

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

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN CurrPage.UPDATE;
                    end;
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
            part(Control1101754040; "ODT Field Ticket Line")
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
                ApplicationArea = All;
                Visible = true;
            }
            // part(Control1101754039; 50302)
            // {
            //     SubPageLink = Field1 = FIELD ("Dispatch ID");
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
            action(Suggest)
            {
                ApplicationArea = All;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    SuggestFTLine: Report "ODT Suggest Field Ticket Lines";
                begin
                    SuggestFTLine.SetFieldTicket(Rec);
                    SuggestFTLine.Runmodal();
                end;
            }
            action(Post)
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    Cust.GET("Bill-to Customer No.");
                    if Cust."ODT FT Approval Required" then
                        Rec.TESTFIELD(Status, Rec.Status::Approved)
                    else
                        DispatchMgt.CreateJobJournal(Rec);
                end;
            }
            action(Print)
            {
                ApplicationArea = All;
                Caption = 'Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction();
                var
                    FieldTicketRep: Report "ODT Field Ticket";
                    FieldTicketH: Record "ODT Field Ticket Job Mapping";
                begin
                    CurrPage.SETSELECTIONFILTER(FieldTicketH);
                    REPORT.RUNMODAL(50000, TRUE, FALSE, FieldTicketH);
                end;
            }
            action(Email)
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = Email;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
            }
            action("Field Ticket Allocation Rpt.")
            {
                ApplicationArea = All;
                Caption = 'Job Journal Allocation Rpt.';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = "Report";
            }
            group(Correct)
            {
                Caption = 'Correct';

                action(Send)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction();
                    var
                        CorrectPstdSalesInvYesNo: Codeunit "Correct PstdSalesInv (Yes/No)";
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        Rec.ActionUpdate('Pending Approval');
                    end;
                }
                action(Cancel)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    // ToolTipML =;
                    trigger OnAction();
                    var
                        CancelPstdSalesInvYesNo: Codeunit "Cancel PstdSalesInv (Yes/No)";
                    begin
                        if Rec.Status = Rec.Status::Open then exit;
                        Rec.ActionUpdate('Open');
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    // ToolTipML =;
                    trigger OnAction();
                    var
                        CancelPstdSalesInvYesNo: Codeunit "Cancel PstdSalesInv (Yes/No)";
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::"Pending Approval");
                        Rec.ActionUpdate('Approved');
                    end;
                }
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
    begin
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
        DispatchMgt: Codeunit "ODT Field Ticket Management";

    local procedure ShowMandatoryFields();
    begin
        if Cust.GET("Bill-to Customer No.") then begin
            // ShowBillingLSDFormat := Cust."Billing LSD Format Check";
            // ShowCustGLAccCode := Cust."Cust G/L Account Code Check";
            // ShowPlantCode := Cust."Plant Code Check";
            // ShowApproverID := Cust."Approver ID Check";
            // ShowDepartment := Cust."Department Check";
            // ShowSummaryDesc := Cust."Summary Description Check";
            // ShowRequisitioner := Cust."Requisitioner Check";
            // ShowWorkOrderNo := Cust."Work Order No. Check";
            // ShowBillingLSD := Cust."Billing LSD Check";
            // ShowCompanyCode := Cust."Company Code Check";
            // ShowRigNo := Cust."Rig No. Check";
            // ShowAFE := Cust."AFE No. Check";
            // ShowReferenceType := Cust."Reference Field Type Check";
            // ShowReferenceNo := Cust."Reference Field No. Check";
            // ShowActivityCode := Cust."Activity Code Check";
            // ShowReviewerID := Cust."Reviewer ID Check";
            // ShowBilltoContact := Cust."Bill-to Contact Check";
            // if Cust."Work Order No. Caption" <> '' then
            //     WorkOrderCaption := Cust."Work Order No. Caption"
            // else
            //     WorkOrderCaption := 'Work Order No.';
            // if Cust."AFE Caption" <> '' then
            //     AFECaption := Cust."AFE Caption"
            // else
            //     AFECaption := 'AFE #';
        end;
    end;
}
