page 50110 Student
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Student;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Reg No."; "Reg No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = All;
                }
                field(Surname; Surname)
                {
                    ApplicationArea = All;
                }
                field("Full Name"; "Full Name")
                {
                    ApplicationArea = All;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; "Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field(Age; Age)
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; "Admission Date")
                {
                    ApplicationArea = All;
                }
                field(Approved; Approved)
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Send for Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = SendApprovalRequest;

                trigger OnAction()
                var
                    StudentApprovalWF: Codeunit "Student Approval WF";
                begin
                    //Send Approval
                    if StudentApprovalWF.CheckStudentApprovalStatus(Rec) then
                        StudentApprovalWF.OnSendStudentsforApproval(Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}