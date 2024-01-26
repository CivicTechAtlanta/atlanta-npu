## Google Sheet

### Columns:

```
Timestamp
Email Address
Phone Number
First Name
Last Name or Business Name
Address Line 1
Address Line 2
Zipcode
Neighborhood
Subscribe to Emails
```

### Scripts

- `code.gs`:
  - Functions to manage subscriptions via "Subscribe to Emails" field
    - On Spreadsheet Edit:
      - `updateSubscriptions`: This function updates group membership if the "Subscribe to Emails" field is edited in the spreadsheet
    - On Google Form Submission:
      - `addMemberOnFormSubmit`: This function adds a new member if they selected "Yes" for "Subscribe to Emails" question when submitting the form
      - `removeMemberFromGroup`: This function removes a user from the members group if they selected "No" on the "Subscribe to Emails" question when submitting the form
  - `addMemberToGroup`: Helper function to add a user to the members group
- `macros.gs`: contains single macro, `Removeduplicates`.  This is run daily at ~11 PM
- `appsscript.json`: This is an Apps Script project manifest, which is a special JSON file that specifies a basic project information that Apps Script needs to run the script successfully.  More info [here](https://developers.google.com/apps-script/concepts/manifests)

Triggers mentioned above:

![](assets/triggers.png)

### Lineage Diagram

Generated initial mermaid code below with this ChatGPT prompt: https://chat.openai.com/share/88eac177-32d9-420c-8fe8-0ac391117ca1

```mermaid
graph TD
    subgraph GoogleSheet["Membership Application (Responses) Google Sheet"]
    Timestamp -->|Data Source| Email_Address
    Email_Address -->|Data Source| Phone_Number
    Phone_Number -->|Data Source| First_Name
    First_Name -->|Data Source| Last_Name_or_Business_Name
    Last_Name_or_Business_Name -->|Data Source| Address_Line_1
    Address_Line_1 -->|Data Source| Address_Line_2
    Address_Line_2 -->|Data Source| Zipcode
    Zipcode -->|Data Source| Neighborhood
    Neighborhood -->|Data Source| Subscribe_to_Emails
    end

    subgraph Code.gs
    updateSubscriptions -->|Uses| sheet
    sheet -->|Gets Data| data
    data -->|Indexed Access| userEmail
    data -->|Indexed Access| subscribeOrNot
    userEmail -->|Parameter| addMemberToGroup
    userEmail -->|Parameter| removeMemberFromGroup
    subscribeOrNot -->|Control Flow| addMemberToGroup
    subscribeOrNot -->|Control Flow| removeMemberFromGroup
    addMemberOnFormSubmit -->|Uses| userEmail
    userEmail -->|Parameter| addMemberToGroup
    addMemberToGroup -->|API Call| AdminDirectory_Members_Insert
    removeMemberFromGroup -->|API Call| AdminDirectory_Members_Remove
    end

    subgraph macros.gs
    RemoveDuplicates -->|Manipulates| spreadsheet
    spreadsheet -->|Access| currentCell
    currentCell -->|Set As| activeCell
    spreadsheet -->|Removes| duplicates
    end
```
