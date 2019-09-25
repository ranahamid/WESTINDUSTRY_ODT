page 50004 "ODT Posted Field Ticket Line"
{
    // version NB04.10,WI00.00
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "ODT Posted Field Ticket Lines";
    Editable = false;
    DeleteAllowed = FALSE;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Field Ticket No."; "Field Ticket No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Type"; "Line Type")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Time Sheet No."; "Time Sheet No.")
                {
                    Visible = FALSE;
                    ApplicationArea = All;
                }
                field("Time Sheet Line No."; "Time Sheet Line No.")
                {
                    Visible = FALSE;
                    ApplicationArea = All;
                }
                field("Time Sheet Date"; "Time Sheet Date")
                {
                    Visible = FALSE;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                // field("Service Code";"Service Code")
                // {
                // }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; "Unit Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Price (LCY)"; "Total Price (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Direct Unit Cost (LCY)"; "Direct Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total Cost"; "Total Cost")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total Cost (LCY)"; "Total Cost (LCY)")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(PO; PO)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("PO Line No."; "PO Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Service Start Date"; "Service Start Date")
                {
                    ApplicationArea = All;
                }
                field("Service End Date"; "Service End Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Work Type Code"; "Work Type Code")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                // }
                field("Charge Type"; "Charge Type")
                {
                    ApplicationArea = All;
                }
                field("AFE No."; "AFE No.")
                {
                    ApplicationArea = All;
                }
                field("Cost Center"; "Cost Center")
                {
                    ApplicationArea = All;
                }
                field(Major; Major)
                {
                    ApplicationArea = All;
                }
                field(Minor; Minor)
                {
                    ApplicationArea = All;
                }
                field(Volume; Volume)
                {
                    ApplicationArea = All;
                }
                field("Charge By"; "Charge By")
                {
                    ApplicationArea = All;
                }
                field("Disposal Ticket"; "Disposal Ticket")
                {
                    ApplicationArea = All;
                }
                field("Disposal Location"; "Disposal Location")
                {
                    ApplicationArea = All;
                }
                field(Payload; Payload)
                {
                    ApplicationArea = All;
                }
                field("Gauge Start Unit"; "Gauge Start Unit")
                {
                    ApplicationArea = All;
                }
                field("Gauge Start Subunit"; "Gauge Start Subunit")
                {
                    ApplicationArea = All;
                }
                field("Gauge Finish Unit"; "Gauge Finish Unit")
                {
                    ApplicationArea = All;
                }
                field("Hours Worked Unit"; "Hours Worked Unit")
                {
                    ApplicationArea = All;
                }
                field("Hours Worked Subunit"; "Hours Worked Subunit")
                {
                    ApplicationArea = All;
                }
                field("Gauge Finish Subunit"; "Gauge Finish Subunit")
                {
                    ApplicationArea = All;
                }
                field("License Number"; "License Number")
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; "Driver Name")
                {
                    ApplicationArea = All;
                }
                field("Crew Member"; "Crew Member")
                {
                    ApplicationArea = All;
                }
                // field("Rental Terms";"Rental Terms")
                // {
                // }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allocation Line Count"; "Allocation Line Count")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Allocated Amount"; "Allocated Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                // field("Dispatch ID";"Dispatch ID")
                // {
                //     Visible = false;
                // }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';

                action(UnitAllocation)
                {
                    ApplicationArea = All;
                    Caption = 'Unit Allocation';
                    Ellipsis = true;
                    Image = Allocations;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F12';

                    trigger OnAction();
                    var
                        FA: Record "Fixed Asset";
                        Res: Record Resource;
                        // SalesLineAlloc : Record Table50017;
                        // CanAlloc : Boolean;
                        TEXT001: Label 'Fixed Asset selected is not a Leased Operator. \Unit Allocation is not required.';
                        TEXT002: Label 'Resource selected is not a Leased Operator. \Unit Allocation is not required.';
                        TEXT003: Label 'Unit Code cannot be found from the Fixed Asset List or Resource List.';
                    begin
                        //NB02.11+  Check if 3rd Party
                        // CanAlloc := false;
                        // if FA.GET("Shortcut Dimension 2 Code") then
                        //    if not FA."3rd Party" then
                        //        ERROR(TEXT001)
                        //    else
                        //        CanAlloc := true
                        // else if Res.GET("Shortcut Dimension 2 Code") then
                        //    if not Res."Leased Operator" then
                        //        ERROR(TEXT002)
                        //    else
                        //        CanAlloc := true
                        // else
                        //    ERROR(TEXT003);
                        // if CanAlloc then begin
                        //    TicketLineAllocation.RESET;
                        //    //TicketLineAllocation.SETRANGE("Document Type","Document Type");
                        //    TicketLineAllocation.SETRANGE("Field Ticket No.","Field Ticket No.");
                        //    TicketLineAllocation.SETRANGE("Field Ticket Line No.","Line No.");
                        //    PAGE.RUNMODAL(50064,TicketLineAllocation);
                        // end;
                        // //NB02.11-
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        InitType;
        //Type := Type::"Fixed Asset";
    end;

    var
    // TicketLineAllocation : Record Table50024;
}
