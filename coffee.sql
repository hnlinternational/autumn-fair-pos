-- Autumn Fair 커피 주문 · Supabase SQL Editor에 붙여넣고 Run (한 번만)
create table if not exists public.fair_coffee (
  name text primary key,
  drink text not null,
  temp text not null default '',
  memo text not null default '',
  updated_at timestamptz not null default now()
);
alter table public.fair_coffee enable row level security;
drop policy if exists fair_coffee_read on public.fair_coffee;
drop policy if exists fair_coffee_add on public.fair_coffee;
drop policy if exists fair_coffee_edit on public.fair_coffee;
drop policy if exists fair_coffee_del on public.fair_coffee;
create policy fair_coffee_read on public.fair_coffee for select to anon, authenticated using (true);
create policy fair_coffee_add on public.fair_coffee for insert to anon, authenticated with check (true);
create policy fair_coffee_edit on public.fair_coffee for update to anon, authenticated using (true) with check (true);
create policy fair_coffee_del on public.fair_coffee for delete to anon, authenticated using (true);
grant select, insert, update, delete on public.fair_coffee to anon, authenticated;
