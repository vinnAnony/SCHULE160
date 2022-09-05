table 50110 Student
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Reg No."; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                if "Reg No." <> xRec."Reg No." then begin
                    StudentSetup.Get();
                    NoSeriesMgt.TestManual(StudentSetup."No. Series");
                    "Reg No." := '';
                end;
            end;
        }
        field(2; "First Name"; Text[50])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                PopulateFullName();
            end;
        }
        field(3; "Middle Name"; Text[50])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                PopulateFullName();
            end;
        }
        field(4; "Surname"; Text[50])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                PopulateFullName();
            end;
        }
        field(5; "Full Name"; Text[200])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Gender"; Enum Gender)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Date Of Birth"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                StudentSetup: Record "Student Setup";
            begin
                CalculateAge();
                StudentSetup.Get(0);
                if Age < StudentSetup."Min. Age" then
                    Error(MinAgeErrorTxt, StudentSetup."Min. Age");

                if Age > StudentSetup."Max. Age" then
                    Error(MaxAgeErrorTxt, StudentSetup."Max. Age");
            end;
        }
        field(8; Age; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Admission Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; Approved; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Approval Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,"Pending Approval",Released;
            OptionCaption = 'Open,Pending Approval,Released';
            Editable = false;
        }
        field(107; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Reg No.")
        {
            Clustered = true;
        }
    }

    var
        StudentSetup: Record "Student Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MaxAgeErrorTxt: Label 'Age exceeds the maximum age limit of %1';
        MinAgeErrorTxt: Label 'Age is below the minimum age limit of %1';

    trigger OnInsert()
    begin
        if "Reg No." = '' then begin
            StudentSetup.Get();
            StudentSetup.TestField("No. Series");
            NoSeriesMgt.InitSeries(StudentSetup."No. Series", xRec."No. Series", 0D, "Reg No.", "No. Series");
        end;

        if "Admission Date" = 0D then
            "Admission Date" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    local procedure PopulateFullName()
    begin
        "Full Name" := StrSubstNo('%1 %2 %3', "First Name", "Middle Name", Surname);
    end;

    local procedure CalculateAge()
    begin
        // AgeYears := 0;
        // repeat
        //     AgeYears += 1;
        //     CheckDate := CalcDate(StrSubstNo('<+%1Y>', AgeYears), "Date Of Birth")
        // until CheckDate >= Today;
        Age := Round((Today - "Date Of Birth") / 365, 1, '=');
    end;

}