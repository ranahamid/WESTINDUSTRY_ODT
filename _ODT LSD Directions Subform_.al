page 50015 "ODT LSD Directions Subform"
{
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "ODT LSD Directions";
    SourceTableView = SORTING ("LSD Format", LSD, "Create Datetime");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Direct; GetDirection())
                {
                    ApplicationArea = All;
                    Caption = 'Directions';
                    Editable = false;
                    ShowMandatory = true;

                    trigger OnAssistEdit();
                    var
                        Type: Option "LSD Directions","Dispatch Directions","Job Details";
                    begin
                        CurrPage.UPDATE(false);
                        if ID = '' then begin
                            CreateNewID(Rec);
                            INSERT;
                        end;
                        //recLSD.GET("LSD Format",LSD);
                        //ODTJR CHANGE SEARCH FOR LSD
                        recLSD.RESET;
                        recLSD.SETRANGE(recLSD.Type, recLSD.Type::Surface);
                        recLSD.SETRANGE("LSD Code", LSD);
                        if recLSD.FINDFIRST then begin
                            if (recLSD.Type = recLSD.Type::Surface) or (recLSD."Surface LSD" = '') then begin
                                LSDDirectionText.GetLSDDirections(Type::"LSD Directions", "LSD Format", LSD, ID);
                                LSDDirectionText.RUN;
                            end;
                        end;
                    end;
                }
                field(ID; ID)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Default Directions"; "Default Directions")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        MODIFY; //ODTJR Update as the field is removed after the Map is entered
                    end;
                }
                field(HasMap; HasMap)
                {
                    ApplicationArea = All;
                    Caption = 'Map';
                    Editable = false;

                    trigger OnDrillDown();
                    var
                        LSDDirectionPage: Page "ODT LSD Map";
                    begin
                        CurrPage.UPDATE(false);
                        LSDDirection.GET("LSD Format", LSD, ID);
                        LSDDirectionPage.SETRECORD(LSDDirection);
                        //LSDDirectionPage.EDITABLE(TRUE);
                        LSDDirectionPage.RUNMODAL;
                    end;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; "Customer Name")
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Map)
            {
                ApplicationArea = All;

                Image = Map;

                trigger OnAction();
                begin
                    LSDDirection.SETRANGE("LSD Format", "LSD Format");
                    LSDDirection.SETRANGE(LSD, LSD);
                    LSDDirection.SETRANGE(ID, ID);
                    LSDMap.SETTABLEVIEW(LSDDirection);
                    LSDMap.EDITABLE := true;
                    LSDMap.RUN;
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord();
    begin
        thisRec := Rec; //<NB03.83 />
    end;

    trigger OnAfterGetRecord();
    begin
        HasMap := false;
        if LSDDirection.GET("LSD Format", LSD, ID) then begin
            LSDDirection.CALCFIELDS(Map);
            if LSDDirection.Map.HASVALUE then HasMap := true;
        end;
    end;

    trigger OnInit();
    begin
        HasMap := false;
    end;

    var
        Desc3Txt: Text;
        InStr: InStream;
        OutStr: OutStream;
        LSDDirectionText: Page "ODT LSD Directions Text";
        MapPage: Page "ODT FT Map";
        LSDDirection: Record "ODT LSD Directions";
        HasMap: Boolean;
        LSDMap: Page "ODT LSD Map";
        LSDDirections: Record "ODT LSD Directions";
        IDRename: Integer;
        thisRec: Record "ODT LSD Directions";
        recLSD: Record "ODT LSD";

    procedure GetRec(var LDSDir: Record "ODT LSD Directions");
    begin
        LDSDir := thisRec; //<NB03.83 />
    end;
}
