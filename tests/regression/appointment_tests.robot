*** Settings ***
Documentation    Appointment and authentication regression scenarios.
Resource         ../../resources/common.resource
Resource         ../../resources/pages/appointment_page.resource
Resource         ../../resources/pages/login_page.resource
Resource         ../../resources/pages/history_page.resource
Test Setup       Open CURA Browser
Test Teardown    Close CURA Browser
Test Tags        regression    ui

*** Test Cases ***
Valid User Can Book An Appointment
    [Tags]    appointment    positive
    Navigate To Appointment Login
    Login As Demo User
    Page Should Contain    Make Appointment
    ${comment}=    Create Unique Appointment Comment    ${COMMENT_PREFIX}
    Make Appointment
    ...    ${FACILITY}
    ...    ${True}
    ...    Medicare
    ...    30/12/2027
    ...    ${comment}
    Appointment Confirmation Should Be Visible
    Appointment Summary Should Contain    ${comment}
    Appointment Summary Should Contain    Medicare

Invalid Credentials Show Error
    [Tags]    authentication    negative
    Navigate To Appointment Login
    Login With Credentials    invalid-user    incorrect-password
    Login Error Should Be Visible

User Can Open Appointment History
    [Tags]    history
    Navigate To Appointment Login
    Login As Demo User
    Open History From Menu
    History Page Should Be Displayed
