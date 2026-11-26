# PlateFirst (platefirst.ca)

A seven-question check on supplements, food and activity for active Canadians. Free preview, then a $19.95 CAD full report.

Educational tool, not medical advice.

## How it fits together

- **Website** (`index.html`, `privacy.html`, `refund.html`): static pages on GitHub Pages. They contain no report logic.
- **Report API**: a Supabase Edge Function called `report` in the Supabase project *Supplement Check*. It scores answers, returns the free preview, opens Stripe Checkout, confirms payment, and only then returns the full report. Its source is deliberately **not** in this public repository.
- **Database**: `reports` (answers, payment status; only the function can read it; unpaid rows are deleted after 7 days) and `responses` (optional anonymous research answers; the public key can insert only).

## Turning on payments

1. Create a Stripe account and complete business verification.
2. In Stripe, go to **Developers → API keys** and copy the **secret key** (start with a test key, `sk_test_...`).
3. In Supabase, open **Edge Functions → Secrets** for the *Supplement Check* project and add `STRIPE_SECRET_KEY` with that value.
4. Test a purchase with Stripe's test card `4242 4242 4242 4242`, then switch to the live key.
5. Optional backup: in Stripe, add a webhook to `https://swnziwtxepkxxcezvpcc.supabase.co/functions/v1/report` for `checkout.session.completed`, and add its signing secret in Supabase as `STRIPE_WEBHOOK_SECRET`.
6. Optional: for a custom domain, add it in **Settings → Pages**, then set the Supabase secret `SITE_URL` to the new address so checkout returns there.

Before going live, replace the contact lines in `privacy.html` and `refund.html` and set a support email in Stripe.
