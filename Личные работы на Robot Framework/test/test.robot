*** Settings ***
Resource         ./keywords.resource
Test Setup       Preconditions: Open browser and maximize window
Test Teardown    Postconditions: Close browser


*** Test Cases ***
Прогон сайта brainy.run
    [Documentation]    Попытка добавить курс в корзину, при неудаче - авторизоваться в аккаунт и повторить действие. Затем совершить прогон по функционалу сайта

    Wait Until Page Contains Element   css:li.menu-item-8735 

    Mouse Over    css:li.menu-item-8735
    
    Click Element    //*[@id="menu-item-8737"]/a

    Scroll Element Into View    //*[@id="content"]/div/section[4]/div/div[2]/div

    Click Element    //*[@id="content"]/div/section[3]/div/div[4]/div/div/div/div/a                    #Попытка добавить курс в корзину

    Click Button    //*[@id="content"]/div/div/div/aside/div/div[1]/div[1]/form/button

    ${is_user_authorized}=    
    ...    Run Keyword And Return Status    
    ...    Wait Until Element Is Visible    //*[@id="tutor-login-form"]/div[4]/a                       #Если пользователь не авторизован, то условие выполняется и запускается кейворд авторизации

    IF  ${is_user_authorized}

        Log in                                                                                         #Кейворд авторизации написанный в ./keywords.resource

    END

    Go To    https://brainy.run/courses/godot-basics/
    
    Wait Until Element Is Visible    //*[@id="content"]/div/div/div/aside/div/div[1]/div[1]/form/button

    Click Button    //*[@id="content"]/div/div/div/aside/div/div[1]/div[1]/form/button                 #Не посредственно сам процесс добавления курса в корзину

    Wait Until Element Is Visible    //*[@id="content"]/div/div/div/aside/div/div[1]/div[1]/a

    Delete course from cart                                                                            #Кейворд, удаляющий курс из корзины

    Go To    url=${url}

    Wait Until Page Contains Element    css:div.navbar-utils

    Mouse Over    css:div.navbar-utils

    Click Element    //*[@id="page"]/header/nav/div[4]/div/div[3]/div[2]/ul/li[1]/a

    Wait Until Page Contains Element    css:ul.tutor-dashboard-permalinks

    @{rating_settings}=    Get WebElements    css:ul.tutor-dashboard-permalinks

    FOR  ${setting}  IN    @{rating_settings}

        Click Element    locator=${setting}    modifier=CTRL

        Sleep    3s
    
    END

    Log out                                                                                            #Кейворд, выполняющий выход из аккаунта


#Этот код был представлен непосредственно для того, чтобы показать, что я умею(это лишь минимум моих знаний и возможностей)
#Я умею составлять css-селекторы, XPath. Но для циклов FOR и WHILE на этом сайте я, к сожалению, применений не нашел