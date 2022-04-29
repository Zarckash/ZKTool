@echo off
echo
echo install power plan
powercfg -import %userprofile%\AppData\Local\Temp\ZKTool\Apps\HighestPerformance.pow 77777777-7777-7777-7777-777777777777
echo
echo set power plan active
powercfg -SETACTIVE "77777777-7777-7777-7777-777777777777"
echo
echo delete power saver
powercfg -delete a1841308-3541-4fab-bc81-f71556f20b4a
