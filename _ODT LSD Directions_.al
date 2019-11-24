table 50007 "ODT LSD Directions"
{
    // version NB03.75,NB03.83,NB03.87
    // NB03.87 2018-07-24 ODTTG  Adding control for LSD Direction ID
    DataCaptionFields = LSD, Directions, "LSD Format";
    DrillDownPageID = "ODT LSD Directions";
    LookupPageID = "ODT LSD Directions";

    fields
    {
        field(1; "LSD Format"; Code[20])
        {
        }
        field(2; LSD; Code[50])
        {
            TableRelation = "ODT LSD"."LSD Code";
        }
        field(3; ID; Code[20])
        {
        }
        field(4; "Directions Old"; Text[250])
        {
        }
        field(5; "Customer No."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate();
            begin
                if "Customer No." <> '' then begin
                    Cust.GET("Customer No.");
                    "Customer Name" := Cust.Name;
                end
                else
                    "Customer Name" := '';
            end;
        }
        field(6; "Customer Name"; Text[50])
        {
        }
        field(7; Active; Boolean)
        {
        }
        field(8; Map; BLOB)
        {
            SubType = Bitmap;
        }
        field(9; "Default Directions"; Boolean)
        {
            trigger OnValidate();
            begin
                if "Default Directions" then begin
                    LSDDirectionsDef.RESET;
                    LSDDirectionsDef.SETRANGE("LSD Format", "LSD Format");
                    LSDDirectionsDef.SETRANGE(LSD, LSD);
                    LSDDirectionsDef.SETFILTER(ID, '<>%1', ID);
                    LSDDirectionsDef.SETRANGE("Default Directions", true);
                    if not LSDDirectionsDef.ISEMPTY then LSDDirectionsDef.MODIFYALL("Default Directions", false);
                end;
            end;
        }
        field(104; Directions; BLOB)
        {
            Description = 'NB03.83 Text250 to blob';
        }
        field(105; "Create Datetime"; DateTime)
        {
        }
    }
    keys
    {
        key(Key1; "LSD Format", LSD, ID)
        {
        }
        key(Key2; "LSD Format", LSD, "Create Datetime")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Directions Old", "LSD Format", "Customer Name")
        {
        }
    }
    trigger OnInsert();
    var
        NextID: Code[20];
    begin
        LSDDirectionsDef.RESET;
        LSDDirectionsDef.SETRANGE("LSD Format", "LSD Format");
        LSDDirectionsDef.SETRANGE(LSD, LSD);
        LSDDirectionsDef.SETFILTER(ID, '<>%1', ID);
        if LSDDirectionsDef.ISEMPTY then "Default Directions" := true;
        CreateNewID(Rec);
    end;

    var
        Cust: Record Customer;
        LSDDirectionsDef: Record "ODT LSD Directions";
        txtDefault001: Label 'There can onlly be a single Default Direction.';
    // RMSetup : Record Table23001315;
    procedure SetDirection(NewDirection: Text);
    var
        //tmpBlob: Record TempBlob temporary; //RH
        tmpBlob: codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;

    begin
        CLEAR(Directions);
        if NewDirection = '' then begin
            MODIFY;
            exit;
        end;
        //tmpBlob.Blob := Directions;//RH
        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        InStr.Read(Directions);

        // tmpBlob.WriteAsText(NewDirection, TextEncoding::Windows); //RH
        tmpBlob.CreateOutStream(OutStr);
        OutStr.WriteText(NewDirection);

        // Directions := tmpBlob.Blob;//RH
        Copystream(OutStr, InStr);

        MODIFY;
    end;

    procedure GetDirection(): Text;
    var
        // tmpBlob: Record TempBlob temporary;
        tmpBlob: codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        myInteger: Integer;

        CR: Text[1];
        locLSD: Record "ODT LSD";
        locLSDDirection: Record "ODT LSD Directions";
    begin
        //If (Type=Type::Surface) Or ((Type=Type::Downhole) And ("Surface LSD"='') Then Begin
        CALCFIELDS(Directions);
        if not Directions.HASVALUE then exit('');
        CR[1] := 10;
        //tmpBlob.Blob := Directions; //RH
        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        InStr.Read(Directions);

        // exit(tmpBlob.ReadAsText(CR, TextEncoding::Windows)); //RH
        tmpBlob.CreateInStream(InStr, TextEncoding::Windows);
        myInteger := InStr.ReadText(CR);
        exit(CR);
    end;

    local procedure GetLastLSDDirectionID(pLSDFormat: Code[20];
    pLSD: Code[50]): Code[20];
    var
        locLSDDirection: Record "ODT LSD Directions";
    begin
        //<NB03.87/>
        locLSDDirection.SETCURRENTKEY(locLSDDirection."LSD Format", locLSDDirection.LSD, locLSDDirection."Create Datetime");
        locLSDDirection.SETRANGE("LSD Format", pLSDFormat);
        locLSDDirection.SETRANGE(LSD, pLSD);
        if locLSDDirection.FINDLAST then
            exit(locLSDDirection.ID)
        else
            exit('');
    end;

    procedure CreateNewID(var pLSDDirection: Record "ODT LSD Directions");
    var // locRMSetup : Record Table23001315;
        NextID: Code[20];
    begin
        //<NB03.87>
        // RMSetup.GET;
        if ID = '' then begin
            NextID := GetLastLSDDirectionID(pLSDDirection."LSD Format", pLSDDirection.LSD);
            //   if NextID='' then
            //     ID:=RMSetup."LSD Default Dir. ID"
            //   else begin
            //     if NextID=RMSetup."LSD Default Dir. ID" then begin
            //       pLSDDirection.ID:=RMSetup."LSD 2nd Dir. ID Prefix"+RMSetup."LSD 2nd Dir. ID Start No."
            //     end else
            pLSDDirection.ID := INCSTR(NextID);
            //   end;
        end;
        pLSDDirection."Create Datetime" := CURRENTDATETIME;
        //</NB03.87>
    end;
}
