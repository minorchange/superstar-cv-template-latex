\ProvidesClass{cv}[2021/03/05 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%------------------------------------------------------------------------------
%	PACKAGES
%------------------------------------------------------------------------------

\RequirePackage[sfdefault]{ClearSans}
\RequirePackage[T1]{fontenc}
\RequirePackage{tikz}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage{ifmtarg}
\RequirePackage{ifthen}
\RequirePackage{pgffor}
\RequirePackage{marvosym}
\RequirePackage{parskip}
\RequirePackage{fontawesome}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{scrextend}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%------------------------------------------------------------------------------
%	 COLOURS
%------------------------------------------------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{sectoinheadlinecolor}{RGB}{51,51,51}
\definecolor{namecolor}{HTML}{4D4D4D}
\definecolor{iconcolor}{HTML}{4D4D4D}
\definecolor{barfgcolor}{HTML}{4D4D4D}

\definecolor{leftsidebgcolor}{HTML}{E7E7E7}
\definecolor{barbgcolor}{HTML}{B9B9B9}
\definecolor{certificateframecolor}{HTML}{E7E7E7}
\definecolor{certificateframecaptioncolor}{HTML}{000000}

%------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%------------------------------------------------------------------------------


\pagestyle{empty}
\setlength{\parindent}{0pt} % Disable paragraph indentation

%------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\pgfmathsetlength{\imagewidth}{5cm}
\newlength\imagescale
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Length of remaining line width after title 
\newlength{\SectionTitleLength} % Length to hold the width of the section title
\newcommand{\linesection}[2]{
	\setlength\TotalSectionLength{\linewidth}% Set the total line width
	\settowidth{\SectionTitleLength}{#2 #1}% Calculate width of section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Width: Total-Title
	\addtolength\TotalSectionLength{-2.22221pt}% remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{sectoinheadlinecolor} #2 #1 
		\rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print Title 
}
\newcommand{\profilesection}[1]{\linesection{#1}{\Large}}
\newcommand{\profilesubsection}[1]{\\ \\{
	\color{sectoinheadlinecolor} \large #1 \\ \\}
}

\newcommand{\mainsection}[1]{%
	\setlength\TotalSectionLength{\linewidth}% Set otal line width
	\settowidth{\SectionTitleLength}{\Large #1 }% Calculate width of section title
	\addtolength\TotalSectionLength{-\SectionTitleLength}% Width: Total-Title
	\addtolength\TotalSectionLength{-2.22221pt}% remove overfull box warning
	\vspace{8pt}% Whitespace before the section title
	{\color{sectoinheadlinecolor} \Large #1 
		\rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print Title
}

% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{
	\node[shape=circle,draw,inner sep=1pt, fill=leftsidebgcolor,leftsidebgcolor,
	text=iconcolor] (char) {#1};}}

% Comomand for printing the Skill Bars
\newcommand{\bars}[1]{
	\begin{tikzpicture}
		\foreach [count=\i] \x/\y in {#1}{
			\draw[fill=barbgcolor,barbgcolor] (0,\i) rectangle (0.92\linewidth,\i+0.3);
			\draw[fill=barfgcolor,barfgcolor](0,\i) rectangle (0.92\linewidth*\y,\i+0.3);
			\node [above right] at (0,\i+0.3) {\x};
		}
	\end{tikzpicture}
}

% Command for printing the "Soft" Skills
\newcommand\skillssoc[1]{ 
	\renewcommand{\skillssoc}{
	\bars{#1}
	}}
	
% Command for printing the Tec Skills
\newcommand\skillstec[1]{ 
	\renewcommand{\skillstec}{
	\bars{#1}
	}}
	
% Command for printing a sinme
\newcommand\skillslang[1]{ 
	\renewcommand{\skillslang}{
		\begin{tikzpicture}
			\node [above right] at (0,0.3) {#1};
		\end{tikzpicture}
	}
}



%----------------------------------------------------------------------------------------
%	 LONG LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the long list
\newenvironment{cvitemize}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\cvitem}[4]{%
	#1& \parbox[t]{0.83\textwidth}{%
		\textbf{#2}%
		\hfill%
		{\footnotesize#3}\\%
		#4\vspace{\parsep}%
	}\\
}

%---------------------------------------------------------------------------------------
%	 SMALL LIST ENVIRONMENT
%----------------------------------------------------------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the small list
\newenvironment{cvitemizeshort}{%
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
	\end{tabular*}
}

\newcommand{\cvitemshort}[2]{%
	#1&\parbox[t]{0.83\textwidth}{%
		\textbf{#2}%
	}\\
}

%---------------------------------------------------------------------------------------
%	 One Page with title and Frame per certificate
%----------------------------------------------------------------------------------------

\newcommand{\framedcertificate}[2]{
  	\newpage
  	\phantomsection
	\addcontentsline{toc}{section}{#1}
	\begin{tikzpicture}[remember picture,overlay]
		\node[inner sep=0pt] (russell) at (page cs:0,0-0.25cm){\includegraphics[width=0.8325\paperwidth, height=0.85\paperheight]{#2}};	
		\draw[line width=\framethickness, certificateframecolor, line cap=\framelinecap](page cs:\maxleft,\maxtop)--(page cs:\maxright,\maxtop);
		\draw[line width=\framethickness, certificateframecolor, line cap=\framelinecap](page cs:\maxright,\maxtop)--(page cs:\maxright,\maxdown);
		\draw[line width=\framethickness, certificateframecolor, line cap=\framelinecap](page cs:\maxright,\maxdown)--(page cs:\maxleft,\maxdown);
		\draw[line width=\framethickness, certificateframecolor, line cap=\framelinecap](page cs:\maxleft,\maxdown)--(page cs:\maxleft,\maxtop);
		\node[line width=\framethickness, certificateframecolor, fill = certificateframecolor, line cap=\framelinecap, draw, anchor=south west] at 
	     (page cs:\maxleft+0.3cm-\framethickness/2,\maxtop-\framethickness/2) {{\color{certificateframecaptioncolor}#1}};
	     \node[anchor=north east] at 
	     (page cs:\maxright-\framethickness/2,\maxdown-\framethickness/2) {{\color{certificateframecolor}\thepage}};
		
	\end{tikzpicture}
	\newpage
}



%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}

\RequirePackage[hidelinks]{hyperref}

