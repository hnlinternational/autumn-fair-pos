/* 패드끼리 주문을 주고받는 서버(Supabase) 설정.
   publishable 키는 웹페이지에 공개하는 용도라 여기 넣어도 괜찮아요. secret 키는 절대 넣지 마세요. */
window.FAIR_CONFIG = {
  supabaseUrl: "https://danksznvfsdsdkxwfpqq.supabase.co",
  supabaseKey: "sb_publishable_ZK6WOA4ri7oFiC5QBvfTSg_ryoY9pw8",
  /* 시작 잔돈 (NT$ 권종: 개수) — 채련 님 정리, 합계 5,666 NT$ */
  startCash: { 1000: 0, 500: 0, 100: 11, 50: 80, 10: 41, 5: 28, 1: 16 }
};
