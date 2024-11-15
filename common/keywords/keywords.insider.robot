*** Settings ***
Library     String
Library     OperatingSystem
Library     Collections
Library  RequestsLibrary
Library  RPA.JSON
Library     SeleniumLibrary
Resource    ../variables.robot
Resource    ../common.robot
Resource    ../../common/locators/locators.insider.robot

*** Keywords ***
visit insider
    [Arguments]    ${host}=${host}    ${browser}=${browser}
    open browser    ${host}  ${browser}
    set window size  1600   1000
    set selenium speed  0.1
    set selenium timeout  ${timeout}
    wait until keyword succeeds    ${retries}    ${timeout}    page should contain element      ${title.locator}
    ${meta_content}=    get element attribute    ${title.locator}    content
    should contain    ${meta_content}      ${title.text}

visit careers page
    [Arguments]
    wait until element is visible  ${menu.company}
    click element    ${menu.company}
    wait until element is visible  ${menu.company.careers}
    click element    ${menu.company.careers}
    make sure that interested page loaded      ${menu.company.careers.url}
    wait until element is visible  ${careers.lifeatinsider.block}

visit careers qa page
    [Arguments]
    go to      ${company.careers.qa.url}
    make sure that interested page loaded      ${company.careers.qa.url}
    wait until element is visible  ${careers.qa.seealljobs}
    click element    ${careers.qa.seealljobs}
    make sure that interested page loaded      ${company.careers.qa.open.positions.url}
    verify that page was loaded
    wait until element is visible    ${careers.qa.filterbydepartmentqa}
    click element   ${careers.qa.filterbylocationdropwown}
    wait until element is visible   ${careers.qa.filterbylocationIstambul}
    click element   ${careers.qa.filterbylocationIstambul}
    wait until element is visible      ${careers.qa.location.filter.istanbul.selected}
    wait until element is visible  ${careers.qa.joblist}
    wait until element is visible    ${careers.qa.numberofjobs}   10s

verify position, department, location in qa job list
    [Arguments]
    wait until element is visible    ${careers.qa.numberofjobs}   15s
    ${job_count}=    get text    ${careers.qa.numberofjobs}
    log    total job count: ${job_count}
    ${job_count}=    convert to integer    ${job_count}
    FOR    ${index}    IN RANGE    1    ${job_count + 1}
        ${job_location_xpath}=    set variable    (//div[@id='jobs-list']/div[contains(@class, 'position-list-item')])[${index}]//div[@class='position-location text-large']
        ${location}=    get text    ${job_location_xpath}
        log    Job ${index} Location: ${location}
        should be equal    ${location}    Istanbul, Turkey
        ${job_position_xpath}=    set variable    (//div[@id='jobs-list']/div[contains(@class, 'position-list-item')])[${index}]//span[@class='position-department text-large font-weight-600 text-primary']
        ${position}=    get text    ${job_position_xpath}
        log    Job ${index} Position: ${position}
        should be equal    ${position}    Quality Assurance
        ${job_titleqa_xpath}=    set variable    (//div[@id='jobs-list']/div[contains(@class, 'position-list-item')])[${index}]//p[@class='position-title font-weight-bold']
        ${title}=    get text    ${job_titleqa_xpath}
        log    Job ${index} Title: ${title}
        should contain    ${title}    Quality Assurance
    END

verify view role button
    [Arguments]
    wait until element is visible    ${careers.qa.viewrolebutton}   20s
    click element    ${careers.qa.viewrolebutton}
    ${window_handles}=    Get Window Handles
    Switch Window    ${window_handles[1]}
    wait until element is visible     ${role.description.page.header}