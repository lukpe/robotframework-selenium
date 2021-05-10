*** Settings ***
Documentation    Robot Framework/SeleniumLibrary framework 
...              for testing e-commerce page 
...              (http://tutorialsninja.com/demo/)

Resource    Resources/SuiteSetup.robot
Resource    Pages/HomePage.robot
Resource    Pages/SearchResultsPage.robot
Resource    Pages/CartPage.robot
Resource    Pages/ProductPage.robot        

Suite Setup    Before Suite
Suite Teardown    After Suite
Test Teardown    After Test


*** Test Cases ***
Homepage Test
    [Documentation]    Verify critical elements on the homepage
    Check Homepage Elements
    
Search Test
    [Documentation]    Verify product search mechanism
    [Tags]    Search
    Search Camera1
    
Found Page And Cart Test
    [Documentation]    Add a product to the cart from the search results page
    [Tags]    Search    SearchResults    CartPage
    Set Test Variable    ${PRODUCT}    Smartphone1
    Search ${PRODUCT}
    Add Found ${PRODUCT} To Cart
    Verify Cart Contents    ${PRODUCT}

Product Page And Cart Test
    [Documentation]    Add a product to the cart from the product page
    [Tags]    Search    SearchResults    ProductPage    CartPage 
    Set Test Variable    ${PRODUCT}    Tablet1
    Search ${PRODUCT}
    Select Found ${PRODUCT}
    Verify ${PRODUCT} Page    
    Add Product To Cart
    Verify Cart Contents    ${PRODUCT}
    
Product Category Test
    [Documentation]    Check if appropriate products ale listed under a category
    [Tags]    Categories
    Set Test Variable    ${CATEGORY}    Phones & PDAs
    Select Category    ${CATEGORY}
    Verify Product Details    Smartphone1
    Verify Product Details    Smartphone2
    Verify Product Details    Smartphone3
    
Guest Purchase Test
    [Documentation]    Check if a product can be purchased using guest account
    [Tags]    Search    SearchResults    ProductPage    CartPage    GuestAccount    Purchase
    Set Test Variable    ${PRODUCT}    Monitor1
    Search ${PRODUCT}
    Select Found ${PRODUCT}
    Add Product To Cart
    Verify Cart Contents    ${PRODUCT}
    Proceed Guest Purchase    ${PRODUCT}
