# 🌱 Service Level Project

내 주변의 친구들을 찾아주고 취미 공유와 채팅을 할 수 있는 iOS 어플리케이션

## Description

- Clean Architecture와 Coordinator 패턴 적용
- Storyboard를 활용하지 않고 코드로만 UI 구성
- Custom View를 적극 활용하여 코드의 재사용성 강화
- Socket.IO를 활용하여 실시간 채팅 기능 구현
- 모든 네트워크 Status Code 응답값에 대한 대응 처리

## Getting Started

### Skill
    Swift, RxSwift, RxCocoa
    Clean Architecture, Coordinator
    UIKit, AutoLayout
    Moya, Socket.IO, Firebase
    SnapKit, SwiftGen, SwiftLint, Toast, RxKeyboard, NMapsMap

### Architecture

#### MVVM-C + Clean Architecture

* [MVVM - 아키텍쳐적인 고민]()
* [Coordinator의 Child 관리와 Router 관련 궁금점]()

### Issue

* [우당탕탕 Rx 적용기]()
* [UI - Codebase ContainerView 구성]()
* [UI - 복잡한 형태의 ExpandableView]()
* [Network - Moya 기반 API 구성]()

### Reflection

#### [익숙한 방식에서 보다 체계적인 관리로]
이번 프로젝트는 여태 해왔던 방식이 아닌 최대한 새로운 방식으로 완성해보려고 노력했다.</br>
비슷한 형태 또는 유사한 기능을 갖춘 UI가 보인다면 모듈화를 적극적으로 시도하여 재사용성을 높였고 </br>
아키텍처는 적어도의 클린 아키텍처와 코디네이터 패턴을 적용시켰다. </br>
네트워크 관련 라이브러리도 Moya를 사용했고 현업과의 연결성을 위해 SwiftLint와 SwiftGen도 시도했다.

<div></div>

#### [클린 아키텍처 적용과 적절한 아키텍처에 대한 고찰]
클린 아키텍처를 프로젝트에 적용해보고 드는 생각은 결국 다양한 아키텍처 패턴이 존재하지만 어떤 게 더 좋은 아키텍처고 더 나쁜 아키텍처는 아니라는 것이다. </br>
MVC를 쓴다고 해서 구식의 아키텍처 패턴을 사용하는 것이 아니고 </br>
클린 아키텍처를 사용한다고 해서 결코 더 좋은 아키텍처 패턴을 쓴다고 말할 수 없다. </br>
오히려 70년대에 소개된 MVC패턴이 지금까지도 대중적으로 사용되고 있다는 것은 </br>
그만큼 보편적이고 좋은 아키텍처라는 것을 증명하고 있다. </br>
다만, 우리는 우리가 어떤 프로젝트를 수행하느냐에 따라 적합한 아키텍처는 분명 존재한다고 말할 수 있을 것 같다</br>
모듈화와 객체지향의 관점에서 어떻게 전체적인 틀과 레이어를 짜는 것 뿐만 아니라 </br>
국부적인 관점에서도 이를 활용할지에 대해 한 번 더 생각하게 된다.

*****

## ScreenShot
<div markdown="1">  
    <div align = "left">
    <img src="https://user-images.githubusercontent.com/87598209/158223391-96dfc3b6-3437-4b4f-b4cf-42678c2a64fd.png" width="20%"></img>
    <img src="https://user-images.githubusercontent.com/87598209/158223474-b9a6ff2e-c983-4ba4-bab4-b016cb18463a.png" width="20%"></img>
    <img src="https://user-images.githubusercontent.com/87598209/158223539-39ecc43a-61f4-4749-b633-4567bbca80e9.png" width="20%"></img>
</div>
<div markdown="1">  
    <div align = "left">
    <img src="https://user-images.githubusercontent.com/87598209/158223593-47e51db8-863f-4549-8ed6-cab49bbba6ec.png" width="20%"></img>
    <img src="https://user-images.githubusercontent.com/87598209/158223706-6760e8c1-8184-4a83-bd66-f6d253b1b960.png" width="20%"></img>
    <img src="https://user-images.githubusercontent.com/87598209/158223793-c4ef51f2-f6e0-4f27-82be-4d58a4ebb5d4.png" width="20%"></img>
</div>  

