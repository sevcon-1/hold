echo off
setlocal enabledelayedexpansion
TIMEOUT /t 1 /nobreak

REM 
REM DO NOT CHANGE THESE LINES
REM
set ident=NTMAMSG:
set LOG=%~dp0\%~n0.log
echo %ident% %~n0 started at %DATE% %TIME% >> %LOG%
set /a project+=1
REM 
REM END 
REM


REM
REM READ AND CHANGE VALUES BELOW IF ADDING A PROJECT
REM 

REM
REM START OF USER CONFIGURATION
REM

REM
REM THIS VARIABLE MUST REFLECT THE NUMBER OF PROJECTS
REM 
set number_of_projects=2

REM
REM Add in a new block (example below) for every new project. The project number will need to be incremented:
REM
REM
REM
REM  :project_<increment this number by 1>
REM  set bin=<absolute path to the bin directory of the domain
REM  set agents=<space delimited list of physical agents to start>
REM  GOTO AGENTS
REM
REM
REM

:project_1
REM NDMIS
set bin=ODI_12_2_HOME\user_projects\domains\ndmis_odi_domain\bin
set agents=OracleDIAgent1 OracleDIAgentUAT OracleDIAgentSyst OracleDIAgentDev
GOTO AGENTS

:project_2
REM SBCI
set bin=ODI_12_2_HOME\user_projects\domains\sbci_odi_domain1\bin
set agents=SBCIDODIAgent1
GOTO AGENTS

:project_3
REM set bin=E:\ODI_12_2_HOME\user_projects\domains\ntma_odi_domain\bin
REM set agents=C1 C2 C3 C4
REM GOTO AGENTS

REM
REM END OF USER CONFIGURATION
REM

REM 
REM Static Code below. Do Not Change
REM 
REM Do Not Change (unless fixing it!)
REM 

:AGENTS

(for %%a in (%agents%) do (
	rem cmd /c %~dp0\startComponent.cmd %%a
	echo %ident% %ident% Stopping agent: %%a >> %LOG%
	cmd /c %bin%\stopComponent.cmd %%a >> %LOG%
	
))

if (%project%) LSS (%number_of_projects%) (
	set /a project+=1
	goto project_!project!
)

echo %ident% %~n0 completed at %DATE% %TIME% >> %LOG%

endlocal disabledelayedexpansion
