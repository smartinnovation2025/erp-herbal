-- Adds the "โมดูลที่สนใจ" (modules of interest) checkbox section, shown below
-- ระดับความสนใจ on the registration form.
--
-- The old "issues" column (pain-point checkboxes) has been unused since that
-- section was replaced by ระดับความสนใจ + ข้อเสนอแนะเพิ่มเติม earlier — it's the
-- same text[] shape, so we rename it instead of adding a new dead column.
-- Run this once in: Supabase Dashboard > SQL Editor > New query

alter table public.leads rename column issues to modules;
