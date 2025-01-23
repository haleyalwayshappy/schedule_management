# Schedule management

<aside>
💡 사이트 링크 : https://schedulemanagement-6f601.web.app

깃허브 링크 : https://github.com/haleyalwayshappy/schedule_management

</aside>

## 화면 설계 및 구현

<aside>
💡 지라(Jira) & 노션(Notion) 레퍼런스

</aside>

- 깔끔한 UI를 기반으로 화면 설계 및 구현
- 피그마로 간단한 화면 설계 진행
    
    ![일정보드이미지2.png](Schedule%20management%203cb188bf153342a19362bf601863e5be/%25E1%2584%258B%25E1%2585%25B5%25E1%2586%25AF%25E1%2584%258C%25E1%2585%25A5%25E1%2586%25BC%25E1%2584%2587%25E1%2585%25A9%25E1%2584%2583%25E1%2585%25B3%25E1%2584%258B%25E1%2585%25B5%25E1%2584%2586%25E1%2585%25B5%25E1%2584%258C%25E1%2585%25B52.png)
    
- 상세페이지는 가벼운 느낌을 위해 다이얼로그 팝업으로 제작.
    - 추가화면 : 작성자, 날짜, 상태(할일,급한일,진행중, 완료), 제목, 내용  | 추가하기, 취소 버튼
    - 상세화면 : 작성된 내용 + 취소, 삭제 ,수정 버튼
    - 수정화면 : 작성된 내용 + 취소, 수정버튼
- 추가, 삭제, 수정시 toastification 사용하여 우측 상단에 알림 팝업 제공 (오류시에도 동일)
- 각 Status에 해당하는 기본색상 부여. 
- 가독성 효과 증진
    
    ![스크린샷 2025-01-23 오후 11.10.58(2).png](Schedule%20management%203cb188bf153342a19362bf601863e5be/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2025-01-23_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_11.10.58(2).png)
    

## Model

<aside>
💡 Schedule Model

</aside>

- id - 각 일정에 부여된 고유키
- index - 리스트 순서변경을 위해 부여된 값(최초에는 schedule.length로 값이 추가됨)
- title - 제목
- content - 내용
- assignee - 작성자
- date - 날짜
- status - task 상태

## Controller

<aside>
💡 Task Controller , Schedule Controller

</aside>

### Task Controller

- 상태관리 컨롤러 (드래그앤 드롭)

### Schedule Controller

- firebase service 와 통신을 연결하는 컨트롤러 (비즈니스 로직 담당)
- CRUD, ReadAll 기능을 담당
- firebaseService 와 연결됨

## 폴더트리

![스크린샷 2025-01-23 오후 10.53.38.png](Schedule%20management%203cb188bf153342a19362bf601863e5be/%25E1%2584%2589%25E1%2585%25B3%25E1%2584%258F%25E1%2585%25B3%25E1%2584%2585%25E1%2585%25B5%25E1%2586%25AB%25E1%2584%2589%25E1%2585%25A3%25E1%2586%25BA_2025-01-23_%25E1%2584%258B%25E1%2585%25A9%25E1%2584%2592%25E1%2585%25AE_10.53.38.png)
