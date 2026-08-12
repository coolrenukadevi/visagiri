# Sending enquiries to Google Sheets + Drive

The website's `/contact/` form can save every enquiry into a Google Sheet (one row each) and a Google Drive folder (one file each). This needs a one-time setup in your Google account — about 5 minutes, no coding.

## 1. Create the Sheet

1. Go to [sheets.google.com](https://sheets.google.com) and create a new blank spreadsheet.
2. Name it something like **Visagiri Enquiries**.

## 2. Add the script

1. In the Sheet, click **Extensions → Apps Script**.
2. Delete anything in the code editor and paste in the entire contents of `google-apps-script/Code.gs` (included alongside this website's files).
3. Click the **Save** icon (or Ctrl/Cmd+S).

## 3. Deploy it as a Web App

1. Click **Deploy → New deployment**.
2. Click the gear icon next to "Select type" and choose **Web app**.
3. Set:
   - **Execute as:** Me (your Google account)
   - **Who has access:** Anyone
4. Click **Deploy**.
5. The first time, Google will ask you to authorize the script — click through the "Google hasn't verified this app" warning (**Advanced → Go to [project name] (unsafe)**) since this is your own script. Approve the Sheets and Drive permissions it asks for.
6. Copy the **Web app URL** it gives you — it looks like `https://script.google.com/macros/s/AKfyc.../exec`.

## 4. Connect it to the website

1. Open the website's `.env` file (create it from `.env.example` if you haven't already).
2. Set:
   ```
   GOOGLE_APPS_SCRIPT_URL=https://script.google.com/macros/s/AKfyc.../exec
   ```
   using the URL you copied.
3. Save, and re-deploy/upload the site if it's already live.

That's it — new enquiries will now appear as new rows in your Sheet, and as individual files in a **Visagiri Enquiries** folder that appears automatically in your Google Drive.

## Notes

- If `GOOGLE_APPS_SCRIPT_URL` is left blank, or the Google side is briefly unreachable, the enquiry is **not lost** — the site emails it to your team instead (the addresses in `.env`'s `MAIL_ENQUIRY_RECIPIENTS`). Once Sheets/Drive is set up, both happen: the enquiry lands in the Sheet/Drive folder for record-keeping, and your team still gets an email notification.
- If you ever update `google-apps-script/Code.gs`, you need to **Deploy → Manage deployments → Edit → New version** for the change to take effect — saving the file alone doesn't update the live Web App.
- The Web App URL is not a secret in the traditional sense (Google requires the exact URL plus your script's own logic to do anything), but treat `.env` the same way you would any other configuration file — don't publish it publicly.
