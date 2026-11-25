-- Run once in Supabase: Dashboard > SQL Editor > New query > paste > Run.
-- Creates a table that visitors can add rows to but never read, edit or delete.

create table if not exists public.responses (
  id         bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  answers    jsonb not null,
  results    jsonb,
  constraint answers_size check (pg_column_size(answers) < 8000),
  constraint results_size check (results is null or pg_column_size(results) < 4000)
);

alter table public.responses enable row level security;
revoke all on public.responses from anon, authenticated;
grant insert (answers, results) on public.responses to anon;

-- Anonymous visitors may insert only. No select/update/delete policy exists,
-- so the public key cannot read anyone's answers.
drop policy if exists "anon can insert responses" on public.responses;
create policy "anon can insert responses"
  on public.responses for insert
  to anon
  with check (true);

-- Useful views for you (run in the SQL editor; they use your dashboard login, not the public key):
-- select answers->'goals' as goals, count(*) from public.responses group by 1 order by 2 desc;
-- select jsonb_array_elements_text(results->'picked') as supplement, count(*) from public.responses group by 1 order by 2 desc;
