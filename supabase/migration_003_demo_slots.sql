-- Adds structured demo date/time booking to an already-created leads table,
-- and enforces that no two leads can book the same slot (prevents double-booking
-- even under concurrent submissions).
-- Run this once in: Supabase Dashboard > SQL Editor > New query

alter table public.leads
  add column if not exists demo_date date,
  add column if not exists demo_time text;

create unique index if not exists leads_demo_slot_unique
  on public.leads (demo_date, demo_time)
  where demo_date is not null and demo_time is not null;
