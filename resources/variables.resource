*** Settings ***
Library    SeleniumLibrary
Library    ../libraries/CuraSupport.py
Library    Collections
Library    String
Library    OperatingSystem
Variables    ../config/environments.py

*** Variables ***
${ENV}                 qa
${BASE_URL}            ${EMPTY}
${BROWSER}             chrome
${HEADLESS}            false
${DEFAULT_TIMEOUT}     10s
${SHORT_TIMEOUT}       3s
${VALID_USERNAME}      John Doe
${VALID_PASSWORD}      ThisIsNotAPassword
${FACILITY}            Seoul CURA Healthcare Center
${COMMENT_PREFIX}      Robot Framework appointment
