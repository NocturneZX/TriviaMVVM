import UIKit

var str = "Hello, playground"


var arbitraryParams: [Int] = [9, 11, 22, 23, 33, 36, 96, 0]

func convertToBinary(aNumber: Int) -> Int{
    var binaryNumber: Int = 0
    var remainder: Int = 0
    var iteration = 1
    
    guard aNumber != 0 else {
        return 0
    }
    
    var decimal: Int = aNumber
    repeat{
        remainder = decimal % 2
        decimal /= 2
        binaryNumber += remainder * iteration
        iteration *= 10
    }while(decimal != 0)
    
    return binaryNumber
}

for x in arbitraryParams{
    print(convertToBinary(aNumber: x))
}


/*
 A.SELECT  customer.ID,
 customer.Name,
 COUNT(orders.Customer) totalOrders
 FROM    Customers customer
 LEFT JOIN Orders orders
 ON customer.ID = orders.Customer
 GROUP   BY customer.ID,
 customer.Name
 
 B.SELECT  customer.ID,
 customer.Name,
 COUNT(orders.Customer) totalOrders
 FROM    Customers customer
 LEFT JOIN Orders orders
 ON customer.ID = orders.Customer
 GROUP   BY customer.ID,
 customer.Name
 HAVING COUNT(orders.Customer) > 3

 C. SELECT  customer.ID,
 customer.Name,
 COUNT(orders.Customer) totalOrders
 FROM    Customers customer
 LEFT JOIN Orders orders
 ON customer.ID = orders.Customer
 WHERE orders.item_name = 'Hellfire Shotguns'
 GROUP   BY customer.ID,
 customer.Name

 D.
 
*/
