*** Settings ***
Resource    ../common.resource
Resource    login_page.resource

*** Variables ***
${MAKE_APPOINTMENT_BUTTON}    id=btn-make-appointment
${FACILITY_SELECT}            id=combo_facility
${READMISSION_CHECKBOX}       id=chk_hospotal_readmission
${MEDICARE_RADIO}             id=radio_program_medicare
${MEDICAID_RADIO}             id=radio_program_medicaid
${NONE_RADIO}                 id=radio_program_none
${VISIT_DATE}                 id=txt_visit_date
${COMMENT}                    id=txt_comment
${BOOK_BUTTON}                id=btn-book-appointment

*** Keywords ***
Navigate To Appointment Login
    Click When Ready    ${MAKE_APPOINTMENT_BUTTON}
    Wait Until Location Contains    profile.php#login

Make Appointment
    [Arguments]    ${facility}    ${readmission}    ${program}    ${visit_date}    ${comment}
    Select From List By Label    ${FACILITY_SELECT}    ${facility}
    IF    $readmission
        Select Checkbox    ${READMISSION_CHECKBOX}
    ELSE
        Unselect Checkbox    ${READMISSION_CHECKBOX}
    END
    IF    $program.lower() == 'medicare'
        Select Radio Button    program    Medicare
    ELSE IF    $program.lower() == 'medicaid'
        Select Radio Button    program    Medicaid
    ELSE
        Select Radio Button    program    None
    END
    Input Text    ${VISIT_DATE}    ${visit_date}
    Input Text    ${COMMENT}    ${comment}
    Click When Ready    ${BOOK_BUTTON}

Appointment Confirmation Should Be Visible
    Wait Until Page Contains Element    id=summary
    Page Should Contain    Appointment Confirmation
    Page Should Contain    ${FACILITY}

Appointment Summary Should Contain
    [Arguments]    ${expected}
    Wait Until Page Contains    ${expected}
