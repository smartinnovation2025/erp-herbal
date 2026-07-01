-- Adds "organization type" (hospital / factory / individual) to an already-created leads table.
-- Run this once in: Supabase Dashboard > SQL Editor > New query
-- (Skip this file if you are setting up the leads table for the first time — schema.sql already includes org_type.)

alter table public.leads
  add column if not exists org_type text not null default 'factory'
    check (org_type in ('hospital','factory','individual'));
