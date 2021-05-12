*** Settings ***
Documentation    Cart page
Library    SeleniumLibrary
Library    Collections
Library    FakerLibrary    locale=en_US
Library    ../Resources/TestDataLibrary.py
Resource    HomePage.robot


*** Variables ***
${CART_NAME}    xpath://div[@id='checkout-cart']//tbody//td[2]
${CART_PRICE}    xpath://div[@id='checkout-cart']//tbody//td[5]
${CHECKOUT}    link:Checkout
# *** Step 1: Checkout Options ***
${RADIO_GUEST}    css:input[type='radio'][name='account'][value='guest']
${RADIO_REGISTER}    css:input[type='radio'][name='account'][value='register']
${CONTINUE_ACCOUNT}    id:button-account
# *** Step 2: Billing Details ***
# *** Your Personal Details ***
&{BILLING_DETAILS}
...    firstname=id:input-payment-firstname
...    lastname=id:input-payment-lastname
...    email=id:input-payment-email
...    phone= id:input-payment-telephone
# *** Your Address ***
...    company=id:input-payment-company
...    address1=id:input-payment-address-1
...    address2=id:input-payment-address-2
...    city=id:input-payment-city
...    postcode=id:input-payment-postcode
...    country=id:input-payment-country
...    zone=id:input-payment-zone
# My delivery and billing addresses are the same.
${CHECKBOX_SHIPPING_ADDRESS}    css:input[type='checkbox'][name='shipping_address']
${CONTINUE_GUEST}    id:button-guest
# *** Step 3: Delivery Details  ***
&{SHIPPING_DETAILS}
...    firstname=id:input-shipping-firstname
...    lastname=id:input-shipping-lastname
...    company=id:input-shipping-company
...    address1=id:input-shipping-address-1
...    address2=id:input-shipping-address-2
...    city=id:input-shipping-city
...    postcode=id:input-shipping-postcode
...    country=id:input-shipping-country
...    zone=id:input-shipping-zone
${CONTINUE_GUEST_SHIPPING}    id:button-guest-shipping
# *** Step 4: Delivery Method ***
${COMMENTS_SHIPPING}    css:#collapse-shipping-method textarea[name='comment']
${CONTINUE_SHIPPING_METHOD}    id:button-shipping-method
# *** Step 5: Payment Method  ***
${COMMENTS_PAYMENT}    css:#collapse-payment-method textarea[name='comment']
# I have read and agree to the Terms & Conditions
${CHECKBOX_AGREE}    css:input[type='checkbox'][name='agree']
${CONTINUE_PAYMENT_METHOD}    id:button-payment-method
# *** Step 6: Confirm Order ***
${TABLE}    css:#checkout-checkout table
${TABLE_PRODUCT_NAME}    css:.table.table-bordered.table-hover a
${TABLE_UNIT_PRICE}    css:#checkout-checkout tbody td:nth-child(4)
${CONFIRM_ORDER}    id:button-confirm
${CONFIRM_MESSAGE}    xpath://h1[contains(text(),'Your order has been placed!')]


*** Keywords ***
Verify Cart Contents
    [Documentation]    Verify if selected product is in the shopping cart
    [Arguments]    ${product}
    ${details}    Get Test Product Details    ${product}
    Wait Until Element Contains    ${cart}    ${details}[price]
    Click Element    ${cart}
    Click Link    ${view_cart}
    Sleep    1
    Element Should Contain    ${CART_NAME}    ${details}[name]
    Element Should Contain    ${CART_PRICE}    ${details}[price]

Proceed Guest Purchase    # robocop: disable=uneven-indent,too-many-calls-in-keyword
    [Documentation]    Proceed purchase using guest account
    [Arguments]    ${product}
    Click Link    ${CHECKOUT}
    Set Client Guest
    Fill Billing Details
    Click Element    ${CHECKBOX_SHIPPING_ADDRESS}
    Click Button    ${CONTINUE_GUEST}
    Fill Address Data    &{SHIPPING_DETAILS}
    Click Button    ${CONTINUE_GUEST_SHIPPING}
    Fill Delivery Method
    Fill Payment Method
    Verify And Confirm Order    ${product}

