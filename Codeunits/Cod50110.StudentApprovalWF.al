codeunit 50110 "Student Approval WF"
{
    trigger OnRun()
    begin

    end;

    var
        StudentApprovalWF: Codeunit "Student Approval WF";
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendStudentReq: TextConst ENU = 'Approval Request for Student is requested', ENG = 'Approval Request for Student is requested';
        AppReqStudent: TextConst ENU = 'Approval Request for Student is approved', ENG = 'Approval Request for Student is approved';
        RejReqStudent: TextConst ENU = 'Approval Request for Student is rejected', ENG = 'Approval Request for Student is rejected';
        DelReqStudent: TextConst ENU = 'Approval Request for Student is delegated', ENG = 'Approval Request for Student is delegated';
        SendForPendAppTxt: TextConst ENU = 'Status of Student changed to Pending approval', ENG = 'Status of Student changed to Pending approval';
        ReleaseStudentTxt: TextConst ENU = 'Release Student', ENG = 'Release Student';
        ReOpenStudentTxt: TextConst ENU = 'ReOpen Student', ENG = 'ReOpen Student';

    [IntegrationEvent(false, false)]
    procedure OnSendStudentsforApproval(var Student: Record Student)
    begin
    end;

    procedure IsStudentEnabled(var Student: Record Student): Boolean
    begin
        exit(WFMngt.CanExecuteWorkflow(Student, StudentApprovalWF.RunWorkflowOnSendStudentApprovalCode()))
    end;

    procedure CheckWorkflowEnabled()
    var
        Student: Record Student;
        NotEnabledErr: Label 'This record is not supported by related approval workflow.';
    begin
        if not IsStudentEnabled(Student) then
            Error(NotEnabledErr);
    end;

    procedure RunWorkflowOnSendStudentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendStudentApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Student Approval WF", 'OnSendStudentsforApproval', '', false, false)]
    procedure RunWorkflowOnSendStudentApproval(var Student: Record Student)
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendStudentApprovalCode(), Student);
    end;

    procedure RunWorkflowOnApproveStudentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveStudentApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveStudentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEvent(RunWorkflowOnApproveStudentApprovalCode(), ApprovalEntry);
    end;

    procedure RunWorkflowOnRejectStudentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectStudentApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectStudentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEvent(RunWorkflowOnRejectStudentApprovalCode(), ApprovalEntry);
    end;

    procedure RunWorkflowOnDelegateStudentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateStudentApproval'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateStudentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEvent(RunWorkflowOnDelegateStudentApprovalCode(), ApprovalEntry);
    end;

    procedure SetStatusToPendingApprovalCodeStudentCode(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalStudent'));
    end;

    procedure SetStatusToPendingApprovalStudent(var Variant: Variant)
    var
        RecRef: RecordRef;
        Student: Record Student;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::Student:
                begin
                    RecRef.SetTable(Student);
                    Student.Validate("Approval Status", Student."Approval Status"::"Pending Approval");
                    Student.Modify();
                    Variant := Student;
                end;
        end;
    end;

    procedure ReleaseStudentCode(): Code[128]
    begin
        exit(UpperCase('ReleaseStudent'));
    end;

    procedure ReleaseStudent(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Student: Record Student;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseStudent(Variant);
                end;
            DATABASE::Student:
                begin
                    RecRef.SetTable(Student);
                    Student.Validate("Approval Status", Student."Approval Status"::Released);
                    Student.Modify();
                    Variant := Student;
                end;
        end;
    end;

    procedure ReOpenStudentCode(): Code[128]
    begin
        exit(UpperCase('ReOpenStudent'));
    end;

    procedure ReOpenStudent(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        Student: Record Student;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenStudent(Variant);
                end;
            DATABASE::Student:
                begin
                    RecRef.SetTable(Student);
                    Student.Validate("Approval Status", Student."Approval Status"::Open);
                    Student.Modify();
                    Variant := Student;
                end;
        end;
    end;

    // Add events and responses to library
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure AddStudentWorkflowEventsToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendStudentApprovalCode(), Database::Student, SendStudentReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveStudentApprovalCode(), Database::Student, AppReqStudent, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectStudentApprovalCode(), Database::Student, RejReqStudent, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateStudentApprovalCode(), Database::Student, DelReqStudent, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    local procedure AddStudentWorkflowResponsesToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeStudentCode(), 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseStudentCode(), 0, ReleaseStudentTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenStudentCode(), 0, ReOpenStudentTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    local procedure ExecuteStudentWorkflowResponse(var ResponseExecuted: Boolean; Variant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of

                SetStatusToPendingApprovalCodeStudentCode():
                    begin
                        SetStatusToPendingApprovalStudent(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseStudentCode():
                    begin
                        ReleaseStudent(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenStudentCode():
                    begin
                        ReOpenStudent(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;

}