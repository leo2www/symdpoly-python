# symdpoly-python
本地构建symdpoly项目中停止维护的开源依赖，尝试嵌入Python替代原生Scala。

# 依赖
Scala依赖可以用sbt clean update构建查看，也可以从项目根目录`build.sbt`中的`libraryDependencies`变量阅读查看。symdpoly缺失依赖主要是仓库创建者 [Denis Rosset](https://github.com/denisrosset) 开源项目，重新构建补齐缺失即可重新运行 symdpoly。

symdpoly默认resolver从`dl.bintray.com`和Sonatype仓库读取；前者已不受维护，后者也未曾发布symdpoly相关项目。读者可以选择构建完成后发布到本地仓库满足本地依赖，也可以自行上传到公开仓库管理网站。本项目默认发布到本地仓库,并利用Github Action发布到私有Nexus仓库。

## 项目结构
- git 子模块引用依赖原开源库（需要修改的依赖项目使用Fork后的开源库）
- Dev container 配置依赖项自动构建发布，够用户容器中使用。
    - Debian bookworm 系统
    - 测试版容器（阿里云ARC 仅供少量使用）
    ```bash
    docker pull 
    ```