from robot.api.deco import keyword, library
from random import randint

@keyword
def get_test_product_details(product='Camera'):
    
    products = {
        'Camera':{
            'name':'Canon EOS 5D',
            'price':'$98.00'
        },
        'Smartphone':{
            'name':'iPhone',
            'price':'$123.20'
        },
        'Tablet':{
            'name':'Samsung Galaxy Tab',
            'price':'$241.99'
        }
    }
    
    return  {'name':products[product]['name'], 'price':products[product]['price']}
