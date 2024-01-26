// Group Key
const groupEmail = "members@atlantanpuo.org";

/*
 * This function updates group membership 
 * if the subscribe to emails column on the 
 * spreadsheet is edited
*/
function updateSubscriptions(e) {
  const sheet = e.source;
  const data = sheet.getDataRange().getValues();
  const row = e.range.getRow() - 1;
  const userEmail = data[row][1];
  const subscribeOrNot = data[row][9];
  if(subscribeOrNot.toString().toLowerCase().trim() == "yes") {
    console.info(`Adding ${userEmail} to members`);
    addMemberToGroup(userEmail)
    return;
  }
  if(subscribeOrNot.toString().toLowerCase().trim() == "no") {
    console.info(`Removing ${userEmail} from members`);
    removeMemberFromGroup(userEmail)
    return;
  }
}

/*
 * This function adds a new member if they checked 
 * yes on the subscribe to emails question when 
 * submitting the form
*/
function addMemberOnFormSubmit(e) {
  const userEmail = e.namedValues['Email Address'][0];
  const shouldSubscribe = e.namedValues['Subscribe to Emails'].toString().toLowerCase().trim() == "yes";
  if(shouldSubscribe) {
    console.info(`Adding ${userEmail} to members`);
    addMemberToGroup(userEmail)
  } else {
    console.info(`Skipping ${userEmail}. User does not want to subscribe`);
  }
  return;
}

/*
 * Helper function to remove a user from the members group
*/
function removeMemberFromGroup(userEmail) {
  AdminDirectory.Members.remove(groupEmail, userEmail)
}

/*
 * Helper function to add a user to the members group
*/
function addMemberToGroup(userEmail) {
  const member = {
    email: userEmail,
    role: 'MEMBER'
  }
  AdminDirectory.Members.insert(member, groupEmail)
}