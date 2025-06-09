# ZHKU Thesis：仲恺农业工程学院学位论文 Latex 模板

`v0.4`

## 🔈 模板简介

一款基于 [ucasthesis](https://github.com/mohuangrui/ucasthesis) 的 LaTeX 模板，专为 [《仲恺农业工程学院研究生学位论文撰写规范（2023年修订）》](https://yjs.zhku.edu.cn/info/1060/4945.htm) 量身定制，提供了样式适配和简化的自定义配置操作。该模板旨在帮助大家快速生成符合规范的学位论文。

### 模板特点

- **全面支持**：目前模板支持硕士学位论文，包括封面、书脊、原创性声明、版权使用授权书、论文提交书、中文摘要及关键词、英文摘要及关键词、英文缩略词或符号表、正文目录、图表目录、正文、参考文献、附录、致谢、作者简介及成就等模板页。
- **灵活配置**：支持自定义**学术型硕士**或**专业型硕士**的封面样式，操作简单，易于上手。
- **兼容性强**：支持多种 LaTeX 编译引擎（pdfLaTeX、xeLaTeX、luaLaTeX），适配中文环境，兼容Windows、Linux、MacOS操作系统。
- **高扩展性**：可以根据需求进一步调整模板样式和功能，满足个性化需求。

### 使用建议

如果你觉得这个模板对你有帮助，请点击右上角的 Star 按钮支持一下！如果有其他需求或问题，可以通过 Discussion 或 Issue 提交反馈，也可直接联系我：[ding.xin.yu@foxmail.com](mailto:ding.xin.yu@foxmail.com)。希望该项目能够继续发展，解决各位同学毕业论文写作中的排版困难。

> **提示**：建议在使用模板前仔细阅读模板注释和相关文档，以便更高效地完成论文撰写。

## ⭐ 下载模板

你可以通过以下方式获取模板：

### 方法一：直接克隆项目

使用以下命令克隆 GitHub 或 Gitee 仓库：

```bash
# 克隆 GitHub 仓库
git clone https://github.com/Jin-Cheng-Ming/ZHKU_Thesis.git

# 或者使用 Gitee 镜像
git clone https://gitee.com/DingXinYu/ZHKU_Thesis.git
```

### 方法二：下载压缩包

直接下载项目文件的压缩包：[master.zip](https://github.com/Jin-Cheng-Ming/ZHKU_Thesis/archive/refs/heads/master.zip) ，下载后解压缩即可使用。

> **提示**：建议优先使用 Git 克隆方式获取模板，以便后续更新时可以直接拉取最新版本。

## 🌈 使用说明

可以选择在线编辑编译或者本地编辑编译。

### 在线编辑编译

推荐使用 [TexPage](https://www.texpage.com)，因为相比 Overleaf，TexPage 的网络环境更稳定，中文编译适配更好，没有编译页数限制。将项目文件压缩包上传至 TexPage 中在线编辑。编译该模板请使用 XeLaTeX 引擎，使用默认的设置即可顺利完成编译生成 PDF 文件。也可以直接在TexPage发布的[模板](https://www.texpage.com/zh/template/6ff6d020-886b-4266-8295-17551280ff57)新建项目使用。

### 本地编辑编译

#### 安装 TeX 发行版

建议使用 [MiKTEX](https://miktex.org/download)，特别是在 Windows 平台上，因为这个 TeX 发行版易于安装和更新。可以选择安装完整的发行版或仅安装基本组件，根据你的硬盘空间需求灵活选择。

具体过程可以参考该篇教程：[MiKTex安装 - YanMing-lxb](https://github.com/YanMing-lxb/YM-VSCode-Configurations-for-LaTeX/blob/main/Docs/MiKTeX%E5%AE%89%E8%A3%85%E6%95%99%E7%A8%8B.md)

#### 编辑工具

推荐使用 [Visual Studio Code](https://code.visualstudio.com/) 编辑器。

##### 1. 下载 `VS Code`

从微软 VS Code 官网下载：[https://code.visualstudio.com](https://code.visualstudio.com)

##### 2. 安装 `LaTeX Workshop` 扩展插件

在 VS Code 扩展中搜索：`LaTeX Workshop`，作者为 James Yu。

##### 3. 配置 `LaTeX Workshop`

点击左下角齿轮图标展开菜单，进入 `设置`，根据需要在用户或工作区设置中搜索 `LaTeX Workshop`（更精准进入插件设置可搜索：`@ext:James-Yu.latex-workshop`）。重点关注以下设置项：

- `latex-workshop.latex.Auto Build:Run`：设置为 `onSave`，即当保存文件时自动编译。
- `latex-workshop.latex.Auto Clean:Run`：设置为 `onSucceeded`，即编译成功后清理中间产物。
- `latex-workshop.latex.Clean:Method`：设置为 `glob`，根据文件格式清理。
- `latex-workshop.latex.Clean:File Types`：补充以下文件格式后缀条目：

    ```text
    "*.aux"
    "*.bbl"
    "*.blg"
    "*.idx"
    "*.ind"
    "*.lof"
    "*.lot"
    "*.out"
    "*.toc"
    "*.acn"
    "*.acr"
    "*.alg"
    "*.glg"
    "*.glo"
    "*.gls"
    "*.ist"
    "*.fls"
    "*.log"
    "*.fdb_latexmk"
    ```

- `latex-workshop.latex.Tools`：定义 LaTeX 编译工具。需要在 `settings.json` 中编辑，其中重点配置`xelatex`工具，代码如下：

    ```json
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-pdf",
                "%DOC%"
            ]
        },
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        },
        {
            "name": "clean",
            "command": "xelatex",
            "args": [
                "--clean"
            ]
        }
    ]
    ```

- `latex-workshop.latex.Recipes`：定义 LaTeX 编译配方。需要在 `settings.json` 中编辑，其中重点配置`XeLaTeX -> MakeIndex -> BibTeX`的编译链，代码如下：

    ```json
    "latex-workshop.latex.recipes": [
        {
            "name": "XeLaTeX -> MakeIndex -> BibTeX",
            "tools": [
                "xelatex",
                "bibtex",
                "xelatex",
                "xelatex"
            ]
        },
        {
            "name": "pdflatex -> BibTeX -> pdflatex*2",
            "tools": [
                "pdflatex",
                "bibtex",
                "pdflatex",
                "pdflatex"
            ]
        }
    ]
    ```

##### 4. 开始论文编辑

查看模板注释或文档，开始论文 LaTeX 编辑并编译。编译该模板请使用 XeLaTeX 引擎。全编译指运行 xeLaTeX+bibtex+xeLaTeX+xeLaTeX 以正确生成所有的引用链接，如目录、参考文献及引用等。在写作过程中若无添加新的引用，则可用快速编译，即只运行一遍 LaTeX 编译引擎以减少编译时间（注意需要取消临时文件的清除配置）。

##### 5. 统计字数（可选）

安装 `latex-wordcount` 扩展插件。该插件通过 Texcount 计数，排除命令和环境代码，仅计算 PDF 中显示的字词。安装后，状态栏会显示当前 Tex 文件的字数信息，选中部分代码时会显示选中部分的字数。

> **注意**：使用模板过程中如有问题，请先尝试更新至最新版，若仍未解决可在 `Issues` 中反馈。在线写作平台默认使用 pdfLATEX 编译，你需要重新设置使用 XeLaTeX 编译器。另外由于上传模板需要审核周期，更新频繁时候建议 GitHub 下载。

## 📖 Latex帮助文档

[ [简单粗暴LaTeX](https://github.com/wklchris/Note-by-LaTeX) ] [ [LaTex - Runebook.dev](https://runebook.dev/zh/docs/latex/-index-) ]

[ [ucasthesis 知识小站](https://github.com/mohuangrui/ucasthesis/wiki) ][ [WiKibook Tables](https://en.wikibooks.org/wiki/LaTeX/Tables) ]

## ⚠️ 已知问题

- [ ] 学位论文原创性声明、使用授权书和提交同意书不能输入信息
- [ ] Windows系统编译的中文粗体为伪粗体

## 💬 反馈与贡献

### 反馈问题

如果在使用上有任何问题，建议通过以下方式进行反馈：

- 如遇不会使用、编译错误等问题，请 [**在 GitHub 项目讨论区提问**](https://github.com/Jin-Cheng-Ming/ZHKU_Thesis/discussions) (推荐)
- 如遇模版 BUG，或有新的需求，请  [**在 GitHub 项目中提issues**](https://github.com/YanMing-lxb/GUET_Thesis_LaTeX/issues)

### 成为贡献者

这个仓库是面向用户的示例模版，如果你有很好的排版示例，可以提交到此仓库与大家分享。

除了提交 Pull Request 之外，还有以下方式可以进行贡献：

- 帮助解答同学们的问题，这些问题你也可能遇到过并且知道如何解决；
- 与我们一起维护项目的 Wiki 文档，Wiki 任何人都可以直接编辑；
- 向周围同学安利ZHKU Thesis，让更多的同学使用；
- 在我们的讨论组中分享你的使用体验，以及吐槽。如果你也想成为项目的长期维护者，也可以通过讨论组告诉我们。:-)

## 🎉 更新历史

- v0.4 2025年4月12日
新增盲审模式
更新使用说明

- v0.3 2025年4月12日
更新使用说明，简化部分设置操作

- v0.2 2025年4月1日
补充完善规范样式

- v0.1 20240528
完成核心模板功能开发，第一个预发布版本

## 👐 使用到的开源项目

GB/T 7714-2015 BibTeX Style
https://github.com/zepinglee/gbt7714-bibtex-style

biblatex-gb7714-2015: a biblatex style package
https://github.com/hushidong/biblatex-gb7714-2015

ucasthesis 国科大学位论文 LaTeX 模板
https://github.com/mohuangrui/ucasthesis

latexspine LaTeX 书脊模板
https://github.com/mohuangrui/latexspine

## 📜 软件许可证

仲恺农业工程学院校徽校名图片（`zhku_logo_*.png` 等）的版权归仲恺农业工程学院所有。其他部分使用 [LPPL](https://www.latex-project.org/lppl/) 授权。

## 🌟 点赞历史

[![Star History Chart](https://api.star-history.com/svg?repos=Jin-Cheng-Ming/ZHKU_Thesis&type=Date)](https://api.star-history.com/svg?repos=Jin-Cheng-Ming/ZHKU_Thesis&type=Date)

<div align="center">

✨(✪ω✪)✨  多多分享

</div>
