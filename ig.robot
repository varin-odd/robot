*** Settings ***
Library  String
Library  OperatingSystem
Library  SeleniumLibrary
Variables  config.py

*** Variables ***
${MAXCLICK}     9999999

*** Test Cases ***
Looping for comment
    Delete Junk Files
    Login
    Turn off Notifications
    Go To Post Id
    Click Plus Icon
    Save Result
    Summary Result
    Ending
    [Teardown]    Close Browser

*** Keywords ***
Delete Junk Files
    Remove Files  selenium-screenshot-*.png

Login
    Open Browser  https://www.instagram.com/accounts/login/?source=auth_switcher
    ...  browser=gc
    Wait Until Element Is Visible  name:username
    Input Text  name:username  ${IG_USER}
    Wait Until Element Is Visible  name:password
    Input Text  name:password  ${IG_PASS}
    Wait Until Element Is Visible
    ...  xpath://*[@id="react-root"]/section/main/div/article/div/div[1]/div/form/div[4]/button/div
    Click Element
    ...  xpath://*[@id="react-root"]/section/main/div/article/div/div[1]/div/form/div[4]/button/div

Turn off Notifications
    Wait Until Element Is Visible  xpath:/html/body/div[3]/div/div/div[3]/button[2]
    Click Element  xpath:/html/body/div[3]/div/div/div[3]/button[2]

Go To Post Id
    Go To  https://www.instagram.com/p/${IG_POSTID}/

Click Plus Icon
    :FOR  ${i}  IN RANGE  ${MAXCLICK}
    \   Log To Console  หน้า ${i}
    \   ${result}  ${condition}=  Run Keyword And Ignore Error  Wait Until Element Is Visible
    ...  xpath://*[@id="react-root"]/section/main/div/div/article/div[2]/div[1]/ul/li/div/button/span
    ...  timeout=3  error=false
    \   Exit For Loop IF  '${condition}'=='false'
    \   Click Element
    ...  xpath://*[@id="react-root"]/section/main/div/div/article/div[2]/div[1]/ul/li/div/button/span
    #Log To Console  exit at ${i} ${result}

Save Result
    ${count}=  Get Element Count
    ...  xpath://*[@id="react-root"]/section/main/div/div/article/div[2]/div[1]/ul/ul
    Log To Console  ${count} คอมเม้นท์

    Remove File  ./ig.log
    : FOR  ${i}  IN RANGE  1  ${count}+1
    \    ${result}=    Get Element Attribute
    ...  xpath://*[@id="react-root"]/section/main/div/div/article/div[2]/div[1]/ul/ul[${i}]/div/li/div/div/div[2]/span
    ...  innerHTML
    \    Append To File  ./ig.log  ${result}\n

Summary Result
    Remove File  ./ig_sum.txt

    ${results}=  Grep File  ./ig.log  ${HASHTAG_1} 
    ${count}=    Get Line Count    ${results}
    Log To Console  ${HASHTAG_1}: ${count}
    Append To File  ./ig_sum.txt  ${HASHTAG_1}: ${count}\n

    ${results}=  Grep File  ./ig.log  ${HASHTAG_2} 
    ${count}=    Get Line Count    ${results}
    Log To Console  ${HASHTAG_2}: ${count}
    Append To File  ./ig_sum.txt  ${HASHTAG_2}: ${count}\n

    ${results}=  Grep File  ./ig.log  ${HASHTAG_3}
    ${count}=    Get Line Count    ${results}
    Log To Console  ${HASHTAG_3}: ${count}
    Append To File  ./ig_sum.txt  ${HASHTAG_3}: ${count}\n

Ending
    Log To Console  The End