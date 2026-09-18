# Pay with crypto

> Top up with USDT or USDC through a NOWPayments invoice: what to send, how long confirmation takes, and what happens if you send too little.

This page is also published at https://ai.topxea.com/docs/pay-with-crypto (English and Chinese).

## What you pay with

Crypto top-ups run through a NOWPayments hosted invoice for the USD amount only; you pick the coin and network on the NOWPayments page. The invoice uses a fixed rate, the NOWPayments service fee is not added, and your balance is credited in USD.

## Steps

1. On **Wallet**, under **Payment method**, pick **Crypto · USDT / USDC** and enter **Amount (USD)**, from $10.00 to $10,000.00.
2. Click **Continue to secure checkout**. It opens nowpayments.io.
3. Pick the asset and network, then send exactly the amount shown to the address shown, on that network.
4. Return through the NOWPayments link: **Payment details** opens by itself and refreshes every 10 seconds while **Pending**. Otherwise, open it from **Statement** with **Details**.

## Confirmation timing

Credit is added only when NOWPayments reports **Payment complete** (`finished`) and received at least the amount requested. Until then, **Provider status** moves through **Waiting for payment**, **Confirming payment**, **Payment confirmed** and **Processing payment**. TopxAI never credits on `confirmed` or `sending`. Timing depends on the network and NOWPayments.

NOWPayments sends TopxAI a signed callback; TopxAI re-reads the payment from the NOWPayments API before crediting and rechecks pending orders every minute. Until the first callback, the dialog reads "Waiting for verified payment. You can safely leave this page." and **Payment ID** and **Provider status** read **Not available yet**. **Check payment** checks now, at most every 30 seconds; before a payment ID exists it may answer "Verification is delayed. Your order is saved and will be checked again." That is normal.

## Underpaid, overpaid, expired

- Underpaid: `partially_paid`, or `finished` with less received than requested, keeps the order **Pending** with "The payment amount is incomplete. Follow the provider instructions or contact support." No tolerance, no partial credit. Follow the NOWPayments page, or contact support with the **Order ID**. **Continue payment** reopens the same invoice while the order is pending and unexpired; there is never a second invoice for one order.
- Overpaid: you are credited the USD amount ordered, not more.
- Expired: the order turns **Expired** at the **Checkout expires** time (60 minutes by default); the NOWPayments invoice and rate quote have their own deadlines. A transfer that confirms later is still credited once NOWPayments reports it. Send only the coin, network, address and amount the invoice shows; under the User Agreement, any other transfer may not be credited and recovery is not guaranteed.
- Failed or cancelled: the order shows **Failed**. If funds left your own wallet, contact support.
- Refunded after crediting: the order shows **Review required** in the statement and **Payment requires review** (**Refund reported**) in the payment details; nothing is deducted automatically; support reviews it by hand.

Support: the help button at the bottom right of the site, or support@topxea.com.
