# gitlab-sonar-scanner-typescript
a image can run code analysis of typescript in gitlab ci  
提供 Typescript 的单元测试，Sonarscanner 静态分析的环境

## 环境

基础镜像： openjdk:8-jdk-alpine
sonarscanner: 3.3.0.1492  
nodejs  
npm  
typescript 
tslint  
git  

## 关于 PhantomJS

alpine 系统目前 PhantomJS 目前跑不起来，镜像中对此有做处理，[可参考](https://gist.github.com/vovimayhem/6437c2f03b654e392ccf3e9903eba6af)
