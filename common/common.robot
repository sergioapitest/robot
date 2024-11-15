*** Settings ***
Library     String
Library     OperatingSystem
Library     Collections
Library  RequestsLibrary
Library    JSONLibrary
Library  RPA.JSON
Library     SeleniumLibrary
Resource    variables.robot
Resource    ../common/locators/locators.insider.robot
Resource    ../common/keywords/keywords.insider.robot


*** Keywords ***

make sure that interested page loaded
    [Arguments]    ${page}
    ${location}     get location
    should be equal    ${page}    ${location}

verify that page was loaded
    ${test}    execute javascript    return document.readyState === 'complete'
    should be equal    ${test}    ${True}

