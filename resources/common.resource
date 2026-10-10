*** Settings ***
Resource    variables.resource

*** Keywords ***
Resolve Base URL
    ${url}=    Set Variable If    '${BASE_URL}' != ''    ${BASE_URL}    ${ENVIRONMENTS}[${ENV}]
    RETURN    ${url}

Open CURA Browser
    ${url}=    Resolve Base URL
    ${options}=    Evaluate    __import__('selenium.webdriver').webdriver.ChromeOptions()
    IF    '${BROWSER}'.lower() == 'chrome'
        IF    '${HEADLESS}'.lower() in ('true', '1', 'yes')
            ${_}=    Evaluate    $options.add_argument('--headless=new')
        END
        ${_}=    Evaluate    $options.add_argument('--window-size=1440,1000')
        ${_}=    Evaluate    $options.add_argument('--disable-dev-shm-usage')
        ${_}=    Evaluate    $options.add_argument('--no-sandbox')
        Open Browser    ${url}    ${BROWSER}    options=${options}
    ELSE
        Open Browser    ${url}    ${BROWSER}
    END
    Set Selenium Timeout    ${DEFAULT_TIMEOUT}
    Set Selenium Implicit Wait    0s
    Maximize Browser Window

Close CURA Browser
    Run Keyword And Ignore Error    Capture Page Screenshot
    Close All Browsers

Click When Ready
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    Wait Until Element Is Enabled    ${locator}
    Click Element    ${locator}

Type When Ready
    [Arguments]    ${locator}    ${value}
    Wait Until Element Is Visible    ${locator}
    Clear Element Text    ${locator}
    Input Text    ${locator}    ${value}

Page Should Contain Text Eventually
    [Arguments]    ${expected}
    Wait Until Page Contains    ${expected}    ${DEFAULT_TIMEOUT}
