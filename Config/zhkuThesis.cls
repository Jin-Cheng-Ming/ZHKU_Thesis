% 文档类
%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%

% 版权声明 Copyright 
%---------------------------------------------------------------------------%

%---------------------------------------------------------------------------%

%->> 身份证 Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}
\newcommand*\@iflatexlater{\@ifl@t@r\fmtversion}
\@iflatexlater{2017/01/01}{}{
  \ClassError{zhkuThesis}{TeXLive/MikTex >= 2017 is required ...}{}
}
\ProvidesClass{zhkuThesis}[2024/05/23 v1.0 ZHKU thesis document class]

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
\DeclareOption{scheme=plain}{% enable plain writing style
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
%---------------------------------------------------------------------------%

%->> 加载类信息 Load class information
%---------------------------------------------------------------------------%
\LoadClass[UTF8,a4paper,zihao=-4]{ctexbook}
\@ifclasslater{ctexbook}{2017/01/01}{}{
  \ClassError{zhkuThesis}{ctex >= 2017/01/01 is required ...}{}
}
%---------------------------------------------------------------------------%

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
%---------------------------------------------------------------------------%

%->> 加载类配置 Load class configuration
%---------------------------------------------------------------------------%
% class cfg loaded after package to make preamble commands take effect
\AtEndOfPackage{
  \makeatletter
  \InputIfFileExists{Config/zhkuThesis.cfg}{}{}
  \makeatother
}
%---------------------------------------------------------------------------%

%->> 页面布局 Page layout
%---------------------------------------------------------------------------%
\usepackage{geometry}
\geometry{a4paper,top=2.52cm,left=3.15cm,bottom=2.22cm,right=3.15cm}
%---------------------------------------------------------------------------%

%->> 样式控制命令 Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
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
%---------------------------------------------------------------------------%

%->> 字体 Font
%---------------------------------------------------------------------------%
% 英文字体
\setmainfont{Times New Roman} % 常规英文字体
\setsansfont{Arial} % 非衬线字体
\setmonofont{Consolas} % 打字机字体，代码字体

%使用包来设置中文字体
\usepackage{xeCJK}

% 中文字体配置部分
%正文字体
\setCJKmainfont[AutoFakeBold=true]{SimSun}
%无衬线字体
\setCJKsansfont[AutoFakeBold=3]{KaiTi}
%等宽字体
\setCJKmonofont[AutoFakeBold=3]{SimHei}

\let\kaishu\relax
\newCJKfontfamily\kaishu{KaiTi}[AutoFakeBold]
\let\heiti\relax
\newCJKfontfamily\heiti{SimHei}[AutoFakeBold]
\let\songti\relax
\newCJKfontfamily\songti{SimSun}[AutoFakeBold]
%---------------------------------------------------------------------------%


%->> 封面页 Titlepage
%---------------------------------------------------------------------------%
%-
%-> 中文项命令 Chinese item commands
%-
% \def\zhku@value@ch@schoolCode{}
% \def\zhku@value@ch@studentCode{}
% \def\zhku@value@ch@classificationCode{}
% \def\zhku@value@ch@confidential{公开}
% \def\zhku@value@ch@thesisTitle{}
% \def\zhku@value@ch@authorName{}
% \def\zhku@value@ch@advisor{}
% \def\zhku@value@ch@college{}
% \def\zhku@value@ch@major{}
% \def\zhku@value@ch@city{中国·广州}
% \def\zhku@value@ch@completionDate@year{}
% \def\zhku@value@ch@completionDate@month{}
\newcommand{\schoolCode}[1]         {\def\ZHKU@value@ch@schoolCode{#1}}
\newcommand{\studentCode}[1]        {\def\ZHKU@value@ch@studentCode{#1}}
\newcommand{\classificationCode}[1] {\def\ZHKU@value@ch@classificationCode{#1}}
\newcommand{\confidential}[1]       {\def\ZHKU@value@ch@confidential{#1}}
\newcommand{\schoolLogo}[2][]       {\def\ZHKU@value@ch@schoolLogo{\includegraphics[#1]{#2}}}
\newcommand{\thesisTitle}[1]        {\def\ZHKU@value@ch@thesisTitle{#1}}
\newcommand{\authorName}[1]         {\def\ZHKU@value@ch@authorName{#1}}
\newcommand{\advisor}[1]            {\def\ZHKU@value@ch@advisor{#1}}
\newcommand{\institute}[1]          {\def\ZHKU@value@ch@institute{#1}}
\newcommand{\major}[1]              {\def\ZHKU@value@ch@major{#1}}
\newcommand{\city}[1]               {\def\ZHKU@value@ch@city{#1}}
\newcommand{\degreeConferralDate}[2]     {
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
    \begin{tabular}{p{8cm}p{6cm}}
      {
        \begin{tabular}[c]{rl}
          \hspace{-2em}\ZHKU@label@ch@schoolCode & \ZHKU@value@ch@schoolCode \\
          \hspace{-2em}\ZHKU@label@ch@classificationCode & \ZHKU@value@ch@classificationCode
        \end{tabular}
      }
      &
      {
        \begin{tabular}[c]{rl}
          \hspace{-2em}\ZHKU@label@ch@studentCode & \ZHKU@value@ch@studentCode \\
          \hspace{-2em}\ZHKU@label@ch@confidential & \ZHKU@value@ch@confidential \\
        \end{tabular}
      }\\[24pt]
    \end{tabular}
  }
  \\
  \vspace*{\stretch{1}}
  {
    \begin{tabular}{p{0.5em}p{8cm}}
      \hfill & \ZHKU@value@ch@schoolLogo 
    \end{tabular}
  }
  \\
  \vspace*{\stretch{1}}
  {
    \begin{center}
      {
        \kaishu\bfseries\fontsize{45}{\baselineskip}{硕\qquad 士\qquad 学\qquad 位\qquad 论\qquad 文}\\
        % \vspace{9pt}
        \vspace*{\stretch{4}}
        \heiti\bfseries\fontsize{21.5}{\baselineskip}\textbf{\ZHKU@value@ch@thesisTitle}\\
        % \vspace{24pt}
        \vspace*{\stretch{8}}
        \heiti\fontsize{15.5}{\baselineskip}\textbf{\ZHKU@value@ch@authorName}\\
        % \vspace{24pt}
        \vspace*{\stretch{8}}
      }
      \songti\fontsize{14}{\baselineskip}
      \def\arraystretch{1.3}
      {
        \begin{tabular}{rl}
          \bfseries\textbf{\ZHKU@label@ch@advisor} & \ZHKU@value@ch@advisor 
          \\[18pt]
          \bfseries\textbf{\ZHKU@label@ch@institute} & \ZHKU@value@ch@institute 
          \\[18pt]
          \bfseries\textbf{\ZHKU@label@ch@major} & \ZHKU@value@ch@major 
          \\[18pt]
        \end{tabular}
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
  \ifZHKU@print%
    \hypersetup{% set hyperlinks
        hidelinks,% remove link color and border
    }
  \fi
  }
}

%-
%-> Detect and adjust items
%-


%---------------------------------------------------------------------------%
