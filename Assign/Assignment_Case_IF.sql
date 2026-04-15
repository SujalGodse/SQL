use northwind;
-- Q1. From orders table, display id, status_id and a column order_status using Simple CASE: 
-- ● 0 → 'New' 
-- ● 1 → 'Processing' 
-- ● 2 → 'Shipped' 
-- ● 3 → 'Closed' 
-- ● anything else → 'Unknown' 
select id,status_id,
case status_id
	when 0 then 'New'
    when 1 then 'Processing'
    when 2 then 'Shipped'
    when 3 then 'Closed'
    else 'Unkonwn'
end as order_status
from orders;

-- Q2. From products table, display product_name, discontinued and a column stock_status using Simple 
-- CASE: 
-- ● 0 → 'Available' 
-- ● 1 → 'Discontinued' 
select product_name, discontinued,
case discontinued 
	when 0 then 'Available'
    when 1 then 'Discontinued'
end as stock_status
from products;

-- Q3. From orders table, display id, payment_type and a column payment_category using Simple CASE: 
-- ● 'Credit Card' → 'Card' 
-- ● 'Cash' → 'Cash' 
-- ● 'Check' → 'Cheque' 
-- ● else → 'Other' 
select id,payment_type,
case payment_type
	when 'Credit Card' then 'Cash'
    when 'Cash' then 'Cash'
    when 'Check' then 'Cheque'
    else 'Others'
end as payment_category
from orders;

-- Q4. From purchase_orders table, display id, status_id and a column po_status using Simple CASE: 
-- ● 0 → 'New' 
-- ● 1 → 'Submitted' 
-- ● 2 → 'Approved' 
-- ● 3 → 'Received' 
-- ● else → 'Closed' 
select id,status_id,
case status_id
	when 0 then 'New' 
	when 1 then 'Submitted' 
	when 2 then 'Approved' 
	when 3 then 'Received' 
	else 'Closed'
end as po_status
from purchase_orders;

-- Q5. From inventory_transaction_types table, display id, type_name and a column transaction_label using 
-- Simple CASE on id: 
-- ● 1 → 'Sold' 
-- ● 2 → 'Purchase' 
-- ● 3 → 'Inventory Adjustment' 
-- ● else → 'Other' 
select id,type_name,
case id
	when 1 then 'Sold' 
	when 2 then 'Purchase' 
	when 3 then 'Inventory Adjustment' 
	else 'Other'
end as transaction_label
from inventory_transaction_types;

-- Q6. From orders table, display id, shipper_id and a column shipper_name using Simple CASE: 
-- ● 1 → 'Shipping Company A' 
-- ● 2 → 'Shipping Company B' 
-- ● 3 → 'Shipping Company C' 
-- ● else → 'Not Assigned' 
select id,shipper_id,
case shipper_id
	when 1 then 'Shipping Company A' 
	when 2 then 'Shipping Company B'  
	when 3 then 'Shipping Company C'  
	else 'Not Assigned'
end as shipper_name
from orders;

-- Q7. From products table, display product_name, reorder_level and a column reorder_flag using Simple 
-- CASE: 
-- ● 0 → 'No Reorder' 
-- ● 10 → 'Low Reorder' 
-- ● 25 → 'Medium Reorder' 
-- ● else → 'Check Manually' 
select product_name,reorder_level,
case reorder_level
	when 0 then 'No Reorder' 
	when 10 then 'Low Reorder'  
	when 25 then 'Medium Reorder'  
	else 'Check Manually'
end as reorder_flag
from products;

-- Q8. From products table, classify list_price into a column price_tier: 
-- ● 0 to 20 → 'Budget' 
-- ● 20 to 100 → 'Standard' 
-- ● above 100 → 'Premium' 
-- ● else → 'Unknown' 
select list_price,
case 
	when list_price between 0 and 20 then 'Budget' 
	when list_price between 20 and 100 then 'Standard'  
	when list_price > 100 then 'Premium'  
	else 'Unknown'
