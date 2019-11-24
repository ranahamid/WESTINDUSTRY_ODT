report 50002 "ODT Suggest Field Ticket Lines"
{
    Caption = 'Suggest Field Ticket Lines';
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(StartingDate; StartingDate)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date from which the report or batch job processes information.';
                    }
                    field(EndingDate; EndingDate)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the date to which the report or batch job processes information.';
                    }
                    field(ResourceNoFilter; ResourceNoFilter)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Resource No. Filter';
                        TableRelation = Resource;
                        ToolTip = 'Specifies the resource number that the batch job will suggest job lines for.';
                    }
                    field(JobNoFilter; JobNoFilter)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Job No. Filter';
                        TableRelation = Job;
                        ToolTip = 'Specifies a filter for the job numbers that will be included in the report.';
                    }
                    field(JobTaskNoFilter; JobTaskNoFilter)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Job Task No. Filter';
                        ToolTip = 'Specifies a filter for the job task numbers that will be included in the report.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            JobTask: Record "Job Task";
                        begin
                            JobTask.FilterGroup(2);
                            if JobNoFilter <> '' then JobTask.SetFilter("Job No.", JobNoFilter);
                            JobTask.FilterGroup(0);
                            if PAGE.RunModal(PAGE::"Job Task List", JobTask) = ACTION::LookupOK then JobTask.TestField("Job Task Type", JobTask."Job Task Type"::Posting);
                            JobTaskNoFilter := JobTask."Job Task No.";
                        end;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TimeSheetMgt: Codeunit "Time Sheet Management";
        NextDocNo: Code[20];
        LineNo: Integer;
        QtyToPost: Decimal;
    begin
        DateFilter := TimeSheetMgt.GetDateFilter(StartingDate, EndingDate);
        FillTimeSheetLineBuffer;
        if TempTimeSheetLine.FindSet then begin
            //   JobJnlLine.LockTable;
            //   JobJnlTemplate.Get(JobJnlLine."Journal Template Name");
            //   JobJnlBatch.Get(JobJnlLine."Journal Template Name",JobJnlLine."Journal Batch Name");
            //   if JobJnlBatch."No. Series" = '' then
            //     NextDocNo := ''
            //   else
            //     NextDocNo := NoSeriesMgt.GetNextNo(JobJnlBatch."No. Series",TempTimeSheetLine."Time Sheet Starting Date",false);
            //   JobJnlLine.SetRange("Journal Template Name",JobJnlLine."Journal Template Name");
            //   JobJnlLine.SetRange("Journal Batch Name",JobJnlLine."Journal Batch Name");
            //   if JobJnlLine.FindLast then;
            //   LineNo := JobJnlLine."Line No.";
            FTLine.Setrange("Field Ticket No.", FTHeader."Field Ticket No.");
            if FTLine.findlast then;
            LineNo := FTLine."Line No.";
            repeat
                TimeSheetHeader.Get(TempTimeSheetLine."Time Sheet No.");
                TimeSheetDetail.SetRange("Time Sheet No.", TempTimeSheetLine."Time Sheet No.");
                TimeSheetDetail.SetRange("Time Sheet Line No.", TempTimeSheetLine."Line No.");
                if DateFilter <> '' then TimeSheetDetail.SetFilter(Date, DateFilter);
                TimeSheetDetail.SetFilter(Quantity, '<>0');
                TimeSheetDetail.SetRange(Posted, false);
                if TimeSheetDetail.FindSet then
                    repeat
                        QtyToPost := TimeSheetDetail.GetMaxQtyToPost;
                        if QtyToPost <> 0 then begin
                            //   JobJnlLine.Init;
                            //   LineNo := LineNo + 10000;
                            //   JobJnlLine."Line No." := LineNo;
                            //   JobJnlLine."Time Sheet No." := TimeSheetDetail."Time Sheet No.";
                            //   JobJnlLine."Time Sheet Line No." := TimeSheetDetail."Time Sheet Line No.";
                            //   JobJnlLine."Time Sheet Date" := TimeSheetDetail.Date;
                            //   JobJnlLine.Validate("Job No.",TimeSheetDetail."Job No.");
                            //   JobJnlLine."Source Code" := JobJnlTemplate."Source Code";
                            //   if TimeSheetDetail."Job Task No." <> '' then
                            //     JobJnlLine.Validate("Job Task No.",TimeSheetDetail."Job Task No.");
                            //   JobJnlLine.Validate(Type,JobJnlLine.Type::Resource);
                            //   JobJnlLine.Validate("No.",TimeSheetHeader."Resource No.");
                            //   if TempTimeSheetLine."Work Type Code" <> '' then
                            //     JobJnlLine.Validate("Work Type Code",TempTimeSheetLine."Work Type Code");
                            //   JobJnlLine.Validate("Posting Date",TimeSheetDetail.Date);
                            //   JobJnlLine."Document No." := NextDocNo;
                            //   NextDocNo := IncStr(NextDocNo);
                            //   JobJnlLine."Posting No. Series" := JobJnlBatch."Posting No. Series";
                            //   JobJnlLine.Description := TempTimeSheetLine.Description;
                            //   JobJnlLine.Validate(Quantity,QtyToPost);
                            //   JobJnlLine.Validate(Chargeable,TempTimeSheetLine.Chargeable);
                            //   JobJnlLine."Reason Code" := JobJnlBatch."Reason Code";
                            //   JobJnlLine.Insert;
                            FTLine.init;
                            LineNo := LineNo + 10000;
                            FTLine."Line No." := LineNo;
                            FTLine.Validate("Job No.", TimeSheetDetail."Job No.");
                            if TimeSheetDetail."Job Task No." <> '' then begin
                                FTLine.Validate("Job Task No.", TimeSheetDetail."Job Task No.");
                                JobTask.Get(TempTimeSheetLine."Job No.", TempTimeSheetLine."Job Task No.");
                                if JobTask."ODT Line Type" <> JobTask."ODT Line Type"::" " then FTLine.Validate("Line Type", JobTask."ODT Line Type");
                            end;
                            if TempTimeSheetLine."Work Type Code" <> '' then begin
                                WorkTypes.Get(TempTimeSheetLine."Work Type Code");
                                if (WorkTypes."ODT Convert Res. to Item") and (workTypes."ODT Item No." <> '') then
                                    ConvertResToItem := true
                                else
                                    ConvertResToItem := false;
                            end;
                            if ConvertResToItem then begin
                                FTLine.Validate(Type, FTLine.Type::Item);
                                FTLine.Validate("No.", WorkTypes."ODT Item No.");
                                FTLine.Validate(Quantity, QtyToPost);
                                FTLine.Validate("Employee No.", TimeSheetHeader."Resource No.");
                                Res.Get(TimeSheetHeader."Resource No.");
                                FTLine.Validate("Unit Cost", Res."Direct Unit Cost");
                            end
                            Else begin
                                FTLine.Validate(Type, FTLine.Type::Resource);
                                FTLine.Validate("No.", TimeSheetHeader."Resource No.");
                                FTLine.Validate(Quantity, QtyToPost);
                            end;
                            FTLine.validate("Time Sheet No.", TimeSheetDetail."Time Sheet No.");
                            FTLine.Validate("Time Sheet Line No.", TimeSheetDetail."Time Sheet Line No.");
                            FTLine.Validate("Time Sheet Date", TimeSheetDetail.Date);
                            FTLine.Description := TempTimeSheetLine.Description;
                            FTLine.Insert;
                        end;
                    until TimeSheetDetail.Next = 0;
            until TempTimeSheetLine.Next = 0;
        end;
    end;

    var
        JobJnlLine: Record "Job Journal Line";
        FTLine: Record "ODT FT Job Mapping Lines";
        FTHeader: Record "ODT Field Ticket Job Mapping";
        JobJnlBatch: Record "Job Journal Batch";
        JobJnlTemplate: Record "Job Journal Template";
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        TempTimeSheetLine: Record "Time Sheet Line" temporary;
        TimeSheetDetail: Record "Time Sheet Detail";
        ResourceNoFilter: Code[1024];
        JobNoFilter: Code[1024];
        JobTaskNoFilter: Code[1024];
        StartingDate: Date;
        EndingDate: Date;
        DateFilter: Text[30];
        Job: Record Job;
        JobTask: Record "Job Task";
        WorkTypes: Record "Work Type";
        ConvertResToItem: Boolean;
        Res: Record Resource;

    [Scope('Cloud')]
    procedure SetJobJnlLine(NewJobJnlLine: Record "Job Journal Line")
    begin
        JobJnlLine := NewJobJnlLine;
    end;

    [Scope('Cloud')]
    procedure SetFieldTicket(NewFT: record "ODT Field Ticket Job Mapping")
    begin
        FTHeader := NewFT;
        JobNoFilter := FTHeader."Job No.";
        JobTaskNoFilter := FTHeader."Job Task No."
    end;

    [Scope('Cloud')]
    procedure InitParameters(NewJobJnlLine: Record "Job Journal Line";
    NewResourceNoFilter: Code[1024];
    NewJobNoFilter: Code[1024];
    NewJobTaskNoFilter: Code[1024];
    NewStartingDate: Date;
    NewEndingDate: Date)
    begin
        JobJnlLine := NewJobJnlLine;
        ResourceNoFilter := NewResourceNoFilter;
        JobNoFilter := NewJobNoFilter;
        JobTaskNoFilter := NewJobTaskNoFilter;
        StartingDate := NewStartingDate;
        EndingDate := NewEndingDate;
    end;

    local procedure FillTimeSheetLineBuffer()
    var
        SkipLine: Boolean;
    begin
        if ResourceNoFilter <> '' then TimeSheetHeader.SetFilter("Resource No.", ResourceNoFilter);
        if DateFilter <> '' then begin
            TimeSheetHeader.SetFilter("Starting Date", DateFilter);
            TimeSheetHeader.SetFilter("Starting Date", '..%1', TimeSheetHeader.GetRangeMax("Starting Date"));
            TimeSheetHeader.SetFilter("Ending Date", DateFilter);
            TimeSheetHeader.SetFilter("Ending Date", '%1..', TimeSheetHeader.GetRangeMin("Ending Date"));
        end;
        if TimeSheetHeader.FindSet then
            repeat
                TimeSheetLine.SetRange("Time Sheet No.", TimeSheetHeader."No.");
                TimeSheetLine.SetRange(Type, TimeSheetLine.Type::Job);
                TimeSheetLine.SetRange(Status, TimeSheetLine.Status::Approved);
                if JobNoFilter <> '' then TimeSheetLine.SetFilter("Job No.", JobNoFilter);
                if JobTaskNoFilter <> '' then TimeSheetLine.SetFilter("Job Task No.", JobTaskNoFilter);
                TimeSheetLine.SetRange(Posted, false);
                if TimeSheetLine.FindSet then
                    repeat
                        TempTimeSheetLine := TimeSheetLine;
                        if not SkipLine then TempTimeSheetLine.Insert;
                    until TimeSheetLine.Next = 0;
            until TimeSheetHeader.Next = 0;
    end;
}
