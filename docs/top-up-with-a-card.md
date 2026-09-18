# Top up with a card

> Add USD credit with a card, Apple Pay, Google Pay or a local e-wallet; the checkout runs on topxea.com through Waffo.

This page is also published at https://ai.topxea.com/docs/top-up-with-a-card (English and Chinese).

## Where you pay

TopxAI does not take card details. When you pick **Card / local payment** on the **Wallet** page and click **Continue to secure checkout**, TopxAI creates an order and sends you to a payment page on topxea.com, TopXEA's main site. That page opens Waffo, the merchant of record, which handles tax and takes cards, Apple Pay, Google Pay and local e-wallets. No TopXEA account is needed; the link carries an access key.

## Steps

1. On **Wallet**, in the **Add credit** panel, pick **Card / local payment** under **Payment method**.
2. Enter **Amount (USD)** or use a preset ($10, $25, $50, $100); one payment is $10.00 to $10,000.00.
3. Click **Continue to secure checkout**. On topxea.com, click **Pay $25.00 with Waffo** (showing your amount).
4. Pay, then click **Return to TopxAI**. **Payment details** opens for this order by itself and refreshes every 10 seconds while **Pending**.

## How the balance arrives

Your credit is exactly the USD amount you entered; where tax applies, Waffo's total is higher, but tax is not added to your credit.

Returning from checkout credits nothing by itself. After Waffo confirms the payment, topxea.com sends TopxAI a signed notice; TopxAI credits only when the provider, the main-site order number, the exact cent amount and the currency (USD) all match. Cards usually confirm in seconds. TopxAI also polls the main site every minute, so a late notice still lands. When done, the dialog reads "Payment verified. Credit added." and the order is listed under **Statement**.

## Pending and expired orders

An order stays **Pending** until the **Checkout expires** time in **Payment details**, 60 minutes by default. **Continue payment** reopens the same page in a new tab. Do not start another order after paying; at five unexpired pending orders, a new checkout is refused and the page shows "Could not create checkout. Try again or contact support."

After the deadline the order turns **Expired**, **Continue payment** disappears, and the dialog reads "Checkout expired. If you already paid, we will keep checking the provider." A last-minute payment is still credited once the verified payment arrives; the status then changes to **Success** and the message to "Payment verified. Credit added." Expired orders are swept only every six hours, so click **Check payment**: it queries the main site at once, every 30 seconds at most.

If Waffo reports a refund or dispute after crediting, the order shows **Review required** in the statement (the payment details say **Payment requires review**, reason **Refund reported**) and support reviews it by hand. For that, for refunds, or if money left your account without credit, contact support with the **Order ID**: the help button at the bottom right of the site, or support@topxea.com. Per the User Agreement, applicable law and the verified payment status govern refunds.
