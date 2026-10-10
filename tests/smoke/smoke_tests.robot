*** Settings ***
Documentation    Fast checks for the most important CURA user journeys.
Resource         ../../resources/common.resource
Resource         ../../resources/pages/appointment_page.resource
Test Setup       Open CURA Browser
Test Teardown    Close CURA Browser
Test Tags        smoke    ui

*** Test Cases ***
CURA Home Page Loads
    Title Should Be    CURA Healthcare Service
    Page Should Contain    Make Appointment

Make Appointment Opens Login Page
    Navigate To Appointment Login
    Page Should Contain    Login
    Page Should Contain Element    id=txt-username
    Page Should Contain Element    id=txt-password
