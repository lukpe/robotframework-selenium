from robot.api.deco import keyword


@keyword
def get_test_product_details(product="Camera1"):

    products = {
        "Camera1": {"name": "Canon EOS 5D", "price": "$98.00"},
        "Smartphone1": {"name": "HTC Touch HD", "price": "$122.00"},
        "Smartphone2": {"name": "iPhone", "price": "$123.20"},
        "Smartphone3": {"name": "Palm Treo Pro", "price": "$337.99"},
        "Tablet1": {"name": "Samsung Galaxy Tab", "price": "$241.99"},
        "Monitor1": {"name": "Samsung SyncMaster 941BW", "price": "$242.00"},
    }

    return {"name": products[product]["name"], "price": products[product]["price"]}
