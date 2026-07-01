-- Adds the "ระดับความสนใจ" (interest level) question and its follow-ups to an
-- already-created leads table: demo interest, general-info interest, or not
-- interested (with a short reason), plus a free-text suggestion box and PDPA
-- consent flag.
-- Run this once in: Supabase Dashboard > SQL Editor > New query

alter table public.leads
  add column if not exists interest_level text not null default 'demo'
    check (interest_level in ('demo','info','not_interested')),
  add column if not exists not_interested_reason text,
  add column if not exists suggestion text,
  add column if not exists pdpa_consent boolean not null default false;
