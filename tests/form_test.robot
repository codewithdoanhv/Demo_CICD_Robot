*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${BROWSER}        Chrome
${URL}            https://demoqa.com/text-box
${VALID_USER}     Doanh Automation Test
${VALID_EMAIL}    codewithdoanhv@yopmail.com

*** Test Cases ***
Successful Form Submission
    [Documentation]    Test form submission with scroll to submit button
    Open Browser To Input Box
    Input Username    ${VALID_USER}
    # Chờ cho trường username có thể tương tác được
    Input Email    ${VALID_EMAIL}
    # Chờ cho trường email có thể tương tác được
    Submit Form With Scroll
    # Chờ cho trang tải xong và phần tử có thể tương tác
    Verify Submission
    #Verify that the form submission was successful
    [Teardown]    Close Browser


*** Keywords ***
Open Browser To Input Box
    [Documentation]    Open the browser and navigate to the input box page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    # Chờ cho trang tải xong và phần tử có thể tương tác
    Wait Until Page Contains Element    id=userName

Input Username
    [Documentation]    Input the username into the form
    [Arguments]    ${username}
    # Chờ cho trường username có thể tương tác được
    Input Text    id=userName    ${username}

Input Email
    [Documentation]    Input the email address into the form
    [Arguments]    ${email}
    # Chờ cho trường email có thể tương tác được
    Input Text    id=userEmail    ${email}


Submit Form With Scroll
    [Documentation]    Scroll to the submit button and click it

    ${submit}=    Get WebElement    id=submit
    # Chờ cho nút submit có thể tương tác được
    Execute JavaScript    arguments[0].scrollIntoView({behavior: 'smooth', block: 'center'});    ARGUMENTS    ${submit}
    # Chờ cho nút submit xuất hiện trong viewport
    Sleep    1s
    # Kiểm tra vị trí của nút submit
    Wait For Condition    return document.getElementById('submit').getBoundingClientRect().top >= 0
    # Nhấp vào nút submit
    Click Element    ${submit}
    Sleep    2s
Verify Submission
    # Chờ cho phần tử kết quả xuất hiện
    Wait Until Element Is Visible    id=name
    # Chờ cho phần tử email xuất hiện
    Wait Until Element Is Visible    id=email
    # Chờ cho phần tử kết quả có thể tương tác
    # Kiểm tra thông tin hiển thị
    Element Should Contain    id=name    ${VALID_USER}
    # Kiểm tra email hiển thị
    Element Should Contain    id=email    ${VALID_EMAIL}
