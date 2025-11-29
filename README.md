# LAZYZSH ZSH 终端增强懒人包

## 特性

- 基本的 zsh 配置（高性能 prompt 美化 + 命令高亮 + 历史命令提示）
- 常用的 alias 配置（详情查看 [alias.zsh](./alias.zsh)）
- WSL2 中有用的 alias 和环境变量
- 好用的命令 cli 整合（可选项，仅支持 Linux 环境）

## 前提

1. zsh
2. git

## 安装

lazyzsh 的目录为 `~/.lazyzsh/`
**安装命令**

```
#克隆代码
git clone --depth 1 "https://github.com/stevenhobs/lazyzsh ~/.lazyzsh"

#镜像站克隆代码（如果克隆失败）
git clone --depth 1 "https://ghfast.top/https://github.com/stevenhobs/lazyzsh" ~/.lazyzsh

#引入配置
echo "source ~/.lazyzsh/lazy.zsh" >> ~/.zshrc
```

你可以修改`init_plugins.zsh`开头内容以禁用某些插件。

> [!Note]
> 更改登录的 shell 执行 `chsh --shell /bin/zsh`

### 引入第三方 cli 程序（可选）

- 安装的 cli 程序会存放在 `~/.lazyzsh/bin/`；
- 安装的 cli 程序的初始化 zsh 文件 `~/.lazyzsh/bin/.lazy_bin_init.zsh`；
- 你可以修改`x_add_cli.zsh`开头内容以禁止一些 cli 安装及其初始设定；
- 目前所安装的程序仅支持 latest 最新版，重新执行命令即可全部 cli 更新。
- 该过程确保`tar`和`curl`命令可用。
  **一行命令安装**

```
zsh ~/.lazyzsh/x_add_cli.zsh
```

> [!Note]
> 此步骤需要访问 **Github** 资源，请确保网络可用。

目前整合的 cli 命令行程序有：

- 7zip
- fastfetch
- superfile
- zoxide
- bottom
- fd
- bat
- aichat