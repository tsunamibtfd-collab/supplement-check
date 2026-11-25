# Supplement Check

A short questionnaire about physical activity and mental-wellness goals that returns evidence-graded supplement information, with safety screening. It is one static page (`index.html`) hosted on GitHub Pages. Visitors can choose to send their answers anonymously to a Supabase table.

Educational prototype, not medical advice.

## 1. Supabase

Already set up: project **Supplement Check** (`swnziwtxepkxxcezvpcc`, Canada), table `responses`, keys filled in `index.html`. The steps below are only needed to rebuild it elsewhere.

### Rebuilding from scratch

1. In your Supabase project, open **SQL Editor**, paste `supabase.sql` and click **Run**.
2. Open **Project Settings > API** (or **API Keys**) and copy:
   - the **Project URL**, e.g. `https://abcd1234.supabase.co`
   - the **anon** key, or the **publishable** key (`sb_publishable_...`)
3. In `index.html`, fill in `SUPA_URL` and `SUPA_KEY` near the top of the script.

That key is meant to be public. Row-level security lets it add rows to `responses` and nothing else. **Never** put the `service_role` or secret key in this file.

## 2. Publish on GitHub Pages

1. Create a new repository (e.g. `supplement-check`) and push these files to `main`.
2. In the repo, go to **Settings > Pages** and set **Source** to **GitHub Actions**.
3. The workflow in `.github/workflows/pages.yml` deploys on every push. Your link is
   `https://<your-username>.github.io/supplement-check/`

## 3. See responses

In Supabase, open **Table Editor > responses**, or use the sample queries at the bottom of `supabase.sql`.

## Privacy

Answers include health information (conditions, medicines, pregnancy). Sending is opt-in and stores no names or contact details. Tell your friends what you collect, and delete rows you no longer need.
