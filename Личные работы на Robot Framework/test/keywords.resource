*** Settings ***
Resource    ./variables.resource


*** Keywords ***
Preconditions: Open browser and maximize window
    [Documentation]    Открыть браузер во весь экран

    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window


Postconditions: Close browser
    [Documentation]    Закрыть браузер по окончании автотеста

    Close Browser


Log in
    [Documentation]    Кейворд, совершающий авторизацию на сайте 

    Go To    url=https://brainy.run/my-account/

    Wait Until Element Is Visible    //*[@id="page"]/section    timeout=3s
    
    Input Text        //*[@id="username"]    text=${login}
    Input Password    //*[@id="password"]    password=${password}
    Click Button      //*[@id="customer_login"]/div[1]/form/p[3]/button


Delete course from cart
    [Documentation]    Кейворд, удаляющий курс из корзины

    Go To    url=https://brainy.run/cart/

    Wait Until Element Is Visible    //*[@id="post-14"]/div/div/div[2]/form/div/div/div[3]/div[2]/a    timeout=3s

    Click Element                    //*[@id="post-14"]/div/div/div[2]/form/div/div/div[3]/div[2]/a


Log out
    [Documentation]    Кейвород на выход из аккаунта

    Go To    url=${url}

    Wait Until Page Contains Element    css:div.navbar-utils

    Mouse Over                          css:div.navbar-utils

    Click Element                       //*[@id="page"]/header/nav/div[4]/div/div[3]/div[3]/ul/li[2]/a