# Assignment on AP Dataset

SELECT * 
FROM vendors;

SELECT *
FROM invoices
;

SELECT *
FROM general_ledger_accounts
;

SELECT *
FROM invoice_line_items
;

-- 1. 
SELECT *
FROM vendors
INNER JOIN
invoices
ON vendors.vendor_id = invoices.vendor_id
;

-- 2.
SELECT v.vendor_name, i.invoice_number, i.invoice_date, 
(i.invoice_total-i.payment_total+i.credit_total) AS balance_due
FROM vendors v 
JOIN invoices i 
ON v.vendor_id = i.vendor_id
ORDER BY vendor_name ASC
;

-- 3.
SELECT v.vendor_name, v.default_account_number AS default_account,
g.account_description 
FROM vendors v
JOIN
general_ledger_accounts g 
ON
v.default_account_number = g.account_number
ORDER BY 
account_description ASC, vendor_name ASC
;

-- 4.

SELECT v.vendor_name, i.invoice_date,
li.invoice_sequence
FROM vendors v 
JOIN 
invoices i 
ON
v.vendor_id = i.vendor_id
LEFT JOIN
invoice_line_items li 
ON
i.invoice_id = li.invoice_id
ORDER BY
vendor_name ASC, invoice_date, invoice_number DESC, invoice_sequence 
;

-- 5a. 
SELECT
v1.vendor_id,
v1.vendor_name,
CONCAT(v1.vendor_contact_first_name,' ',v1.vendor_contact_last_name) AS contact_name
FROM
vendors v1
JOIN
vendors v2 
ON
v1.vendor_contact_last_name = v2.vendor_contact_last_name
AND
v1.vendor_id <> v2.vendor_id
ORDER BY
v1.vendor_id
;

-- 5b.
SELECT
invoice_number, invoice_date, 
(invoice_total-payment_total+credit_total) AS balance_due,
payment_date
FROM
invoices
WHERE payment_date IS NULL
;

-- 6.
SELECT
g.account_number,
g.account_description
FROM
general_ledger_accounts g 
LEFT JOIN invoice_line_items i
ON
g.account_number = i.account_number
WHERE i.invoice_id IS NULL 
ORDER BY 
g.account_number
;

-- 7. 
SELECT 
    vendor_name, 
    'CA' AS vendor_state
FROM 
    Vendors
WHERE 
    vendor_state = 'CA'

UNION

SELECT 
    vendor_name, 
    'Outside CA' AS vendor_state
FROM 
    Vendors
WHERE 
    vendor_state <> 'CA'

ORDER BY 
    vendor_name;






