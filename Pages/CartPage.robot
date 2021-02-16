*** Settings ***
Library    SeleniumLibrary
Library    Collections    
Library    FakerLibrary    locale=en_US
Library    ../Resources/TestDataLibrary.py      
Resource    HomePage.robot

*** Variables ***
${cart_name}    xpath://div[@id='checkout-cart']//tbody//td[2]
${cart_price}    xpath://div[@id='checkout-cart']//tbody//td[5]
${checkout}    link:Checkout
# *** Step 1: Checkout Options ***
${radio_guest}    css:input[type='radio'][name='account'][value='guest']
${radio_register}    css:input[type='radio'][name='account'][value='register']
${continue_account}    id:button-account
# *** Step 2: Billing Details ***
# *** Your Personal Details ***
&{billing_details}    
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
${checkbox_shipping_address}    css:input[type='checkbox'][name='shipping_address']
${continue_guest}    id:button-guest
# *** Step 3: Delivery Details  ***
&{shipping_details}
...    firstname=id:input-shipping-firstname
...    lastname=id:input-shipping-lastname
...    company=id:input-shipping-company
...    address1=id:input-shipping-address-1
...    address2=id:input-shipping-address-2
...    city=id:input-shipping-city
...    postcode=id:input-shipping-postcode
...    country=id:input-shipping-country
...    zone=id:input-shipping-zone
${continue_guest_shipping}    id:button-guest-shipping
# *** Step 4: Delivery Method ***
${comments_shipping}    css:#collapse-shipping-method textarea[name='comment']
${continue_shipping_method}    id:button-shipping-method
# *** Step 5: Payment Method  ***
${comments_payment}    css:#collapse-payment-method textarea[name='comment']
# I have read and agree to the Terms & Conditions
${checkbox_agree}    css:input[type='checkbox'][name='agree']
${continue_payment_method}    id:button-payment-method
# *** Step 6: Confirm Order ***
${table}    css:#checkout-checkout table
${table_product_name}    css:.table.table-bordered.table-hover a
${table_unit_price}    css:#checkout-checkout tbody td:nth-child(4)
${confirm_order}    id:button-confirm
${confirm_message}    xpath://h1[contains(text(),'Your order has been placed!')]


*** Keywords ***
Verify Cart Contents
    [Arguments]    ${product}
    ${details}    Get Test Product Details    ${product}
    Wait Until Element Contains    ${cart}    ${details}[price]
    Click Element    ${cart}
    Click Link    ${view_cart}
    Element Should Contain    ${cart_name}    ${details}[name]
    Element Should Contain    ${cart_price}    ${details}[price]
    
Proceed Guest Purchase
    [Arguments]    ${product}
    Click Link    ${checkout}
    Wait Until Element Is Visible    ${radio_guest}    
    Click Element    ${radio_guest}
    Click Button    ${continue_account}
    Fill Billing Details
    Click Element    ${checkbox_shipping_address}
    Click Button    ${continue_guest}
    Fill Address Data    &{shipping_details}
    Click Button    ${continue_guest_shipping}
    Fill Delivery Method
    Fill Payment Method
    Verify and Confirm Order    ${product}
    
Fill Billing Details
    ${email}    FakerLibrary.Email
    # Firefox fix
    Mouse Over    ${billing_details}[email]
    Input Text    ${billing_details}[email]    ${email}
     ${phone}    FakerLibrary.Phone Number
    Input Text    ${billing_details}[phone]    ${phone}
    Fill Address Data    &{billing_details}

Fill Address Data
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
    [Arguments]    ${element}
    @{options}    Get List Items    ${element}
    Remove From List    ${options}    0
    ${length}    Get Length    ${options}
     ${option}    Evaluate    random.choice(${options})    random
    Run Keyword If    ${length} == 1
    ...    Select From List By Index    ${element}    1
    ...    ELSE
    ...    Select From List By Label    ${element}    ${option}
           
Fill Delivery Method
    Fill Comments    ${comments_shipping}
    Click Button    ${continue_shipping_method}
    
Fill Payment Method
    Fill Comments    ${comments_payment}
    Click Element    ${checkbox_agree}    
    Click Element    ${continue_payment_method}    

Fill Comments
    [Arguments]    ${element}
    ${comments}    FakerLibrary.Text
    Wait Until Element Is Visible    ${element}    
    Input Text    ${element}    ${comments}
    
Verify and Confirm Order
    [Arguments]    ${product}
    ${details}    Get Test Product Details    ${product}
    Wait Until Element Is Visible    ${table}    
    Element Text Should Be   ${table_product_name}    ${details}[name]    
    # TODO: Changing unit price
    # Element Text Should Be   ${table_unit_price}    ${details}[price]
    Click Button    ${confirm_order}
    Wait Until Element Is Visible    ${confirm_message}    
