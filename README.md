# 일단 Tuist 초기 설정 및 Git Remote 완료. 천천히 하나씩.

## Tuist, MVVM, Clean Architecture, SwiftUI

정리!!
오우... 기억이 갸물갸물
오퍼 앤설 (sdp)
피어(통로) 연결됌.  
아이스캔디데이트(자신의 ip경로) 교환 이게아마 ip찾기였떤거 같은데 turn인가 stun이 유료일거임.
여튼 p2p 피어 연결. 이건 쉽다. 이전회사에서 개같이 고생한 보람이있네... web도하고 ios도하고 안드로이드도하고...어휴
1대N 시그널링 필수였었고 똑같이 오퍼앤설 보내고 불라불라 
연결은 됐으니깐 클린아키텍처로 다시 쪼개고 해야지...  

진짜 3시간 삽질 개욕나오네. tatbviewfloating 하...
UIApplicationSupportsMultipleScenes: false 이게 핵심
iOS 18에서 MultipleScenes가 true면 탭바가 floating으로 동작하는데, Tuist가 기본값으로 true를 넣음
테스트한다고 새로만든 프로젝트에서는 false였음
고맙다 AI...


createroom처음에 zstack으로 감쌋다가 다시 수정함. 
상대방화면에서 하는게 더 좋음. 
createroom수정 중
import webrtc 제거. 클린아키텍처 어긋남
결국 선생이 만드는거라서 네이밍관련 설정. 

event라는걸 이번에 알겠다. javascript이벤트버스랑 같은거 같다... 
알아보니... notification이랑 비슷하다고그러네.
수돗꼭지라고 생각할것. 1명(?) 전역이 아니라 단일(?)지역적으로 보내고 받는다.


아... 자꾸 presentation에 라이브러리, 다른 모듈들이 들어간다... 미치겟다. 이거때문에 시간 다 잡아먹는다...

까먹지말것! project에서 디펜더시에 해야함! 그 뭐냐 xcode에서 절대 하지 말것!
아마 안된다고 하면 그 project에서 디펜더시로 라이브러리 등등 추가 할 것.
mapper하나 더 만들어서 도메인 뷰 나눔. 즉 dto로 백엔드에서 데이터 받음
그리고 mapper로 entity할걸로 변환함
비즈니스 로직: 예를 들어 서버는 age: 19를 주지만, 우리 앱(Domain)은 isAdult: Bool이라는 기준이 필요할 때 여기서 변환합니다.
entity예시 굿. ㅇㅋㅇㅋ 

provider왜 했는지? view haishin이 의존되어서 stream만 던지기위해서. 좀더 가다듬을 것.





헷갈려도 보고 또보고 보고 또 보고
View (Presentation)
ViewModel (Presentation)
LiveUseCase (Domain)          ← 타입(프로토콜) 기준
LiveUseCaseImpl (Domain)      ← 실제 인스턴스
LiveRepository (Domain)       ← 프로토콜
LiveRepositoryImpl (Data)     ← 구현체
DTO (Data)
LiveMapper (Data)
LiveEntity (Domain)
