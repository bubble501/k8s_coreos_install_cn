# k8s_coreos_install_cn

k8s_coreos_install_cn is a project which can be used to install kubernetes on coreos
without need to access the public network.

It's always painful to install kubernetes in china because of the GFW between the china
and outside. the default installation of k8s on coreos will try to fetch some images from
gcr.io and quay.io which is unaccessiable from china. k8s_coreos_install_cn solve this issue
by put these images on baidu pan beforehand.

As for we using ansible to do install, k8s_coreos_install_cn only works on linux and mac.

Before install, make sure ansible(>=2.2) is installed on your machine.

To install on vagrant virtual boxes, make sure vagrant and virtualbox are installed too.

Following is the example step of how to using k8s_coreos_install_cn to install k8s on three
vagrant virtual boxes.(You can use it to install k8s on bare metal by config the hosts file)

1. git clone https://github.com/bubble501/k8s_coreos_install_cn.git
2. cd k8s_coreos_install_cn and run vagrant up
3. Download images file from baidu pan https://pan.baidu.com/s/1mi0nmdE  and put it to directory k8s_coreos_install_cn
4. Download pypy from baidu pan https://pan.baidu.com/s/1qYTlnBm and put it to directory k8_coreos_install_cn
5. After step 3 and 4, both file images.tar.gz and pypy-5.1.0-linux64.tar.bz2 should be under directory k8_coreos_install_cn
6. ssh to coreos and scp pypy-5.1.0-linux64.tar.bz2 to /home/core directory.
7. run ansible-playbook -i hosts cluster.yml .
8. over.



https://pan.baidu.com/s/1mi0nmdE images address
https://pan.baidu.com/s/1qYTlnBm pypy address
