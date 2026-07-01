-- ERP Herbal QR Lead System — Supabase schema
-- Run this once in: Supabase Dashboard > SQL Editor > New query

create table if not exists public.leads (
  id         text primary key,
  name       text not null,
  pos        text,
  company    text not null,
  tel        text not null,
  size       text,
  org_type   text not null default 'factory' check (org_type in ('hospital','factory','individual')),
  demo_date  date,
  demo_time  text,
  interest_level         text not null default 'demo' check (interest_level in ('demo','info','not_interested')),
  not_interested_reason  text,
  suggestion             text,
  pdpa_consent           boolean not null default false,
  modules    text[] default '{}',
  contacted_date date,
  src        text not null default 'direct' check (src in ('demo','brochure','direct')),
  status     text not null default 'new' check (status in ('new','call','sched','done','cold')),
  score      text not null default 'low' check (score in ('high','mid','low')),
  note       text default '',
  created_at timestamptz not null default now()
);

alter table public.leads enable row level security;

-- Public landing-page form must be able to insert a lead with no login.
drop policy if exists "leads_public_insert" on public.leads;
create policy "leads_public_insert" on public.leads
  for insert to anon
  with check (true);

-- Admin dashboard (no separate login yet) reads/updates using the same anon key.
-- NOTE: this means anyone holding the anon key (it is visible in the page source)
-- can read and edit all leads, including name/phone/company. Acceptable for an
-- internal expo-booth tool, but if this ever needs to be public-facing, add
-- Supabase Auth and scope these two policies to an authenticated "staff" role.
drop policy if exists "leads_public_select" on public.leads;
create policy "leads_public_select" on public.leads
  for select to anon
  using (true);

drop policy if exists "leads_public_update" on public.leads;
create policy "leads_public_update" on public.leads
  for update to anon
  using (true)
  with check (true);

create index if not exists leads_created_at_idx on public.leads (created_at desc);

-- Prevent two leads from double-booking the same demo date+time slot.
create unique index if not exists leads_demo_slot_unique
  on public.leads (demo_date, demo_time)
  where demo_date is not null and demo_time is not null;
