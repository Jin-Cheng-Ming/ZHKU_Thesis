%===========================================================================%
%- 文档类 Document Class
%===========================================================================%
%% zhkuThesis.cls
%% Copyright 2024 Xinyu Ding <ding.xin.yu@foxmail.com> 
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%===========================================================================%
%->> 标识 Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}
\newcommand*\@iflatexlater{\@ifl@t@r\fmtversion}
\@iflatexlater{2017/01/01}{}{
  \ClassError{zhkuThesis}{TeXLive/MikTex >= 2017 is required ...}{}
}
\ProvidesClass{zhkuThesis}[2024/05/23 v1.0 ZHKU thesis document class]
%===========================================================================%
%->> 声明选项 Declare options
%---------------------------------------------------------------------------%
%-
%-> 布局 Layout
%-
\DeclareOption{oneside}{
  \PassOptionsToClass{oneside}{ctexbook}
}
\DeclareOption{twoside}{
  \PassOptionsToClass{twoside}{ctexbook}
}
\newif\ifZHKU@print \ZHKU@printfalse
\DeclareOption{print}{
  \PassOptionsToClass{twoside}{ctexbook}
  \ZHKU@printtrue
}
%-
%-> 语言 Language
%-
\newif\ifZHKU@plain \ZHKU@plainfalse
% 开启 plain 写作样式 enable plain writing style
\DeclareOption{scheme=plain}{
  \PassOptionsToClass{scheme=plain}{ctexbook}
  \ZHKU@plaintrue
}
%-
%-> 打印版本信息 Draft version info
%-
\newif\ifZHKU@versioninfo \ZHKU@versioninfofalse
\DeclareOption{draftversion}{
  \ZHKU@versioninfotrue
}
%-
%-> 处理未实现的选项 Handle non-implemented options
%-
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{ctexbook}
}
%-
%-> 终止所有选项处理 Terminates all options processing
%-
\ProcessOptions\relax
%===========================================================================%
%->> 加载类信息 Load class information
%---------------------------------------------------------------------------%
\LoadClass[UTF8,a4paper,zihao=-4]{ctexbook}
\@ifclasslater{ctexbook}{2017/01/01}{}{
  \ClassError{zhkuThesis}{ctex >= 2017/01/01 is required ...}{}
}
%===========================================================================%
%->> 依赖包 Required packages
%---------------------------------------------------------------------------%
% LaTeX engine detection
\RequirePackage{ifxetex}
% a toolbox of programming facilities
\RequirePackage{etoolbox}
% LaTeX3 programming environment
\RequirePackage{expl3}
% marker line
\RequirePackage{ulem}
% 
\RequirePackage{graphicx}
%===========================================================================%
%->> 加载类配置 Load class configuration
%---------------------------------------------------------------------------%
% class cfg loaded after package to make preamble commands take effect
\AtEndOfPackage{
  \makeatletter
  \InputIfFileExists{Config/zhkuThesis.cfg}{}{}
  \makeatother
}
%===========================================================================%
%->> 页面布局 Page layout
%---------------------------------------------------------------------------%
\usepackage{geometry}
\geometry{a4paper,top=2.5cm,left=2.7cm,bottom=2.5cm,right=2.7cm}
\usepackage{fancyhdr}
%===========================================================================%
%->> 样式控制命令 Style control commands
%---------------------------------------------------------------------------%
%- 
%-> 重定义 \cleardoublepage 使其有页面样式参数
%-> redefine cleardoublepage to have page style argument
%- 
\renewcommand{\cleardoublepage}[1][plain]{
  \clearpage
  \if@twoside
    \ifodd
      \c@page
    \else
      \thispagestyle{#1}
      \hbox{}\newpage
      \if@twocolumn
        \hbox{}\newpage
      \fi
    \fi
  \fi
}
% unified name
\newcommand{\ulunify}[1]{\uline{#1}}
% enhanced underline
\newcommand{\ulenhance}[2][1pt]{
  % set thickness
  \def\ULthickness{#1}
  % set depth
  \setlength{\ULdepth}{0.5em}
  % linebreak fix
  \expandafter\ulunify\expandafter{#2}
}
% 下划线的水平偏移 horizontal shift on underline
\newcommand{\ulhshift}{-4em}
% 扩展下划线长度 extend underline length
\newcommand{\ulextend}[2][350pt]{
  \hbox to #1{\hfill\hspace*{\ulhshift}#2\hfill}}
%===========================================================================%
%->> 字体 Font
%---------------------------------------------------------------------------%
%-
%-> 英文字体
%-
\setmainfont{Times New Roman} % 常规英文字体
\setsansfont{Arial} % 非衬线字体
\setmonofont{Consolas} % 打字机字体，代码字体


%-
%-> 中文字体配置部分
%-
% 使用包来设置中文字体
\usepackage{xeCJK}
% 正文字体
\setCJKmainfont[AutoFakeBold=true]{SimSun}
% 无衬线字体
\setCJKsansfont[AutoFakeBold=3]{KaiTi}
% 等宽字体
\setCJKmonofont[AutoFakeBold=3]{SimHei}

\let\kaishu\relax
\newCJKfontfamily\kaishu{KaiTi}[AutoFakeBold]
\let\heiti\relax
\newCJKfontfamily\heiti{SimHei}[AutoFakeBold]
\let\songti\relax
\newCJKfontfamily\songti{SimSun}[AutoFakeBold]
%===========================================================================%
%->> 新环境 New environments
%---------------------------------------------------------------------------%
%-
%-> 定义中文关键字环境 define chinese keywords
%-
\newcommand{\keywords}[1]{
    \vspace{\baselineskip}
    \zihao{-4}
    \noindent {\heiti\bfseries\ZHKU@label@ch@keywords}~\songti{#1}}
%-
%-> 定义英文关键字环境 define engish keywords
%-
\newcommand{\KEYWORDS}[1]{
    \vspace{\baselineskip}
    \zihao{-4}
    \noindent {\bfseries\ZHKU@label@en@keywords}~#1}
%===========================================================================%
%->> 封面页 Titlepage
%---------------------------------------------------------------------------%
%-
%-> 学位类型 Degree type
%-
% 是否专硕 professional degree
\newif\ifZHKU@professionalDegree    \ZHKU@professionalDegreefalse
\newcommand{\professional}          {\ZHKU@professionalDegreetrue}
\newcommand{\academic}              {\ZHKU@professionalDegreefalse}
%-
%-> 中文项获取信息命令 Chinese item commands
%-
\newcommand{\schoolCode}[1]         {\def\ZHKU@value@ch@schoolCode{#1}}
\newcommand{\studentCode}[1]        {\def\ZHKU@value@ch@studentCode{#1}}
\newcommand{\classificationCode}[1] {\def\ZHKU@value@ch@classificationCode{#1}}
\newcommand{\confidential}[1]       {\def\ZHKU@value@ch@confidential{#1}}
\newcommand{\schoolLogo}[2][]       {\def\ZHKU@value@ch@schoolLogo{\includegraphics[#1]{#2}}}
\renewcommand{\title}[2][\ZHKU@value@ch@title]{
                                      \def\ZHKU@value@ch@title{#2}
                                      %\def\ZHKU@value@ch@titlemark{\MakeUppercase{#1}}}
                                      \def\ZHKU@value@ch@titlemark{#1}}
\renewcommand{\author}[1]{\def\ZHKU@value@ch@author{#1}}
\newcommand{\enTitle}[1]            {\def\ZHKU@value@ch@enTitle{#1}}
\newcommand{\coverTitle}[1]         {\def\ZHKU@value@ch@coverTitle{#1}}
\newcommand{\authorName}[1]         {\def\ZHKU@value@ch@authorName{#1}}
\newcommand{\advisor}[1]            {\def\ZHKU@value@ch@advisor{#1}}
\newcommand{\advisorFirst}[1]       {\def\ZHKU@value@ch@advisor@first{#1}}
\newcommand{\advisorSecond}[1]      {\def\ZHKU@value@ch@advisor@second{#1}}
\newcommand{\professionalDegreeCategory}[1]{\def\ZHKU@value@ch@category{#1}}
\newcommand{\field}[1]              {\def\ZHKU@value@ch@field{#1}}
\newcommand{\institute}[1]          {\def\ZHKU@value@ch@institute{#1}}
\newcommand{\major}[1]              {\def\ZHKU@value@ch@major{#1}}
\newcommand{\city}[1]               {\def\ZHKU@value@ch@city{#1}}
\newcommand{\degreeConferralDate}[2]{
                                      \def\ZHKU@value@ch@completionDate@year{#1}
                                      \def\ZHKU@value@ch@completionDate@month{#2}}

%-
%-> 定义中文样式 Define Chinese style
%-
\newcommand{\makeTitle}{
  \cleardoublepage
  \thispagestyle{empty}
  {
    \zihao{-4}
    \begin{tabular}{p{9cm}p{6cm}}
      {
        \begin{tabular}[c]{rl}
          \hspace{-2em}\ZHKU@label@ch@schoolCode & \ZHKU@value@ch@schoolCode \\
          \hspace{-2em}\ZHKU@label@ch@classificationCode & \ZHKU@value@ch@classificationCode
        \end{tabular}
      }
      &
      {
        \begin{tabular}[c]{p{2em}l}
          \hspace{-2em}\ZHKU@label@ch@studentCode & \ZHKU@value@ch@studentCode \\
          \hspace{-2em}\ZHKU@label@ch@confidential & \ZHKU@value@ch@confidential \\
        \end{tabular}
      }\\[24pt]
    \end{tabular}
  }
  \\
  \vspace*{\stretch{1}}
  {
    \begin{tabular}{p{0.8cm}p{8cm}}
      \hfill & \ZHKU@value@ch@schoolLogo 
    \end{tabular}
  }
  \\
  \vspace*{\stretch{1}}
  {
    \begin{center}
      {
        \kaishu\bfseries\fontsize{45}{\baselineskip}{\ZHKU@label@ch@thesis@mas}\\
        \ifZHKU@professionalDegree{\ZHKU@label@ch@thesis@professional\\}\fi
        \vspace*{\stretch{4}}
        \heiti\bfseries\zihao{2}\textbf{\ZHKU@value@ch@title}\\
        \vspace*{\stretch{8}}
        \heiti\zihao{3}\textbf{\ZHKU@value@ch@author}\\
        \vspace*{\stretch{8}}
      }
      \songti\zihao{4}
      {
        \ifZHKU@professionalDegree{
          \begin{tabular}{p{7em}p{10em}}
            {
              \begin{flushright}
                \bfseries\textbf{\ZHKU@label@ch@advisor@first}\\[18pt]
                \bfseries\textbf{\ZHKU@label@ch@advisor@second}\\[18pt]
                \bfseries\textbf{\ZHKU@label@ch@institute}\\[18pt]
                \bfseries\textbf{\ZHKU@label@ch@category}\\[18pt]
                \bfseries\textbf{\ZHKU@label@ch@field}\\[18pt]
              \end{flushright}
            }
            &
            {
              \begin{flushleft}
                \ZHKU@value@ch@advisor@first\\[18pt]
                \ZHKU@value@ch@advisor@second\\[18pt]
                \ZHKU@value@ch@institute\\[18pt]
                \ZHKU@value@ch@category\\[18pt]
                \ZHKU@value@ch@field\\[18pt]
              \end{flushleft}
            }
          \end{tabular}}
        \else{
          \begin{tabular}{p{7em}p{10em}}
            {
              \begin{flushright}
                \bfseries\textbf{\ZHKU@label@ch@advisor}\\[18pt]
                \bfseries\textbf{\ZHKU@label@ch@institute}\\[18pt]
                \bfseries\textbf{\ZHKU@label@ch@major}\\[18pt]
              \end{flushright}
            }
            &
            {
              \begin{flushleft}
                \ZHKU@value@ch@advisor\\[18pt]
                \ZHKU@value@ch@institute\\[18pt]
                \ZHKU@value@ch@major\\[18pt]
              \end{flushleft}
            }
          \end{tabular}}
        \fi
      } 
      \\
      \vspace*{\stretch{12}}
      \zihao{-4}
      {
        \ZHKU@value@ch@city
        \\
        \ZHKU@value@ch@completionDate@year~年~\ZHKU@value@ch@completionDate@month~月  
      }
    \end{center}
  }
  {
  \clearpage
    \if@twoside
      \thispagestyle{empty}
      \ifZHKU@versioninfo
        \vspace*{\stretch{1}}
        \begin{footnotesize}
          \noindent Draft Version (\today)
        \end{footnotesize}
      \fi
      \cleardoublepage[empty]
    \else
      \ifZHKU@versioninfo
        \thispagestyle{empty}
        \vspace*{\stretch{1}}
        \begin{footnotesize}
          \noindent Draft Version (\today)
        \end{footnotesize}
        \cleardoublepage[empty]
      \fi
    \fi
  \ifZHKU@print
    % 设置超链接 set hyperlinks
    \hypersetup{
      % 删除链接颜色和边框 remove link color and border
      hidelinks,
    }
  \fi
  }
}
%===========================================================================%
%->> 作者声明 Author declaration
%---------------------------------------------------------------------------%
\newcommand{\makeDeclaration}{
    \cleardoublepage
    \thispagestyle{empty}
    {
        \linespread{1.6}
        \songti\fontsize{15}{1}

        \begin{center}
          \songti\bfseries\fontsize{21.5}{\baselineskip}
          {\ZHKU@label@ch@university} \\[9pt]
          {\ZHKU@label@ch@declare@creativity}
        \end{center}
        
        {\ZHKU@value@ch@declare@creativity}

        \vspace*{2ex}
  
        \begin{tabular}{p{19em}p{14em}}
          \ZHKU@label@ch@declare@author \underline{\hbox to 48mm{}} \hfill & 
          \ZHKU@label@ch@declare@date \underline{\hbox to 44mm{}}\\
        \end{tabular}

        \vspace*{6ex}

        \begin{center}
          \songti\bfseries\fontsize{21.5}{\baselineskip}
          {\ZHKU@label@ch@declare@rights}
        \end{center}

        {\ZHKU@value@ch@declare@rights}

        \vspace*{2ex}

        \begin{tabular}{p{19em}p{14em}}
          \ZHKU@label@ch@declare@author \underline{\hbox to 48mm{}} \hfill & 
          \ZHKU@label@ch@declare@date \underline{\hbox to 44mm{}}\\[9pt]
          \ZHKU@label@ch@declare@advisor \underline{\hbox to 48mm{}} \hfill & 
          \ZHKU@label@ch@declare@date \underline{\hbox to 44mm{}}\\
        \end{tabular}

        \vspace*{6ex}

        \begin{center}
          \songti\bfseries\fontsize{21.5}{\baselineskip}  
          {\ZHKU@label@ch@declare@submission}
        \end{center}

        {\ZHKU@value@ch@declare@submission}

        \vspace*{2ex}

        \begin{tabular}{p{19em}p{14em}}
          \ZHKU@label@ch@declare@advisor \underline{\hbox to 48mm{}} \hfill & 
          \ZHKU@label@ch@declare@date \underline{\hbox to 44mm{}}\\
        \end{tabular}

        \vspace*{3ex}

        \vspace*{3ex}
    }
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
}
%===========================================================================%
%->> 结构元素 Structure elements
%---------------------------------------------------------------------------%
% \ifZHKU@plain
%     \def\contentsname{\ZHKU@label@en@tocname}
%     \def\listfigurename{\ZHKU@label@en@lsfigname}
%     \def\listtablename{\ZHKU@label@en@lstabname}
%     \def\bibname{\ZHKU@label@en@bibname}
%     \def\refname{\ZHKU@label@en@bibname}
%     \def\algname{\ZHKU@label@en@algname}
%     \def\bibetal{\ZHKU@label@en@bibetal}
%     \def\biband{\ZHKU@label@en@biband}
%     \def\axiomname{\ZHKU@label@en@axiomname}
%     \def\theoremname{\ZHKU@label@en@theoremname}
%     \def\lemmaname{\ZHKU@label@en@lemmaname}
%     \def\corollaryname{\ZHKU@label@en@corollaryname}
%     \def\assertionname{\ZHKU@label@en@assertionname}
%     \def\propositionname{\ZHKU@label@en@propositionname}
%     \def\conjecturename{\ZHKU@label@en@conjecturename}
%     \def\definitionname{\ZHKU@label@en@definitionname}
%     \def\examplename{\ZHKU@label@en@examplename}
%     \def\remarkname{\ZHKU@label@en@remarkname}
%     \def\proofname{\ZHKU@label@en@proofname}
%     \def\@title{\ZHKU@value@en@titlemark}
%     \def\@author{\ZHKU@value@en@author}
% \else
    \def\contentsname{\ZHKU@label@ch@tocname}
    \def\listfigurename{\ZHKU@label@ch@lsfigname}
    \def\listtablename{\ZHKU@label@ch@lstabname}
    \def\algname{\ZHKU@label@ch@algname}
    \def\bibname{\ZHKU@label@ch@bibname}
    \def\refname{\ZHKU@label@ch@bibname}
    \def\bibetal{\ZHKU@label@ch@bibetal}
    \def\biband{\ZHKU@label@ch@biband}
    \def\axiomname{\ZHKU@label@ch@axiomname}
    \def\theoremname{\ZHKU@label@ch@theoremname}
    \def\lemmaname{\ZHKU@label@ch@lemmaname}
    \def\corollaryname{\ZHKU@label@ch@corollaryname}
    \def\assertionname{\ZHKU@label@ch@assertionname}
    \def\propositionname{\ZHKU@label@ch@propositionname}
    \def\conjecturename{\ZHKU@label@ch@conjecturename}
    \def\definitionname{\ZHKU@label@ch@definitionname}
    \def\examplename{\ZHKU@label@ch@examplename}
    \def\remarkname{\ZHKU@label@ch@remarkname}
    \def\proofname{\ZHKU@label@ch@proofname}
    \def\@title{\ZHKU@value@ch@titlemark}
    \def\@author{\ZHKU@value@ch@author}
% \fi
%===========================================================================%
%->> 结构布局 Structure layout
%---------------------------------------------------------------------------%
%-
%-> 章 chapter
%-
\ctexset {
    chapter = {
        format = \linespread{1.0}\zihao{4}\bfseries\sffamily\centering,
        nameformat = {},
        titleformat = {},
        number = \arabic{chapter},
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {7pt},
        afterskip = {18pt},
        pagestyle = plain,
    }
}
%-
%- 节 section
%-
\ctexset {
    section = {
        format = \linespread{1.0}\zihao{-4}\sffamily\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {24pt},
        afterskip = {6pt},
    }
}
%-
%-> 子节 subsection
%-
\ctexset {
    subsection = {
        format = \linespread{1.0}\zihao{-4}\sffamily\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}
%-
%-> 子节的子节（第三级） subsubsection
%-
\ctexset {
    subsubsection = {
        format = \linespread{1.0}\zihao{-4}\sffamily\raggedright,
        numberformat = \rmfamily,
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}
%-
%-> 附录 appendix
%-
\ctexset {
    appendix = {
        numbering = false,
        number = \rmfamily\Alph{chapter},
    }
}
%===========================================================================%
%->> 组件 Component
%---------------------------------------------------------------------------%
\usepackage{array}
\usepackage{longtable}
%===========================================================================%
