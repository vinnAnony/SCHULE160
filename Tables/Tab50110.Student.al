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
    }

    keys
    {
        key(PK; "Reg No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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