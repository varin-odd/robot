*** Settings ***
Library  String
Library  OperatingSystem
Library  SeleniumLibrary
Variables  config.py

*** Variables ***
${MAXCLICK}     9999999

*** Test Cases ***
Valid Login
    Delete Junk Files
    Go To Hashtag Id
    Scroll Page
    Save Result
    Summary Result
    Ending
    [Teardown]  Close Browser

*** Keywords ***
Delete Junk Files
    Remove Files  selenium-screenshot-*.png

Go To Hashtag Id
    ${url}=  Replace String
    ...  https://twitter.com/search?q=(${HASHTAG_1}%20OR%20${HASHTAG_2}%20OR%20${HASHTAG_3})
    ...  \#  %23
    Open Browser  ${url}  browser=gc
    Wait Until Element Is Visible  id:signin-link
    Click Link  id:signin-link

Internal Scroll Page
    [Arguments]  ${count}
    :FOR    ${i}    IN RANGE    12
    \   Sleep  0.25s
    \   ${cnt}=  Get Element Count
    ...  xpath://*[contains(@id, 'stream-item-tweet-')]/div/div[2]/div[2]/p
    \   Exit For Loop If  ${count} != ${cnt}
    [Return]  ${cnt}

Scroll Page
    :FOR    ${i}    IN RANGE    ${MAXCLICK}
    \   ${count}=  Get Element Count
    ...  xpath://*[contains(@id, 'stream-item-tweet-')]/div/div[2]/div[2]/p
    \   Log To Console  ${count} คอมเม้นท์
    \   Execute JavaScript  window.scrollTo(0, 999999999)
    \   ${cnt}=  Internal Scroll Page  ${count}
    \   Exit For Loop If  ${count} == ${cnt}

Save Result
    ${count}=  Get Element Count
    ...  xpath://*[contains(@id, 'stream-item-tweet-')]/div/div[2]/div[2]/p
    Log To Console  ${count} คอมเม้นท์

    Remove File  ./tw.log
    @{elems}=  Get WebElements  //*[contains(@id, 'stream-item-tweet-')]/div/div[2]/div[2]/p
    : FOR  ${elem}  IN  @{elems}
    \    ${result}=  Get Element Attribute  ${elem}  innerText
    \    ${str}=  Replace String  ${result}  \n  <br>
    \    Append To File  ./tw.log  ${str}\n

Summary Result
    Remove File  ./tw_sum.txt
    ${results}=  Grep File  ./tw.log  ${HASHTAG_1} 
    ${count}=    Get Line Count    ${results}
    Log To Console  ${HASHTAG_1}: ${count}
    Append To File  ./tw_sum.txt  ${HASHTAG_1}: ${count}\n

    ${results}=  Grep File  ./tw.log  ${HASHTAG_2} 
    ${count}=    Get Line Count    ${results}
    Log To Console  ${HASHTAG_2}: ${count}
    Append To File  ./tw_sum.txt  ${HASHTAG_2}: ${count}\n

    ${results}=  Grep File  ./tw.log  ${HASHTAG_3}
    ${count}=    Get Line Count    ${results}
    Log To Console  ${HASHTAG_3}: ${count}
    Append To File  ./tw_sum.txt  ${HASHTAG_3}: ${count}\n

Ending
    Log To Console  The End