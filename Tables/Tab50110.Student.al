table 50110 Student
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Reg No."; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            NotBlank = true;

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
        }
        field(3; "Middle Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Surname"; Text[50])
        {
            DataClassification = CustomerContent;
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
        }
        field(100; "No. Series"; Code[30])
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

}