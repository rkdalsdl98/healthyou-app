<div>
  <img width="125" height="125" src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/55e241d9-0aa9-47d1-9eac-391e117d3e2e">  
  <h1>Healthyou</h1>
</div>

<h2>📚 STACKS</h2>
<div>
  <img src="https://img.shields.io/badge/flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"> <img src="https://img.shields.io/badge/dart-0175C2?style=for-the-badge&logo=dart&logoColor=white">
</div>  
<div>
  <a href="https://github.com/rkdalsdl98/healthyou-app"><img src="https://img.shields.io/badge/Platform-Android%2B-green.svg?style=flat"></a> <a href="https://android-arsenal.com/api?level=21#l21"><img src="https://img.shields.io/badge/API-21%2B-brightgreen.svg?style=flat"></a> <a href="https://play.google.com/store/apps/details?id=com.hsy.healthyou"><img src="https://img.shields.io/badge/Google Play-Download%2B-orange.svg?style=flat"></a>
</div>  

# 개요  
>실생활에서 운동을 시작 할때 혹은 운동을 지속적으로 이어나갈때 내가 계획한 목표를 달성해 나아가고 있는가? 에 대한 과정을 직접 계획하고 행한 결과를 기록하는 어플리케이션이 있으면 어떨까?? 하는 생각에서 기반된 프로젝트 입니다.  

# Architecture & State Management  
+ MVVM  
+ Provider  

# Database  
SharedPreferences (Local)  
+ 사용자가 생성한 프리셋, 식사 루틴 등등 정보는 모두 로컬에 저장 된다.
+ 각각의 레포지토리는 저장된 사용자 정보를 불러와 동기화 한다.
+ Model은 저장소에서 사용될 toJson 함수와 ViewModel에서 사용될 fromJson으로 유동적인 데이터 전환을 한다.  

# Notification  
FlutterLocalNotifications  
SharedPreferences (Local)  
+ 사용자가 지정한 시간에 알림 메세지를 보내고 저장하며 관리 한다.
+ 알림은 생성시에 고유한 아이디를 부여하여 관리 된다.
+ 달력에 알림은 메모와 함께 저장되며, 어플 실행시 정보를 불러와 동기화 한다.
+ 운동, 식사 알림은 기본적으로 제공하는 값이 있으며, 사용자 정의로 인한 수정이 발생 할 경우 해당 정보를 저장하고 동기화시 저장된 정보를 불러온다.  

# Reset  
WidgetsBinding  
+ 어플 실행시 옵저버를 생성해 어플의 상태를 체크 하고, 날짜가 바뀔 경우 필수 정보를 제외한 모든 정보를 초기화 한다.

# Tools  
  ## Figma  

  [Healthyou! Figma](https://www.figma.com/file/5P0mcLR7LmEWwI0lT2kEmt/Heathyou?type=design&node-id=1-2&mode=design&t=GsyzifDPLn7kGGrf-0)  

  ## Rive  
  + 일부 애니메이션은 해당 툴로 제작 되었습니다.  

# Demo

<div align="center">
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/cbddbc35-700d-41eb-8365-07999ceb8ca5" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/dd37b0ea-6510-422b-822e-ff789324e9a4" width="200" height="355">  
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/224f4f82-68d1-44e6-9b9a-b412614145cd" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/474b8e65-6ceb-42b2-bdd9-1613d27251f4" width="200" height="355">  
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/4537e9ee-24f2-49df-8cb7-cdc8fb30e221" width="200" height="355"><img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/451e5bc3-fcda-4734-b397-f726e5817d88" width="200" height="355">  
  <img src="https://github.com/rkdalsdl98/healthyou-app/assets/77562358/3a2a957c-1393-42fe-a958-94f13c26771c" width="200" height="355">
</div>

# 수정, 업데이트  

식단 구성부분에서 음식 정보수정이 엇갈려 되던 현상 수정  