end as price_tier
from products;

-- Q9. From orders table, classify shipping_fee into a column shipping_band: 
-- ● 0 → 'Free' 
-- ● less than 50 → 'Low' 
-- ● 50 to 200 → 'Standard' 
-- ● above 200 → 'Express' 
select shipping_fee,
case 
	when shipping_fee=0 then 'Free' 
	when shipping_fee < 50 then 'Low'  
	when shipping_fee between 50 and 200 then 'Standard' 
    when shipping_fee > 200 then 'Express'
	else 'Not Assigned'
end as shipping_band
from orders;

-- Q10. From orders table, create a column delivery_status: 
-- ● shipped_date IS NULL AND status_id < 2 → 'Awaiting Shipment' 
-- ● shipped_date IS NOT NULL → 'Dispatched' 
-- ● else → 'Check Manually' 
select shipped_date,
case 
	when shipped_date IS NULL AND status_id < 2 then 'Awaiting Shipment'  
    when shipped_date IS NOT NULL then 'Dispatched'
	else 'Check Manually'
end as delivery_status
from orders;

-- Q11. From products table, create a column margin_status using list_price and standard_cost: 
-- ● list_price - standard_cost > 50 → 'High Margin' 
-- ● between 10 and 50 → 'Medium Margin' 
-- ● less than 10 → 'Low Margin' 
-- ● standard_cost IS NULL → 'No Cost Data' 
select * from products;
select list_price,
case 
	when list_price - standard_cost > 50 then 'High Margin' 
	when list_price - standard_cost between 10 and 50 then 'Medium Margin'  
	when list_price - standard_cost < 10 then 'Low Margin'
    when standard_cost IS NULL then 'No Cost Data'
end as margin_status
from products;

-- Q12. From purchase_orders table, create a column urgency_level based on expected_date: 
-- ● NULL → 'No Date Set' 
-- ● already passed → 'Overdue' 
-- ● within 7 days → 'Urgent' 
-- ● within 30 days → 'Upcoming' 
-- ● beyond 30 days → 'Planned' 
select expected_date,
case
	when expected_date is null then 'No Date Set'
    when submitted_date > expected_date then 'Overdue'
    when timestampdiff(day,expected_date,now()) <= 7 then 'Urgent'
    when timestampdiff(day,expected_date,now()) <= 30 then 'Upcoming'
    when timestampdiff(day,expected_date,now()) > 30 then 'Planned'
end as urgency_level
from purchase_orders;

-- Q13. From order_details table, classify discount into a column discount_category: 
-- ● 0 → 'No Discount' 
-- ● greater than 0 and up to 0.1 → 'Small Discount' 
-- ● greater than 0.1 and up to 0.3 → 'Medium Discount' 
-- ● above 0.3 → 'Heavy Discount' 
select discount,
case 
	when discount = 0 then 'No Discount'
    when discount between 0 and 0.1 then 'Small Discount'
    when discount between 0.1 and 0.3 then 'Medium Discount'
    when discount > 0.3 then 'Heavy Discount'
end as discount_category
from order_details;

-- Q14. From customers table, create a column contact_availability: 
-- ● mobile_phone IS NOT NULL → 'Mobile Available' 
-- ● home_phone IS NOT NULL → 'Home Available' 
-- ● business_phone IS NOT NULL → 'Work Available' 
-- ● all NULL → 'No Contact' 
select case 
when mobile_phone IS NOT NULL then 'Mobile Available'
when home_phone IS NOT NULL then 'Home Available'
when business_phone IS NOT NULL then 'Work Available'
when mobile_phone is null and home_phone is null and business_phone is null then 'No Contact'
end as contact_availability
from customers;

