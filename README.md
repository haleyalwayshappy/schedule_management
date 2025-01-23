# schedule_management
HIT_채용미션

### 2025/1/21 TUE

1. 화면
- jira를 레퍼런스로 잡고 화면구성 진행
- 일정 추가 버튼 상단 앱바 우측으로 배치 (예정)
- 깔끔한 UI에 대중적인 UX를 중점으로 제작
- 피그마로 간단한 화면 설계
![일정보드이미지2](https://github.com/user-attachments/assets/0a30f8b3-532e-4494-b95b-9ca39f4d6761)

- widget 분리

2. Model 제작
- schedule 모델 : title, content, assignee, date ,status

3. 작업상태를 enum으로 관리하게 된 이유
- 종류가 고정되어 있음: 작업 상태(todo, urgent, inProgress, done)는 고정된 값으로, 임의로 값이 추가되거나 잘못된 값이 입력되는 상황을 방지할 수 있음.
- 타입 안정성을 고려하여 enum class 생성:enum을 사용함으로써 컴파일 타임에 타입 검사를 통해 오류를 사전에 방지할 수 있으며, 잘못된 값을 사용할 가능성을 줄임
- 가독성과 유지보수성을 향상: 상태를 명확하고 직관적으로 표현하여 코드의 가독성을 높이고, 상태별 로직을 쉽게 관리할 수 있음
- 확장성과 상태 기반 데이터 관리: enum에 상태별 부가 정보를 포함할 수 있어 확장성이 뛰어나며, 상태와 관련된 데이터(예: 라벨, 색상, 아이콘)를 한 곳에서 관리할 수 있음.
- 디버깅과 코드 안정성: 디버깅 시 상태를 명확하게 확인할 수 있어 유지보수가 쉬워지며, 상태 관리에서 발생할 수 있는 런타임 오류를 줄일 수 있음


### 2025/1/22 WED

4. Drag&Drop 구현
- ReorderableListView 패키지를 사용하여 구현하면 
동일한 task 내에서 움직이는것(상하)는 잘 이루어지지만 다른 task를 오가는 것이 안됨
- DragTarget & Draggable 을 사용하려고 했으나 3.14버전 이후에는 onWillAccept , onAccept 기능이 지원이 되지 않는 이슈가 있음
  (링크 https://api.flutter.dev/flutter/widgets/DragTarget/DragTarget.html)-> 해결 :onWillAcceptWithDetails, onAcceptWithDetails 를 사용하여 개발
- Task 간 이동은 좌우 이동 위치에 따라 TaskStatus를 변경한다.
- 최초에 task 이동되면 하단에 정렬된다.
- Task 내 이동은 상하 이동 위치에 따라 인덱스 넘버를 변경해준다. 

드래그앤드롭 구현 성공 

5.트러블 슈팅(리팩토링 내용)
- 상하좌우 이동 자체도 어려웠으나, UX관점에서 이동이 유연하지 않게 보임. 이를 더 유연하게 변경되도록 개선
> 해결 : 위치 이동 onWillAcceptWithDetails, onAcceptWithDetails의 기준을 느슨하게 변경 및 드롭 가능한 영역을 확장
> 이동시에 conatainer border에 값을 주어 변경하려는 위치를 명확하게 표현함.

- Task 디자인 변경 : 확장성을 생각해 Task별로 컬러 값을 주었는데 해당 컬러값을 사용해 backgroundColor를 변경 (opacity = 0.1 로 주어 가독성 살림) 


6. 상세 페이지, 추가페이지, 수정 페이지 구현
- 노션 스타일의 화면 구현

7. 파이어 베이스 연동
- CRUD 기능 구현
- 가짜데이터 지우고 파이어베이스로 저장된 값 가져오기

8.Controller ,Service 분리
- controller파일과 service파일을 분리하여 코드 가독성과 유지보수성을 높임

9. Toastification 라이브러리 사용
- 패키지 사용하여 삭제시 알림 팝업띄움 

### 2025/1/23 THU
10. task 이동시 값 수정되기 (index값, status값)
- moveTo에 수정 로직 추가 
11. task 추가하기 (chip형태로)
12. 테스트 케이스 작성
13. 배포