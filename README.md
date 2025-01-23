# schedule_management
HIT_채용미션



1. 화면
- jira와 notion을  레퍼런스로 잡고 화면구성 진행
- 일정 추가 버튼 상단 앱바 우측으로 배치 (예정)
- 일정 보드는 Jira화면, 추가,상세페이지, 수정페이지는 노션을 참고  
- 피그마로 간단한 화면 설계
![일정보드이미지2](https://github.com/user-attachments/assets/0a30f8b3-532e-4494-b95b-9ca39f4d6761)
- status 별로 색을 주어 가독성을 높임 
- Toastification 패키지 사용 -> 추가, 수정, 삭제시 알림 팝업띄움 


2. Model 제작
- schedule 모델 : id, index, title, content, assignee, date ,status


4. Drag&Drop 구현
- ReorderableListView 패키지를 사용하여 구현하면 동일한 task 내에서 움직이는것(상하)는 잘 이루어지지만 다른 task를 오가는 것이 안됨
- DragTarget & Draggable 을 사용하려고 했으나 3.14버전 이후에는 onWillAccept , onAccept 기능이 지원이 되지 않는 이슈가 있음
  (링크 https://api.flutter.dev/flutter/widgets/DragTarget/DragTarget.html)-> 해결 :onWillAcceptWithDetails, onAcceptWithDetails 를 사용하여 개발
- Task 간 이동은 좌우 이동 위치에 따라 TaskStatus를 변경한다.
- 최초에 task 이동되면 하단에 정렬된다.
- Task 내 이동은 상하 이동 위치에 따라 인덱스 넘버를 변경해준다.


5.트러블 슈팅(리팩토링 내용)
- 상하좌우 이동 자체도 어려웠으나, UX관점에서 이동이 유연하지 않게 보임. 이를 더 유연하게 변경되도록 개선
> 해결 : 위치 이동 onWillAcceptWithDetails, onAcceptWithDetails의 기준을 느슨하게 변경 및 드롭 가능한 영역을 확장
> 이동시에 conatainer border에 값을 주어 변경하려는 위치를 명확하게 표현함.


6.파이어 베이스 연동
- CRUD 기능 구현
- 더미데이터 지우고 파이어베이스로 저장된 값 가져오기

7.Controller, Service 분리
- controller파일과 service파일을 분리하여 코드 가독성과 유지보수성을 높임


8. 폴더 구조 