-- Q15. From products table, create a column product_flag: 
-- ● discontinued = 1 → 'Discontinued' 
-- ● active AND list_price > 100 → 'Active - Premium' 
-- ● active AND list_price > 20 → 'Active - Standard' 
-- ● active AND list_price <= 20 → 'Active - Budget' 
select discontinued,list_price,
case 
	when discontinued = 1 then 'Discontinued'
	when discontinued = 0 and list_price > 100 then 'Active - Premium'
    when discontinued = 0 and list_price > 20 then 'Active - Standard'
    when discontinued = 0 and list_price <= 20 then 'Active - Budget'
end as product_flag
from products;

-- Q16. From orders table, create a column order_classification: 
-- ● employee_id IS NULL → 'Unassigned' 
-- ● assigned AND shipping_fee = 0 → 'Assigned - Free Ship' 
-- ● assigned AND shipping_fee < 100 → 'Assigned - Low Fee' 
-- ● assigned AND shipping_fee >= 100 → 'Assigned - High Fee' 
select employee_id,shipping_fee,
case 
	when employee_id IS NULL then 'Unassigned'
	when employee_id is not null AND shipping_fee = 0 then 'Assigned - Free Ship' 
	when employee_id is not null AND shipping_fee < 100 then 'Assigned - Low Fee' 
	when employee_id is not null AND shipping_fee >= 100 then 'Assigned - High Fee' 
end as order_classification
from orders;

-- Q17. From products table, create a column profit_flag: 
-- ● discontinued = 1 → 'Discontinued' 
-- ● active AND list_price > standard_cost * 2 → 'High Profit' 
-- ● active AND list_price > standard_cost → 'Normal Profit' 
-- ● active AND list_price <= standard_cost → 'Loss!' 
-- ● standard_cost IS NULL → 'No Cost Info' 
select discontinued,list_price,
case 
	when discontinued = 1 then 'Discontinued'
	when discontinued = 0 and list_price > standard_cost * 2 then 'High Profit' 
    when discontinued = 0 and list_price > standard_cost then 'Normal Profit'
    when discontinued = 0 and list_price <= standard_cost then 'Loss!'
    when standard_cost IS NULL then 'No Cost Info' 
end as product_flag
from products;

-- Q18. From purchase_orders table, create a column po_classification: 
-- ● supplier_id IS NULL → 'No Supplier' 
-- ● supplier assigned AND payment_amount > 1000 → 'Large Order' 
-- ● supplier assigned AND payment_amount > 500 → 'Medium Order' 
-- ● supplier assigned AND payment_amount <= 500 → 'Small Order' 
-- ● payment_amount IS NULL → 'Payment Not Set' 
select supplier_id,payment_amount,
case 
	when supplier_id IS NULL then 'No Supplier' 
	when supplier_id is not null AND payment_amount > 1000 then 'Large Order' 
	when supplier_id is not null AND payment_amount > 500 then 'Medium Order' 
	when supplier_id is not null AND payment_amount <= 500 then 'Small Order' 
	when payment_amount IS NULL then 'Payment Not Set'  
end as po_classification
from purchase_orders;

-- Q19. From orders table, create a column tax_shipping_flag: 
-- ● taxes > 0 AND shipping_fee > 0 → 'Taxed + Paid Shipping' 
-- ● taxes > 0 AND shipping_fee = 0 → 'Taxed + Free Shipping' 
-- ● taxes = 0 AND shipping_fee > 0 → 'No Tax + Paid Shipping'
select  taxes,shipping_fee,
case 
	when taxes > 0 AND shipping_fee > 0 then 'Taxed + Paid Shipping' 
	when taxes > 0 AND shipping_fee = 0 then 'Taxed + Free Shipping' 
	when taxes = 0 AND shipping_fee > 0 then 'No Tax + Paid Shipping'
    when taxes = 0 AND shipping_fee = 0 then 'No Tax + Free Shipping' 
end as tax_shipping_flag
from orders;

