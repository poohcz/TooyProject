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
