@echo off
set localdir=E:\apk_hotfix\
::set PATH=%localdir%;%CD%;%PATH%;
set apk_dir=E:\WebServer\nginx\html\Ma55_Output\Ma55_OutPut\
set save_dir=E:\WebServer\nginx\html\Ma55_Output\Ma55_Hotfix\
set dat_dir=E:\WebServer\nginx\html\Ma55_Output\Ma55_dll\
set i_type=%2
set p_name=%1
set F=%apk_dir%%p_name%
set f_name=%p_name:~0,-4%
set apk=%F%
set unsing_apk=%f_name%\usign_%p_name%
set hotfix_apk=%f_name%\hotfix_%p_name%
set zip_file=%dat_dir%%f_name%_dll.zip


cd %localdir%

if not defined i_type (set i_type=debug)

rd /s/q %f_name%

mkdir %f_name%
mkdir %f_name%\tmp 
mkdir %f_name%\Dll

set tmp=%f_name%\tmp\
set out=%f_name%\Dll\
set dat=%f_name%\dat\
set src=%f_name%\src\
set dir=%f_name%\src\assets\bin\Data\Managed\
set ver=4.6

::开始解包apk
call decomplier.bat %apk% %src%

::开始加密DLL
copy /y %dir%*.dll  %tmp%
for %%i in (Boo.Lang.dll,Mono.Security.dll,mscorlib.dll,System.Core.dll,System.dll,System.Runtime.Serialization.dll,System.ServiceModel.dll,System.ServiceModel.Web.dll,System.Xml.dll) do (
	del /q %tmp%%%i
	echo remove:%%i
)
for /f %%i in ('dir "%f_name%\tmp\*.dll" /s /b') do (
	crytion.exe  %%i %out%%%~nxi
	echo 加密成功:%%~nxi
)

::开始替换libmono

copy /y %out%*.dll %dir%*.dll
copy /y %ver%\cryptMono\%i_type%\armv7a\libmono.so %src%lib\armeabi-v7a\libmono.so
copy /y %ver%\cryptMono\%i_type%\x86\libmono.so %src%lib\x86\libmono.so

::apk包加入内置md5列表文件:
mkdir %dat%
copy /y %out%*.* %dat%*.*

::保存代码资源和生成md5列表文件:
python md5_generate.py %dat% %zip_file%
copy /y %dat%CHECKSUM.json %src%assets\CHECKSUM.json

::重新打包
call recomplier.bat %localdir%%src% %localdir%%unsing_apk%

::重新签名
jarsigner.exe -verbose -keystore hs.keystore -storepass ab1155 -keypass ab1155 -digestalg SHA1 -sigalg MD5withRSA -tsa http://timestamp.digicert.com -signedjar %hotfix_apk% %unsing_apk% herostory

::保存hotfix处理的包:
del /s/q %save_dir%hotfix_%p_name%
copy /y %hotfix_apk% %save_dir%

::清理临时文件及目录:
rd /s/q %f_name%

ECHO.
echo apk包hotfix逻辑替换完成
@pause