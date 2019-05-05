1、java 和android 的安装位置可以更改，更改后，将环境变量中的位置进行同步更改

2、安装chrome时，先在https://www.ipip.net/ip.html 网址中查询 dl.google.com 的可用ip ，然后将echo中的ip 替换为所查询的ip

3、安装完成后，尝试输入mysql ，会提示cannot connect mysql.lock 问题
     需启动mysql 服务， service mysql start
     如果还继续报错，尝试以下步骤进行调试
	`service mysql stop`
	`usermod -d /var/lib/mysql/ mysql `
	`chown -R mysql:mysql /var/lib/mysql `
	`service mysql start `

4、 看到ok说明mysql服务已经正常启动，dockerfile中采用的静默安装，不会提示设置密码，第一次运行mysql时，需手动设置一个密码
	`mysqladmin -u root password $(your password)`

5、完成整体安装后，输入`appium-doctor` 命令，检查appium安装环境

6、挂在本地工作目录  镜像生成后，可在运行时，使用
	`docker run -it  -v  /e/vanthinkpro:/test  mydock:1.0 bin/bash`
   /e/vanthinkpro: 本地目录 必须是绝对路径
  /test : 挂载容易目录
