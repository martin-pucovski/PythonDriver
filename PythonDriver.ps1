<#
.SYNOPSIS
    Script runs python script in virtual environment.
.DESCRIPTION
    This script expects a path to the python project as the first parameter. The project should contain virtual environment folder with name *venv*, in the root of the project. Before running the python script, it activates the virtual environment, runs the script, and then deactivates the environment. It logs any uncaught exception in the python script.
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    author: Martin Pucovski (martinautomates.com)
#>

# initials
$scriptLocation = Split-Path -Parent $MyInvocation.MyCommand.Definition
$scriptName = $MyInvocation.MyCommand.Name
$host.ui.RawUI.WindowTitle = $scriptName

$pythonProjectPath = $args[0]

# read config pathToMain
$configPath = Join-Path -Path $scriptLocation -ChildPath "config\config.psd1"

# activate enviroment
$venvPath = $pythonProjectPath + "\venv\Scripts\Activate.ps1"
. $venvPath

# run python code in enviroment
$pathToMain = $pythonProjectPath + "\src\main.py"

$processInfo = New-Object System.Diagnostics.ProcessStartInfo
$processInfo.FileName = "python"
$processInfo.Arguments = $pathToMain
$processInfo.RedirectStandardError = $true
$processInfo.RedirectStandardOutput = $true
$processInfo.UseShellExecute = $false
$processInfo.WorkingDirectory = $pythonProjectPath

$process = New-Object System.Diagnostics.Process
$process.StartInfo = $processInfo
$process.Start() | Out-Null

$stdout = $process.StandardOutput.ReadToEnd()
$stderr = $process.StandardError.ReadToEnd()
$process.WaitForExit()

Write-Host "Standard output: $stdout"
Write-Host "Standard error: $stderr"
Write-Host "exit code: " + $process.ExitCode

# deactivate enviroment
. "deactivate"
