# Git 子模块
```bash
git submodule add https://github.com/jekyll/minima.git dependencies/minima
```

## mosek
symdpoly 依赖mosek9.x 接口，这里暂不调整。

mosek的jar包需要手动导入 ./dependencies/mosek/
证书也要导入，可以通过环境变量
echo 'export MOSEKLM_LICENSE_FILE=/workspaces/symdpoly/mosek.local/mosek.lic' >> ~/.bashrc

source ~/.bashrc
[mosek.jar](https://docs.mosek.com/latest/javaapi/install-interface.html#doc-optimizer-install-info-path-tab)在<MSKHOME>/mosek/11.0/tools/platform/<PLATFORM>/bin/mosek.jar
/workspaces/symdpoly/mosek.local/mosek/11.0/tools/platform/linux64x86/bin/mosek.jar

复制到 /workspaces/symdpoly/modules/mosek/lib/mosek.jar, 按照 /workspaces/symdpoly/modules/mosek/src/main/scala/net/alasc/symdpoly/mosek/package.scala 的声明如此：
cp /workspaces/symdpoly/mosek.local/mosek/11.0/tools/platform/linux64x86/bin/mosek.jar /workspaces/symdpoly/modules/mosek/lib/mosek.jar

注意原仓库使用的是mosek9.x 版本，


mkdir mosek9.3.0
tar -xvf mosektoolslinux64x86.9.3.0.tar.bz2 -C mosek9.3.0

```sh
wget https://download.mosek.com/stable/9.3.0/mosektools-linux64-x86.tar.bz2 \ 
 -O "../denpendencies/mosek/mosekmosektoolslinux64x86.9.3.0.tar.bz2" 
tar -xvf "../denpendencies/mosek/mosektools-linux64-x86.tar.bz2" \ 
-C "../denpendencies/mosek/"

```

```sh

```