-- Q20. From customers table, create a column customer_region_flag: 
-- ● country_region IS NULL → 'No Country Data' 
-- ● country is USA AND state_province IS NOT NULL → 'USA - State Known' 
-- ● country is USA AND state_province IS NULL → 'USA - State Unknown' 
-- ● any other country → 'International' 
select country_region,state_province,
case 
	when country_region IS NULL then 'No Country Data' 
	when country_region = 'USA' AND state_province IS NOT NULL then 'USA - State Known' 
	when country_region = 'USA' AND state_province IS NULL then 'USA - State Unknown' 
	else 'International'
end as customer_region_flag
from customers;

-- Q21. From order_details table, create a column line_value_status: 
-- ● quantity IS NULL → 'No Quantity' 
-- ● quantity > 0 AND discount > 0.2 → 'High Qty - Heavy Discount' 
-- ● quantity > 0 AND discount > 0 → 'High Qty - Some Discount' 
-- ● quantity > 0 AND discount = 0 → 'High Qty - Full Price' 
-- ● else → 'Check Record' 
select quantity,discount,
case 
	when quantity IS NULL then 'No Quantity' 
	when quantity > 0 AND discount > 0.2 then 'High Qty - Heavy Discount' 
	when quantity > 0 AND discount > 0 then 'High Qty - Some Discount' 
	when quantity > 0 AND discount = 0 then 'High Qty - Full Price'
end as line_value_status
from order_details;

-- Q22. From products, use IF() to show a column status: 
-- ● discontinued = 1 → 'Discontinued' 
-- ● else → 'Active' 
select product_name, discontinued, 
if (discontinued=1,'Disscontinued','Active') as status
from products;

-- Q23. From orders, use IF() to show a column payment_done: 
-- ● paid_date IS NOT NULL → 'Paid' 
-- ● else → 'Pending'
select 
if(paid_date is not null,'Paid','Pending') as payment_done
from orders;
 
-- Q24. From customers, use IFNULL() to show the city — if NULL show 'City Not Provided'. 
select ifnull(city,'City Not Provided') as city from customers;

-- Q25. From customers, use nested IFNULL() to show a column best_contact: 
-- ● check mobile_phone first 
-- ● then home_phone 
-- ● then business_phone 
-- ● if all NULL → 'No Contact' 
select ifnull(mobile_phone,ifnull(home_phone,ifnull(business_phone,'No Contact'))) as best_contact from customers;

-- Q26. From order_details, use NULLIF() to avoid divide-by-zero: 
-- ● calculate unit_price / quantity 
-- ● if quantity = 0, result should be NULL not an error 
select unit_price / nullif(quantity,0) as safe_division from order_details;

-- Q27. From orders, use IF() inside COUNT() to show in one row: 
-- ● count of paid orders 
-- ● count of unpaid orders 
select count(if(payment_type is null,1,null)) as count_of_paid_orders,count(if(payment_type is not null,1,null)) as count_of_unpaid_orders from orders;

-- Q28. From order_details, use IF() inside SUM() to show in one row: 
-- ● total revenue from discounted items 
-- ● total revenue from full price items 
select sum(if(discount>0,unit_price*quantity-discount,0))as tot_rev_discounted_items,sum(if(discount=0,unit_price*quantity,0))as tot_rev_fullprize_items from order_details;

-- Q29. From products, use IF() with nested IFNULL() to show a column price_display: 
-- ● if standard_cost IS NULL → 'Cost Unknown' 
-- ● if list_price > standard_cost → 'Profit: ' + list_price - standard_cost (use CONCAT) 
-- ● else → 'No Profit' 
select product_name,
if(standard_cost is null, 'Cost Unknown',
   if(list_price > standard_cost,
      concat('Profit: ', list_price - standard_cost),
      'No Profit')) AS price_display
from products;

-- Q30. From orders joined with order_details and products, show customer_id, total amount spent and a 
-- column customer_tier using CASE: 
-- ● spent > 5000 → 'Platinum' 
-- ● spent > 2000 → 'Gold' 
-- ● spent > 500 → 'Silver' 
-- ● else → 'Bronze'





