# Autumn Fair 주문판

학교 Autumn Fair 부스용 주문·주방·정산 화면. 로그인 없이 브라우저로 열고, 오래된 안드로이드 태블릿 크롬에서도 돌아가도록 ES5 코드만 썼어요.

## 패드별 주소
- 주문(데스크): `https://hnlinternational.github.io/autumn-fair-pos/#order`
- 주방: `https://hnlinternational.github.io/autumn-fair-pos/#kitchen`
- 정산: `https://hnlinternational.github.io/autumn-fair-pos/#sales`

## 패드 연동 설정 (한 번만)
1. Supabase 프로젝트의 SQL Editor에서 `schema.sql` 실행
2. `config.js`에 프로젝트 URL과 publishable(anon) 키 입력
3. 오른쪽 위가 초록색 "모든 패드 연결됨"이면 완료

`config.js`가 비어 있으면 각 패드가 따로 동작해요(연동 없음).

## 동작 방식
- 2초마다 서버에서 주문을 다시 읽어요(오래된 기기 호환을 위해 실시간 소켓 대신 단순 반복 조회).
- 주문 번호는 서버가 매겨요. '메뉴·가격 → 초기화'로 연습 주문을 지우면 #1부터 다시 시작해요.
