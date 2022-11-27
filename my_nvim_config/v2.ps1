#Requires -Version 7.1
$ErrorActionPreference = "Stop" # exit when command fails

$Env:XDG_CONFIG_HOME = "C:\projetos\neovim\config1"
$Env:XDG_DATA_HOME = "C:\projetos\neovim\config1"
$Env:runtimepath = "C:\projetos\neovim\config1"
$Env:JDTLS_JVM_ARGS = "-javaagent:C:\projetos\neovim\config1\lombok.jar"
nvim @args