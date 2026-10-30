-- 돈통 칸(시작 잔돈·마감 때 센 돈)을 모든 기기와 공유하기 위한 칸 추가. SQL Editor에서 한 번만 Run
alter table public.fair_config add column if not exists cash jsonb not null default '{}'::jsonb;
