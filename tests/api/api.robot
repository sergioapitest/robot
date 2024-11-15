*** Settings ***
Resource    ../../common/common.robot

*** Test Cases ***

POST: Positive: Create pet and verify it was created successfully
    [Tags]  stable
    ${PET_DATA}  create dictionary    name=mypetname    status=available
    log     ${PET_DATA}
    create session    create    ${BASE_URL}
    ${response}=    post on session    create    /pet    json=${PET_DATA}
    status should be    200    ${response}
    log    ${response.text}
    should contain    ${response.text}    mypetname
    ${json}=    JSONLibrary.Convert String to JSON  ${response.text}
    ${pet_id}=    Get From Dictionary    ${json}    id
    set global variable    ${PET_ID}    ${pet_id}

POST: Negative: Create pet with empty body
    [Tags]  stable
    create session    create    ${BASE_URL}
    ${response}=    run keyword and ignore error    POST On Session    create    /pet      json=${NONE}
    log    ${response[1]}
    should contain    ${response[1]}    415
    should contain    ${response[1]}    Unsupported Media Type

GET: Positive: Get Pets By Status Available
    [Tags]  stable
    create session    get    ${BASE_URL}
    ${params}=    create dictionary    status=available
    ${response}=    get on session    get    /pet/findByStatus    params=${params}
    status should be    200    ${response}
    log    ${response.text}
    should contain    ${response.text}    mypetname

GET: Negative: Get Pets without required status field (BUG)
    [Tags]  stable
    create session    get    ${BASE_URL}
    ${response}=    get on session    get    /pet/findByStatus
    status should be    400    ${response}
    log    ${response.text}
    should contain    ${response.text}    	Invalid status value

PUT: Positive: Update created pet
    [Tags]  stable
    create session    update    ${BASE_URL}
    ${PET_DATA}  create dictionary    name=mypetnameupdated    status=available
    log     ${PET_DATA}
    ${response}=    put on session    update    /pet    json=${PET_DATA}
    status should be    200    ${response}
    log    ${response.text}
    should contain    ${response.text}    mypetnameupdated


PUT: Negative: Update pet with invalid id (BUG)
    [Tags]  stable
    Create Session    update    ${BASE_URL}
    ${PET_DATA}  Create Dictionary    id=9580349580395435inv$@#$
    log     ${PET_DATA}
    ${response}=    PUT On Session    update    /pet    json=${PET_DATA}
    Status Should Be    400    ${response}
    Log    ${response.text}
    Should Contain    ${response.text}    Invalid ID supplied

PUT: Negative: Update not existing pet (BUG)
    [Tags]  stable
    Create Session    update    ${BASE_URL}
    ${PET_DATA}  Create Dictionary    name=notexistingbugasitsreturns200
    log     ${PET_DATA}
    ${response}=    PUT On Session    update    /pet    json=${PET_DATA}
    Status Should Be    400    ${response}
    Log    ${response.text}
    Should Contain    ${response.text}    Pet not found

DELETE: Positive: Delete created pet
    [Tags]  stable
    log     ${PET_ID}
    Create Session    delete    ${BASE_URL}
    ${response}=    DELETE On Session    delete    /pet/${PET_ID}
    Status Should Be    200    ${response}
    Log    ${response.text}

GET: Positive: Verify pet was removed
    [Tags]  stable
    create session    get    ${BASE_URL}
    ${response}=    Run Keyword And Ignore Error    get on session    get    /pet/${PET_ID}
    Log    ${response[1]}
    Should Contain    ${response[1]}    404
    Should Contain    ${response[1]}    Not Found

DELETE: Negative: Delete pet which doens't exist
    [Tags]  stable
    Create Session    delete    ${BASE_URL}
    ${response}=    Run Keyword And Ignore Error    delete on session    delete    /pet/5793487593847539847
    Log    ${response[1]}
    Should Contain    ${response[1]}    404
    Should Contain    ${response[1]}    Not Found