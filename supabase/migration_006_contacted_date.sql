-- Adds "วันที่ติดต่อกลับ" (follow-up contact date) so the sales team can log
-- when they actually called each lead back, editable from the admin's raw
-- data table and from the lead detail drawer.
-- Run this once in: Supabase Dashboard > SQL Editor > New query

alter table public.leads
  add column if not exists contacted_date date;
