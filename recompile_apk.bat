@echo off
set localdir=E:\apk_hotfix\
set apkdir=E:\WebServer\nginx\html\Ma55_Output\Ma55_OutPut\
E:
cd %localdir%
echo 请输入要处理的apk包名，apk位于E:\WebServer\nginx\html\Ma55_Output\Ma55_OutPut
echo 只需要输入包名，如 hxh_v0.8.3_NetEaseDev.apk
set /p in_source=
if exist %apkdir%%in_source% (goto a) else (goto b)
:a                            (标签)
ECHO.
echo 开始处理...
debug_Hotfix.bat %in_source%
goto end
:b                            (标签)
ECHO.
echo "apk文件:%in_source% 不存在"
goto c
:c                            (标签)
ECHO.
echo 请输入要处理的apk包名，apk位于E:\WebServer\nginx\html\Ma55_Output\Ma55_OutPut
echo 只需要输入包名，如 hxh_v0.8.3_NetEaseDev.apk
set /p in_source=
if exist %apkdir%%in_source% (goto a) else (goto b)
:end                            (标签)
ECHO.
echo 退出 ......
pause