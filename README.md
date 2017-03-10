# k8s_coreos_install_cn
k8s_coreos_install_cn的主要目的是帮助中国kubernetes爱好者快速无痛的将kubernetes安装到虚拟或者实体机上。如果你不想听作者唠叨，请直接参考快速安装。

在作者安装部署k8s的过程中，发现有两个痛点：
1. 由于安装k8s需要在多台机器上安装多个组件，其中任何一个步骤中出现问题，都会导致安装后的k8s出现这样或者那样的异常，然后又需要花大量时间去定位出错的位置并修改。
2. 在缺省配置的k8s安装中，k8s会从quay.io 和gci.io分别获取hyperkube和pause镜像，从作者的实际经验来看，quay.io基本就是几K的龟速，下载600M的hyperkube基本上超过了人类忍耐的限度，即使你耐力超群，能够等到hyperkube全部下载完毕，但是很不幸，gci.io是"零"速，彻底访问不了,永远也不能完成pause的下载。k8s也就永远转不起来。原来gci.io是google家的，你懂的...。如果是在coreos上安装，coreos需要从quay.io下载flannel和hyperkube的rkt镜像来启动flanneld和kubelet,类似龟速下载的问题也会遇到。

第一个问题，可以使用自动部署工具解决, k8s_coreos_install_cn使用的是ansible. 第二个问题，可以采用配置代理服务器或者提前下载来解决。k8s_coreos_install_cn使用了后者，作者先把所有需要的镜像导出打包成images.tar.gz并上传到百度盘，k8s_coreos_install_cn的用户只需从百度盘下载images.tar.gz到本地即可，其他的事儿都交给k8s_coreos_install_cn。之所以选择后者，作者是基于几个原因： 第一不是每个kuberntes爱好者都有代理服务器。第二，即使有代理服务器，从百度盘直接下载也远远快于通过代理服务器去国外下载快。第三，在生产环境安装，可以事先下载好镜像，这样可以既可以省不少生产带宽，又可以大大提高安装的速度。

在百度盘的share目录下，还包括pypy-5.1.0-linux64.tar.bz2和box.tar.gz这两个文件，其中pypy这个文件是用来在目标机器上安装ansible运行所需的python环境。本来也是可以从bitbucket的下载页面直接下载，但是很不幸，国内bitbucket的download基本也是龟速或者零速。所以一并也放在百度盘供下载。然后再安装过程中从本地启动一个HTTP服务，目标机从本地的HTTP服务下载而不是从bitbucket下载。这也是为什么在快速安装的步骤5需要开启一个HTTP服务和步骤6的脚本中需要传入本地IP地址做参数。 box.tar.gz是coreos(alhpa 1325.1.0) 的box文件，在k8s_coreos_install_cn中的coreos-vagrant目录下的vagrant文件中缺省是从本地HTTP服务下载，这样也是为了加快下载速度。

# 安装
## 使用vagrant快速安装


1. `git clone https://github.com/bubble501/k8s_coreos_install_cn.git`
2. 从百度盘我的[share](http://pan.baidu.com/s/1hsbsWIS) 下载box.tar.gz,pypy-5.1.0-linux64.tar.bz2, images.tar.gz到k8s_coreos_install_cn目录下并将box.tar.gz解压（box.tar.gz需要解压，imges.tar.gz不需要解压）。如果你是linux系统，请从上面百度共享目录中linux子目录下的kubeclt到/usr/bin目录下，如果你是mac,从mac子目录下下载kubectl到/usr/bin目录下。
3. 通过系统自带的安装系统安装vagrant, virtualbox和pip, 如果是centos(fedora),请 `yum -y install vagrant virtualbox python-pip`; 如果是ubuntu 请 `sudo apt-get install vagrant virtualbox  python-pip `。 如果是macos, 请  `brew install vagrant virtualbox python `.
4.  `pip install ansible dnspython `.
5. 另开一个terminal,cd到k8s_coreos_install_cn目录， 运行  `python -m SimpleHTTPServer `.（此步骤是为了提供pypy-5.1.0-linux64.bar.bz2以及coreos box文件的下载服务。
6. 运行 `./bootstrap.sh <youlocalIP> copy` 请将youlocalIP替换成你的本机IP地址。
7. 等待上一步脚本运行完毕，在本机运行 `kubectl get nodes `验证安装是否成功。
8. 在本机运行 `kubectl proxy `,用浏览器打开http://localhost:8001/ui

在安装过程中如果遇到什么问题或者对k8s, docker, coreos等感兴趣，也欢迎加入k8s_cn(216249408)QQ群。
