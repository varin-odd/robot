*** Settings ***
Library  SeleniumLibrary
Library  SeleniumScreenshots

*** Variables ***

*** Test Cases ***
Capture Moon Math ScreenShot
    Open Moon Math Trolololo
    [Teardown]  Close Browser

*** Keywords ***
Open Moon Math Trolololo
    Open Browser  about:blank  browser=gc
    Set window size  1280  1620
    Go to  https://www.moonmath.win/
    Click Element  xpath://*[@id="headingOne"]/h5/button
    Sleep  1.5s
    Capture and crop page ScreenShot
    ...  moonmath.png
    ...  css:DIV[id='accordion'] > DIV
