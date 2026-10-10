*** Settings ***
Resource    ../common.resource

*** Variables ***
${LOGIN_USERNAME}       id=txt-username
${LOGIN_PASSWORD}       id=txt-password
${LOGIN_BUTTON}         id=btn-login
${LOGIN_ERROR}          css=.text-danger

*** Keywords ***
Login With Credentials
    [Arguments]    ${username}    ${password}
    Type When Ready    ${LOGIN_USERNAME}    ${username}
    Type When Ready    ${LOGIN_PASSWORD}    ${password}
    Click When Ready    ${LOGIN_BUTTON}

Login As Demo User
    Login With Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}

Login Error Should Be Visible
    Wait Until Element Is Visible    ${LOGIN_ERROR}
    Element Should Contain    ${LOGIN_ERROR}    Login failed
