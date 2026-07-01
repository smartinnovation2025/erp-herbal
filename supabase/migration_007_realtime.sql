-- Enables Supabase Realtime (WebSocket) change notifications on public.leads
-- so the admin dashboard can update live (INSERT/UPDATE/DELETE) without F5.
-- Run this once in: Supabase Dashboard > SQL Editor > New query

alter publication supabase_realtime add table public.leads;
