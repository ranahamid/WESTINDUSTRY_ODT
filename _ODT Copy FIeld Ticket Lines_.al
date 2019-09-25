report 50005 "ODT Copy FIeld Ticket Lines"
{
    Caption = 'Copy Field Ticket Lines';
    UseRequestPage = true;
    ApplicationArea = All;
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Job;
        Job)
        {

            DataItemTableView = sorting ("No.");

            dataitem(JobTask;
            "Job Task")
            {
                DataItemTableView = sorting ("Job No.", "Job Task No.");
                DataItemLink = "Job No." = FIELD ("No.");

                dataitem(JobPlanLine;
                "Job Planning Line")
                {
                    DataItemTableView = sorting ("Job No.", "Job Task No.", "Line No.");
                    DataItemLink = "Job No." = field ("Job No."), "Job Task No." = field ("Job Task No.");

                    trigger OnAfterGetRecord()
                    begin
                        FieldTicketLines.Init();
                        FieldTicketLines."Field Ticket No." := FieldTicket."Field Ticket No.";
                        FieldTicketLines."Line No." := LastFTLineNo;
                        LastFTLineNo += 10000;
                        FieldTicketLines."Job No." := FieldTicket."Job No.";
                        FieldTicketLines.Validate(Type, Type);
                        FieldTicketLines.Validate("No.", "No.");
                        FieldTicketLines.Description := Description;
                        FieldTicketLines.Validate(Quantity, Quantity);
                        FieldTicketLines.Insert(true);
                    end;
                } //job planning line
                trigger OnPreDataItem()
                begin
                    if JobTaskNo <> '' then SetRange("Job Task No.", JobTaskNo);
                end;
            } //Job Task
            trigger OnPreDataItem()
            begin
                SetRange("No.", JobNo);
                if COUNT <> 1 then Error('Please select 1 Job');
            end;
        } //Job
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(JobNoOption; JobNo)
                    {
                        Caption = 'Job No.';
                        ToolTip = 'Choose the Job to copy the planning lines from';
                        TableRelation = Job;
                        ApplicationArea = All;
                    }
                    field(JobTaskNoOption; JobTaskNo)
                    {
                        Caption = 'Job Task No.';
                        ToolTip = 'Choose the Job Task No. to copy the planning lines from (if any)';
                        TableRelation = "Job Task"; // where ("Job No." = const(JobNo));
                        ApplicationArea = All;

                        trigger OnLookup(var txt: Text): Boolean
                        var
                            jt: Record "Job Task";
                        begin
                            jt.SetRange("Job No.", JobNo);
                            if Page.RunModal(0, jt) = Action::LookupOK then JobTaskNo := jt."Job Task No.";
                        end;

                        trigger OnValidate()
                        var
                            jt: Record "Job Task";
                        begin
                            jt.SetRange("Job No.", JobNo);
                            jt.SetRange("Job Task No.", JobTaskNo);
                            if jt.Count < 1 then Error('Please select a Job and optionally a Job Task No.');
                        end;
                    }
                } //group
            } //area
        } //layout
        trigger OnOpenPage()
        begin
            JobNo := FieldTicket."Job No.";
            JobTaskNo := FieldTicket."Job Task No.";
        end;
    }
    procedure SetFieldTicketNo(ft: Code[20])
    begin
        FieldTicket.Get(ft);
        FieldTicketLines.SetRange("Field Ticket No.", ft);
        if FieldTicketLines.FindLast() then
            LastFTLineNo := FieldTicketLines."Line No." + 10000
        else
            LastFTLineNo := 10000;
    end;

    var
        JobNo: Code[20];
        JobTaskNo: Code[20];
        FieldTicket: Record "ODT Field Ticket Job Mapping";
        FieldTicketLines: Record "ODT FT Job Mapping Lines";
        LastFTLineNo: Integer;
}
