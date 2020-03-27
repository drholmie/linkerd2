﻿$ErrorActionPreference = 'Stop';
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$version = $env:chocolateyPackageVersion
$pp = Get-PackageParameters

if ($pp['path'] -ne $null){
	$lpath = $pp['path']
}
elseif (Test-Path env:linkerdPath) {
	$lpath = $env:linkerdPath
}
else {
	$lpath = $toolsPath
}

if ($pp['checksum'] -ne $null){
	$checksum = $pp['checksum']
}
else{
	$checksum = $env:linkerdCheckSum
}

$packageArgs = @{
  packageName    = 'linkerd'
  fileFullPath   = "$lpath\linkerd.exe"
  url64          = "https://github.com/linkerd/linkerd2/releases/download/$version/linkerd2-cli-$version-windows.exe"
  checksum       = $checksum
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs
Install-ChocolateyPath $packageArgs.fileFullPath 'User'
