# 将模组从游戏文件夹同步到git文件夹

$MyDocuments = [Environment]::GetFolderPath('MyDocuments')
Write-Output "`"我的文档`"文件夹的完整路径为 $MyDocuments"
$a = Get-ChildItem $MyDocuments -Directory -Filter "Paradox Interactive"
if (-NOT $a) {
    Write-Error "不对劲！在我的文档里找不到P社文件夹。请确认您将启动器安装到了默认位置。"
    exit
}
$b = Get-ChildItem $a -Directory -Filter "Hearts of Iron IV"
if (-NOT $b) {
    Write-Error "不对劲！在P社文件夹里找不到钢四文件夹。请确认您安装了游戏。"
    exit
}
$c = Get-ChildItem $b -Directory -Filter "mod"
Write-Output "钢四模组文件夹的完整路径为   $($c.FullName)"
$ModDir = Get-ChildItem $c -Directory -Filter "1977"
$ModFile = Get-ChildItem $c -File -Filter "1977.mod"
if ($ModDir -AND $ModFile) {
    Copy-Item $ModDir -Destination $PWD -Force -Recurse
    Copy-Item $ModFile -Destination $PWD -Force
    Write-Output "已成功完成拉取！"
} else {
    Write-Error "缺失`"1977`"文件夹和/或`"1977.mod`"文件！请确认模组已安装。"
}
exit
