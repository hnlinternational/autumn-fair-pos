-- Autumn Fair 주문판 · Supabase 설정
-- Supabase 대시보드 > SQL Editor 에 붙여넣고 Run 하세요.

create sequence if not exists public.fair_order_no_seq;

create table if not exists public.fair_orders (
  id bigint generated always as identity primary key,
  no int not null default nextval('public.fair_order_no_seq'),
  items jsonb not null,
  total int not null,
  status text not null default 'open' check (status in ('open','held','served','cancelled')),
  done jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.fair_config (
  id int primary key default 1 check (id = 1),
  menu jsonb not null,
  float_cash int not null default 0,
  reset_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
alter table public.fair_config add column if not exists reset_at timestamptz not null default now();
create index if not exists fair_orders_updated_idx on public.fair_orders(updated_at);

create or replace function public.fair_touch() returns trigger language plpgsql as $$
begin new.updated_at := now(); return new; end $$;
drop trigger if exists fair_orders_touch on public.fair_orders;
create trigger fair_orders_touch before update on public.fair_orders for each row execute function public.fair_touch();
drop trigger if exists fair_config_touch on public.fair_config;
create trigger fair_config_touch before update on public.fair_config for each row execute function public.fair_touch();

alter table public.fair_orders enable row level security;
alter table public.fair_config enable row level security;

drop policy if exists fair_orders_read on public.fair_orders;
drop policy if exists fair_orders_add on public.fair_orders;
drop policy if exists fair_orders_edit on public.fair_orders;
drop policy if exists fair_config_read on public.fair_config;
drop policy if exists fair_config_edit on public.fair_config;
create policy fair_orders_read on public.fair_orders for select to anon, authenticated using (true);
create policy fair_orders_add on public.fair_orders for insert to anon, authenticated with check (true);
create policy fair_orders_edit on public.fair_orders for update to anon, authenticated using (true) with check (true);
create policy fair_config_read on public.fair_config for select to anon, authenticated using (true);
create policy fair_config_edit on public.fair_config for update to anon, authenticated using (true) with check (true);

grant usage on sequence public.fair_order_no_seq to anon, authenticated;
grant select, insert, update on public.fair_orders to anon, authenticated;
grant select, update on public.fair_config to anon, authenticated;

-- 연습 주문 지우기 + 번호 #1부터 다시
create or replace function public.fair_reset() returns void
language plpgsql security definer set search_path = public as $$
begin
  delete from public.fair_orders where true;
  perform setval('public.fair_order_no_seq', 1, false);
  update public.fair_config set reset_at = now() where id = 1;
end $$;
revoke all on function public.fair_reset() from public;
grant execute on function public.fair_reset() to anon, authenticated;

insert into public.fair_config (id, menu) values (1, '[
 {"id":"m1","kr":"불고기 덮밥","en":"Bulgogi Rice","price":150,"st":"bul","out":false},
 {"id":"m2","kr":"떡볶이","en":"Tteokbokki","price":100,"st":"tteok","out":false},
 {"id":"m3","kr":"핫도그","en":"Hot Dog","price":100,"st":"hot","out":false},
 {"id":"m4","kr":"밀키스 오리지널","en":"Milkis Original","price":50,"st":"drink","out":false},
 {"id":"m5","kr":"밀키스 피치","en":"Milkis Peach","price":50,"st":"drink","out":false},
 {"id":"m6","kr":"밀키스 딸기","en":"Milkis Strawberry","price":50,"st":"drink","out":false}
]'::jsonb) on conflict (id) do nothing;
