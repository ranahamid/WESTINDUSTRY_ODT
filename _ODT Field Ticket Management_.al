codeunit 50002 "ODT Field Ticket Management"
{
    var
        FixedAssets: Record "Fixed Asset";
        Resource: Record Resource;
        Customer: Record Customer;
        JobTask: Record "Job Task";
        FixedAssets2: Record "Fixed Asset";
        Skip: Boolean;
        Text001: Label 'You can not combine rental and trucking units on the same schedule.';
        Text002: Label 'Dispatch %1 created.';
        JobJnlTemplate: Record "Job Journal Template";
        JobSetup: Record "Jobs Setup";

    procedure CreateJobJournal(FieldTicket: Record "ODT Field Ticket Job Mapping");
    var
        Text003: Label 'Job Journal Templates need to be setup first.';
        JobJnlLine: Record "Job Journal Line";
        LineNo: Integer;
        Text004: Label 'Are you sure you want to post Ticket %1?';
        FieldTicketLine: Record "ODT FT Job Mapping Lines";
        PostedFieldTicket: Record "ODT Posted Field Ticket";
        PostedFieldTicketLine: Record "ODT Posted Field Ticket Lines";
        JobJnlPost: Codeunit "Job Jnl.-Post";
    begin
        IF NOT CONFIRM(Text004, FALSE, FieldTicket."Field Ticket No.") THEN EXIT;
        FieldTicketLine.RESET;
        FieldTicketLine.SETRANGE("Field Ticket No.", FieldTicket."Field Ticket No.");
        IF FieldTicketLine.FINDSET THEN
            REPEAT
                CreateJobJournalLine(FieldTicketLine, JobJnlLine, FieldTicket);
            UNTIL FieldTicketLine.NEXT = 0;
        PostedFieldTicket.INIT;
        PostedFieldTicket.TRANSFERFIELDS(FieldTicket);
        PostedFieldTicket."Posted By" := USERID;
        PostedFieldTicket."Posted Date Time" := CREATEDATETIME(WORKDATE, TIME);
        PostedFieldTicket.INSERT;
        FieldTicketLine.RESET;
        FieldTicketLine.SETRANGE("Field Ticket No.", FieldTicket."Field Ticket No.");
        IF FieldTicketLine.FINDSET THEN
            REPEAT
                PostedFieldTicketLine.INIT;
                PostedFieldTicketLine.TRANSFERFIELDS(FieldTicketLine);
                PostedFieldTicketLine.INSERT;
            UNTIL FieldTicketLine.NEXT = 0;
        FieldTicket.SETRANGE("Field Ticket No.", FieldTicket."Field Ticket No.");
        IF NOT FieldTicket.ISEMPTY THEN FieldTicket.DELETEALL;
        FieldTicketLine.RESET;
        FieldTicketLine.SETRANGE("Field Ticket No.", FieldTicket."Field Ticket No.");
        IF NOT FieldTicketLine.ISEMPTY THEN FieldTicketLine.DELETEALL;
    end;

    procedure CreateJobJournalLine(FieldTicketLine: Record "ODT FT Job Mapping Lines";
    var JobJnlLine: Record "Job Journal Line";
    FieldTicket: Record "ODT Field Ticket Job Mapping");
    var
        Text003: Label 'Job Journal Templates need to be setup first.';
        LineNo: Integer;
        Text004: Label 'Are you sure you want to post Ticket %1?';
        JobJnlPostLine: Codeunit "Job Jnl.-Post Line";
        locJobTask: Record "Job Task";
    begin
        FieldTicketLine.TESTFIELD("Job Task No.");
        FieldTicketLine.TESTFIELD("Shortcut Dimension 1 Code");
        FieldTicketLine.TESTFIELD("Shortcut Dimension 2 Code");
        locJobTask.GET(FieldTicketLine."Job No.", FieldTicketLine."Job Task No.");
        locJobTask.TESTFIELD("ODT Closed", FALSE);
        JobJnlLine.INIT;
        JobJnlLine.VALIDATE("Job No.", FieldTicket."Job No.");
        JobJnlLine.VALIDATE("Job Task No.", FieldTicketLine."Job Task No.");
        JobJnlLine.VALIDATE("ODT Field Ticket No.", FieldTicket."Field Ticket No.");
        JobJnlLine.VALIDATE(Type, FieldTicketLine.Type);
        JobJnlLine.VALIDATE("No.", FieldTicketLine."No.");
        JobJnlLine.VALIDATE("Shortcut Dimension 2 Code", FieldTicketLine."Shortcut Dimension 2 Code");
        JobJnlLine.VALIDATE(Quantity, FieldTicketLine.Quantity);
        JobJnlLine.VALIDATE("Unit Price", FieldTicketLine."Unit Price");
        JobJnlLine.VALIDATE("Line Discount %", FieldTicketLine."Line Discount %");
        JobJnlLine."AFE #" := FieldTicketLine."AFE No.";
        JobJnlLine."Document No." := FieldTicketLine."Field Ticket No.";
        JobJnlLine."ODT Cost Center" := FieldTicketLine."Cost Center";
        JobJnlLine."Time Sheet No." := FieldTicketLine."Time Sheet No.";
        JobJnlLine."Time Sheet Line No." := FieldTicketLine."Time Sheet Line No.";
        JobJnlLine."Time Sheet Date" := FieldTicketLine."Time Sheet Date";
        JobJnlLine."ODT Field Ticket No." := FieldTicketLine."Field Ticket No.";
        JobJnlLine."ODT Field Ticket Line No." := FieldTicketLine."Line No.";
        JobJnlLine."Line Type" := FieldTicketLine."Line Type";
        JobJnlLine."ODT Employee No." := FieldTicketLine."Employee No.";
        JobJnlLine.Description := FieldTicketLine.Description;
        JobJnlLine.VALIDATE("Shortcut Dimension 1 Code", FieldTicketLine."Shortcut Dimension 1 Code");
        JobJnlLine.VALIDATE("Unit Cost", FieldTicketLine."Unit Cost");
        JobJnlPostLine.RunWithCheck(JobJnlLine);
    end;

    procedure JobInfo(VAR HeaderArray: ARRAY[13] OF Text;
    VAR HeaderCapArray: ARRAY[13] OF Text;
    VAR Job: Record Job)
    begin
        CLEAR(HeaderArray);
        CLEAR(HeaderCapArray);
        WITH Job DO BEGIN
            HeaderArray[1] := Job."ODT Field Rep";
            HeaderArray[2] := Job."ODT AFE";
            HeaderArray[3] := Job."ODT Business Unit";
            HeaderArray[4] := Job."ODT Client File";
            HeaderArray[5] := Job."ODT Major";
            HeaderArray[6] := Job."ODT Minor";
            HeaderArray[7] := Job."ODT Cost Centre";
            HeaderArray[8] := Job."ODT GL";
            HeaderArray[9] := Job."ODT MSA";
            HeaderArray[10] := Job."ODT MSO";
            HeaderArray[11] := Job."ODT Purchase Order";
            HeaderArray[12] := Job."ODT Service Order";

            HeaderArray[13] := Job.InvoiceDescription;

            IF HeaderArray[1] <> '' THEN HeaderCapArray[1] := Job.FIELDCAPTION("ODT Field Rep") + ':';
            IF HeaderArray[2] <> '' THEN HeaderCapArray[2] := Job.FIELDCAPTION("ODT AFE") + ':';
            IF HeaderArray[3] <> '' THEN HeaderCapArray[3] := Job.FIELDCAPTION("ODT Business Unit") + ':';
            IF HeaderArray[4] <> '' THEN HeaderCapArray[4] := Job.FIELDCAPTION("ODT Client File") + ':';
            IF HeaderArray[5] <> '' THEN HeaderCapArray[5] := Job.FIELDCAPTION("ODT Major") + ':';
            IF HeaderArray[6] <> '' THEN HeaderCapArray[6] := Job.FIELDCAPTION("ODT Minor") + ':';
            IF HeaderArray[7] <> '' THEN HeaderCapArray[7] := Job.FIELDCAPTION("ODT Cost Centre") + ':';
            IF HeaderArray[8] <> '' THEN HeaderCapArray[8] := Job.FIELDCAPTION("ODT GL") + ':';
            IF HeaderArray[9] <> '' THEN HeaderCapArray[9] := Job.FIELDCAPTION("ODT MSA") + ':';
            IF HeaderArray[10] <> '' THEN HeaderCapArray[10] := Job.FIELDCAPTION("ODT MSO") + ':';
            IF HeaderArray[11] <> '' THEN HeaderCapArray[11] := Job.FIELDCAPTION("ODT Purchase Order") + ':';
            IF HeaderArray[12] <> '' THEN HeaderCapArray[12] := Job.FIELDCAPTION("ODT Service Order") + ':';
            IF HeaderArray[13] <> '' THEN HeaderCapArray[13] := Job.FIELDCAPTION("InvoiceDescription") + ':';
        END;
        COMPRESSARRAY(HeaderCapArray);
        COMPRESSARRAY(HeaderArray);
    end;

    procedure PostedSalesInvJobInfo(VAR HeaderArray: ARRAY[13] OF Text; VAR HeaderCapArray: ARRAY[13] OF Text; VAR Job: Record Job;
        SalesInvHeader: Record "Sales Invoice Header")
    begin
        CLEAR(HeaderArray);
        CLEAR(HeaderCapArray);
        HeaderArray[1] := Job."ODT Field Rep";
        WITH SalesInvHeader DO BEGIN
            HeaderArray[2] := SalesInvHeader."ODT AFE";
            HeaderArray[3] := SalesInvHeader."ODT Business Unit";
            HeaderArray[4] := SalesInvHeader."ODT Client File";
            HeaderArray[5] := SalesInvHeader."ODT Major";
            HeaderArray[6] := SalesInvHeader."ODT Minor";
            HeaderArray[7] := SalesInvHeader."ODT Cost Centre";
            HeaderArray[8] := SalesInvHeader."ODT GL";
            HeaderArray[9] := SalesInvHeader."ODT MSA";
            HeaderArray[10] := SalesInvHeader."ODT MSO";
            HeaderArray[11] := SalesInvHeader."ODT Purchase Order";
            HeaderArray[12] := SalesInvHeader."ODT Service Order";

            HeaderArray[13] := SalesInvHeader."InvoiceDescription"; //RH 

            IF HeaderArray[1] <> '' THEN HeaderCapArray[1] := Job.FIELDCAPTION("ODT Field Rep") + ':';
            IF HeaderArray[2] <> '' THEN HeaderCapArray[2] := SalesInvHeader.FIELDCAPTION("ODT AFE") + ':';
            IF HeaderArray[3] <> '' THEN HeaderCapArray[3] := SalesInvHeader.FIELDCAPTION("ODT Business Unit") + ':';
            IF HeaderArray[4] <> '' THEN HeaderCapArray[4] := SalesInvHeader.FIELDCAPTION("ODT Client File") + ':';
            IF HeaderArray[5] <> '' THEN HeaderCapArray[5] := SalesInvHeader.FIELDCAPTION("ODT Major") + ':';
            IF HeaderArray[6] <> '' THEN HeaderCapArray[6] := SalesInvHeader.FIELDCAPTION("ODT Minor") + ':';
            IF HeaderArray[7] <> '' THEN HeaderCapArray[7] := SalesInvHeader.FIELDCAPTION("ODT Cost Centre") + ':';
            IF HeaderArray[8] <> '' THEN HeaderCapArray[8] := SalesInvHeader.FIELDCAPTION("ODT GL") + ':';
            IF HeaderArray[9] <> '' THEN HeaderCapArray[9] := SalesInvHeader.FIELDCAPTION("ODT MSA") + ':';
            IF HeaderArray[10] <> '' THEN HeaderCapArray[10] := SalesInvHeader.FIELDCAPTION("ODT MSO") + ':';
            IF HeaderArray[11] <> '' THEN HeaderCapArray[11] := SalesInvHeader.FIELDCAPTION("ODT Purchase Order") + ':';
            IF HeaderArray[12] <> '' THEN HeaderCapArray[12] := SalesInvHeader.FIELDCAPTION("ODT Service Order") + ':';

            IF HeaderArray[13] <> '' THEN HeaderCapArray[13] := SalesInvHeader.FIELDCAPTION("InvoiceDescription") + ':';

        END;
        COMPRESSARRAY(HeaderCapArray);
        COMPRESSARRAY(HeaderArray);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Suggest Job Jnl. Lines", 'OnAfterTransferTimeSheetDetailToJobJnlLine', '', false, false)]
    procedure OnAfterTransferTimesheetDetailToJnlLine(var JobJournalLine: Record "Job Journal Line";
    JobJournalTemplate: Record "Job Journal Template";
    var TempTimeSheetLine: Record "Time Sheet Line" temporary;
    TimeSheetDetail: Record "Time Sheet Detail")
    var
        locWorkTypes: Record "Work Type";
        locRes: Record Resource;
        locItemQty: Decimal;
    begin
        if TempTimeSheetLine."Work Type Code" = '' then exit;
        locWorkTypes.Get(TempTimeSheetLine."Work Type Code");
        if (locWorkTypes."ODT Item No." = '') Or (Not locWorkTypes."ODT Convert Res. to Item") then exit;
        locRes.Get(JobJournalLine."No.");
        locItemQty := JobJournalLine.Quantity;
        JobJournalLine."ODT Employee No." := locRes."No.";
        JobJournalLine.validate("Work Type Code", '');
        JobJournalLine.Validate(Type, JobJournalLine.Type::Item);
        JobJournalLine.Validate("No.", locWorkTypes."ODT Item No.");
        JobJournalLine.Validate(Quantity, locItemQty);
        JobJournalLine.Validate("Unit Cost", locRes."Direct Unit Cost");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Line", 'OnAfterRunCode', '', false, false)]
    procedure OnAfterRunCodeJobJnlPostLine(var JobJournalLine: Record "Job Journal Line";
    JobLedgEntryNo: Integer)
    var
        ResJnlLine: Record "Res. Journal Line";
        ResLedgEntry: record "Res. Ledger Entry";
        ResJnlPostLine: codeunit "Res. Jnl.-Post Line";
        locWorkType: record "Work Type";
    begin
        if JobJournalLine."ODT Employee No." = '' then exit;
        if JobJournalLine.Type <> JobJournalLine.Type::Item then exit;
        // if JobJournalLine."Work Type Code" = '' then
        //     exit;
        // locWorkType.Get(JobJournalLine."Work Type Code");
        // if Not locWorkType."ODT Convert Res. to Item" then
        //     exit;
        // <!- Copy Job Journal Line to Res. Journal Line -!>
        With ResJnlLine Do begin
            INIT;
            "Entry Type" := JobJournalLine."Entry Type";
            "Document No." := JobJournalLine."Document No.";
            "External Document No." := JobJournalLine."External Document No.";
            "Posting Date" := JobJournalLine."Posting Date";
            "Document Date" := JobJournalLine."Document Date";
            "Resource No." := JobJournalLine."ODT Employee No.";
            Description := JobJournalLine.Description;
            "Work Type Code" := JobJournalLine."Work Type Code";
            // "Job No." := JobJournalLine."Job No.";
            "Shortcut Dimension 1 Code" := JobJournalLine."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := JobJournalLine."Shortcut Dimension 2 Code";
            "Dimension Set ID" := JobJournalLine."Dimension Set ID";
            "Unit of Measure Code" := JobJournalLine."Unit of Measure Code";
            "Source Code" := JobJournalLine."Source Code";
            "Gen. Bus. Posting Group" := JobJournalLine."Gen. Bus. Posting Group";
            "Gen. Prod. Posting Group" := JobJournalLine."Gen. Prod. Posting Group";
            "Posting No. Series" := JobJournalLine."Posting No. Series";
            "Reason Code" := JobJournalLine."Reason Code";
            "Resource Group No." := JobJournalLine."Resource Group No.";
            "Recurring Method" := JobJournalLine."Recurring Method";
            "Expiration Date" := JobJournalLine."Expiration Date";
            "Recurring Frequency" := JobJournalLine."Recurring Frequency";
            Quantity := JobJournalLine.Quantity;
            "Qty. per Unit of Measure" := JobJournalLine."Qty. per Unit of Measure";
            "Direct Unit Cost" := JobJournalLine."Direct Unit Cost (LCY)";
            "Unit Cost" := JobJournalLine."Unit Cost (LCY)";
            "Total Cost" := JobJournalLine."Total Cost (LCY)";
            "Unit Price" := JobJournalLine."Unit Price (LCY)";
            "Total Price" := JobJournalLine."Line Amount (LCY)";
            "Time Sheet No." := JobJournalLine."Time Sheet No.";
            "Time Sheet Line No." := JobJournalLine."Time Sheet Line No.";
            "Time Sheet Date" := JobJournalLine."Time Sheet Date";
        end;
        ResLedgEntry.LockTable;
        ResJnlPostLine.RunWithCheck(ResJnlLine);
    end;
}
