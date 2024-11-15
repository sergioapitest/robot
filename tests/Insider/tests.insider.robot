*** Settings ***
Resource    ../../common/common.robot
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot

#*** Variables ***

*** Test Cases ***
Visit Insider and verify it's successfully opened
    [Tags]      stable
    [Teardown]      close browser
    visit insider

Verify Career page, its Locations, Teams and Life at Insider blocks
    [Tags]  stable
    [Teardown]      close browser
    visit insider
    visit careers page

Verify QA job list filtered by Turkey
    [Tags]  stable
    [Teardown]      close browser
    visit insider
    visit careers qa page

Verify all qa job position contains qa, department contains qa, location contains Istanbul, Turkey
    [Tags]  stable
    [Teardown]      close browser
    visit insider
    visit careers qa page
    verify position, department, location in qa job list

Verify view role button leads to Lever Application form page
    [Tags]  stable
    [Teardown]      close browser
    visit insider
    visit careers qa page
    verify view role button



