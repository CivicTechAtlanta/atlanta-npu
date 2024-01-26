with source as (
  select
    Timestamp,
    Email_Address,
    Phone_Number,
    First_Name,
    Last_Name_or_Business_Name,
    Address_Line_1,
    Address_Line_2,
    Zipcode,
    Neighborhood,
    Subscribe_to_Emails
  from `dev-lambda-412400.dev5.rivery_test`
),

cleaned as (
  select
    CASE
    /* Format: MM/DD/YY HH:MI */
    WHEN REGEXP_CONTAINS(nullif(Timestamp, ''), r'^\d{1,2}/\d{1,2}/\d{2} \d{1,2}:\d{2}$') THEN
      PARSE_TIMESTAMP('%m/%d/%y %H:%M %Z', concat(nullif(Timestamp, ''), ' America/New_York'))
    /* Format: MM/DD/YYYY HH:MI:SS */
    WHEN REGEXP_CONTAINS(nullif(Timestamp, ''), r'^\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}:\d{2}$') THEN
      PARSE_TIMESTAMP('%m/%d/%Y %H:%M:%S %Z', concat(nullif(Timestamp, ''), ' America/New_York'))
    ELSE
      NULL
    END as Timestamp,
    nullif(Email_Address, '') as Email_Address,
    nullif(Phone_Number, '') as Phone_Number,
    nullif(First_Name, '') as First_Name,
    nullif(Last_Name_or_Business_Name, '') as Last_Name_or_Business_Name,
    nullif(Address_Line_1, '') as Address_Line_1,
    nullif(Address_Line_2, '') as Address_Line_2,
    nullif(Zipcode, '') as Zipcode,
    nullif(Neighborhood, '') as Neighborhood,
    nullif(Subscribe_to_Emails, '') as Subscribe_to_Emails,
  from source
)

select *
from cleaned
/* this "where not" statement filters out the rows where all fields are blank */
where not (
  Timestamp is null and
  Email_Address is null and
  Phone_Number is null and
  First_Name is null and
  Last_Name_or_Business_Name is null and
  Address_Line_1 is null and
  Address_Line_2 is null and
  Zipcode is null and
  Neighborhood is null and
  Subscribe_to_Emails is null
)
