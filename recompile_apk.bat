@echo off
set localdir=E:\apk_hotfix\
set apkdir=E:\WebServer\nginx\html\Ma55_Output\Ma55_OutPut\
E:
cd %localdir%
echo ������Ҫ�����apk������apkλ��E:\WebServer\nginx\html\Ma55_Output\Ma55_OutPut
echo ֻ��Ҫ����������� hxh_v0.8.3_NetEaseDev.apk
set /p in_source=
if exist %apkdir%%in_source% (goto a) else (goto b)
:a                            (��ǩ)
ECHO.
echo ��ʼ����...
debug_Hotfix.bat %in_source%
goto end
:b                            (��ǩ)
ECHO.
echo "apk�ļ�:%in_source% ������"
goto c
:c                            (��ǩ)
ECHO.
echo ������Ҫ�����apk������apkλ��E:\WebServer\nginx\html\Ma55_Output\Ma55_OutPut
echo ֻ��Ҫ����������� hxh_v0.8.3_NetEaseDev.apk
set /p in_source=
if exist %apkdir%%in_source% (goto a) else (goto b)
:end                            (��ǩ)
ECHO.
echo �˳� ......
pause