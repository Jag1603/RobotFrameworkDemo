*** Settings ***
Resource    ../common.resource

*** Variables ***
${MENU_TOGGLE}       id=menu-toggle
${SIDEBAR_HISTORY}   xpath=//a[contains(normalize-space(.), 'History')]
${SIDEBAR_HOME}      xpath=//a[contains(normalize-space(.), 'Home')]
${HISTORY_HEADING}   xpath=//*[contains(normalize-space(.), 'History')]

*** Keywords ***
Open History From Menu
    Click When Ready    ${MENU_TOGGLE}
    Click When Ready    ${SIDEBAR_HISTORY}
    Wait Until Location Contains    history.php

History Page Should Be Displayed
    Wait Until Element Is Visible    ${HISTORY_HEADING}
    Page Should Contain    History