Set Client ${type}
    [Documentation]    Set client type
    IF    """${type}""" == """Guest"""
        Wait Until Element Is Visible    ${RADIO_GUEST}
        Click Element    ${RADIO_GUEST}
    ELSE IF   """${type}""" == """Register"""
        Wait Until Element Is Visible    ${RADIO_REGISTER}
        Click Element    ${RADIO_REGISTER}
    END
    Click Button    ${CONTINUE_ACCOUNT}

Fill Billing Details
    [Documentation]    Fill billing details
    ${email}    FakerLibrary.Email
    # Firefox fix
    # Scroll Element Into View    ${billing_details}[email]
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight);
    Sleep    1
    Input Text    ${billing_details}[email]    ${email}
    ${phone}    FakerLibrary.Phone Number
    Input Text    ${billing_details}[phone]    ${phone}
    Fill Address Data    &{BILLING_DETAILS}

Fill Address Data  # robocop: disable=uneven-indent,too-many-calls-in-keyword
    [Documentation]    Fill client personal and address data
    [Arguments]    &{input}
    Wait Until Element Is Visible    ${input}[firstname]
    ${firstname}    FakerLibrary.First Name
    Input Text    ${input}[firstname]    ${firstname}
    ${lastname}    FakerLibrary.Last Name
    Input Text    ${input}[lastname]    ${lastname}
    ${company}    FakerLibrary.Company
    Input Text    ${input}[company]    ${company}
    ${address1}    FakerLibrary.Address
    Input Text    ${input}[address1]    ${address1}
    ${address2}    FakerLibrary.Address
    Input Text    ${input}[address2]    ${address2}
    ${city}    FakerLibrary.City
    Input Text    ${input}[city]    ${city}
    ${postcode}    FakerLibrary.Postalcode
    Input Text    ${input}[postcode]    ${postcode}
    Select Random List Option    ${input}[country]
    # Wait for 'Region / State' list to load after selecting country
    Sleep    1
    Select Random List Option    ${input}[zone]

Select Random List Option
    [Documentation]    Select random option from a list
    [Arguments]    ${element}
    @{options}    Get List Items    ${element}
    Remove From List    ${options}    0
    ${length}    Get Length    ${options}
    ${option}    Evaluate    random.choice(${options})    random
    IF    ${length} == 1
        Select From List By Index    ${element}    1
    ELSE
        Select From List By Label    ${element}    ${option}
    END

Fill Delivery Method
    [Documentation]    Fill delivery method details
    Fill Comments    ${COMMENTS_SHIPPING}
    Click Button    ${CONTINUE_SHIPPING_METHOD}

Fill Payment Method
    [Documentation]    Fill paymen method details
    Fill Comments    ${COMMENTS_PAYMENT}
    Click Element    ${CHECKBOX_AGREE}
    Click Element    ${CONTINUE_PAYMENT_METHOD}

Fill Comments
    [Documentation]    Fill comments
    [Arguments]    ${element}
    ${comments}    FakerLibrary.Text
    Wait Until Element Is Visible    ${element}
    Input Text    ${element}    ${comments}

Verify And Confirm Order
    [Documentation]    Verify order summary nad confirm the order
    [Arguments]    ${product}
    ${details}    Get Test Product Details    ${product}
    Wait Until Element Is Visible    ${TABLE}
    Wait Until Element Contains    ${TABLE_PRODUCT_NAME}    ${details}[name]
    # FIXME: Changing unit price
    # Element Text Should Be   ${TABLE_UNIT_PRICE}    ${details}[price]
    Click Button    ${CONFIRM_ORDER}
    Wait Until Element Is Visible    ${CONFIRM_MESSAGE}
