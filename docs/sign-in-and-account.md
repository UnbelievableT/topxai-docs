# Sign-in and account

> How sign-in is shared with topxea.com, how sessions and devices work, the regional service notice, and how to reach support.

This page is also published at https://ai.topxea.com/docs/sign-in-and-account (English and Chinese).

## One sign-in for topxea.com and TopxAI

Sign-in goes through Clerk with a verified primary email; TopxAI and topxea.com share one Clerk identity. If already signed in on topxea.com, you are signed in here too; otherwise you browse as a visitor and meet the sign-in page only on console pages such as **Dashboard**. Balance, keys and usage are bound to that Clerk user id. Accounts are not merged by email; a second Clerk id on the same email answers `This email belongs to an existing account. Contact support.`

Name, email, password and sign-in methods live in Clerk's panels: **Manage Clerk profile** and **Manage password and security** on **Profile**. Account closure goes through support.

## Sign-in page stuck

- `Sign-in is taking too long. Please try again.` with **Reload sign-in**: the page waited 30 seconds for configuration or the Clerk script.
- The same message with **Try again** and **Sign out**: the TopxAI exchange timed out.
- **Retry loading sign-in**: the Clerk script failed to load.
- `Unable to load sign-in configuration. Please try again.`: press **Try again**.
- A bare **Sign in** button after signing out here: it ends the leftover Clerk session, then shows the form.

## Sessions and devices

A console session lasts up to 30 days and is re-verified against Clerk on every visit; a revoked or expired Clerk session fails the next request. A briefly unreachable Clerk answers 503; retry.

**Login sessions** on **Profile** is Clerk's device list, including devices that only signed in on topxea.com; **Expires** shows each Clerk session's expiry.

- **Sign out** ends this device.
- **Revoke** ends one other device.
- **Sign out other sessions** revokes every other Clerk session, topxea.com included.

Signing out does not touch API keys; they work until **Disable** or **Delete** on the **API keys** page. A disabled account blocks sign-in and every key.

## Regional service notice

With regional access controls on, the console API and every `/v1/` endpoint answer 403 with `The service is not available in your region.` or `Your service region could not be verified. Please contact support.` The decision uses our infrastructure's location headers, not browser settings; public pages and sign-out still work.

## Reaching support

Use the help button at the bottom right of any page (the footer's **Support** link opens it too) or write to support@topxea.com. For an API error, copy the `(request id: ...)` at the end of the message or the `x-request-id` response header. For a block in the browser (no request id there) give the time with time zone, the page and your account email. Never paste an API key. Prompts and responses are not stored; support sees only metadata (model, token counts, status, latency, key id).
