param(
    [Parameter(mandatory)]
    [string]$projectName
)
# Version of Unity editor installed to create project with
$version = "2020.3.16f1"
$unityPath = "D:\installs\unity_editors\$version\Editor\Unity.exe"
$projectBasePath = "D:\grontisio\gamedev\"
$projectDirectory = "$projectBasePath$projectName"
$projectDirectory

$unityPathExists = Test-Path -Path $unityPath
if(!$unityPathExists)
{
    Write-Error -Message "Unity execution path $unityPath does not exist" -ErrorAction Stop
}

$projectBasePathExists = Test-Path -Path $projectBasePath
if(!$projectBasePathExists)
{
    Write-Error -Message "Base project path $projectBasePath does not exist" -ErrorAction Stop
}

$projectDirectoryExists = Test-Path -Path $projectDirectory
if($projectDirectoryExists)
{
    Write-Error -Message "Unity project already exists at $projectDirectory" -ErrorAction Stop
}

Write-Host "Initializing new Unity($version) project: $projectName"

$unityExe = "$unityPath -createProject $projectDirectory"
Invoke-Expression $unityExe

# while loop to halt execution of further commands until the project directory is created
Write-Host "Project directory creating..."
$directoryCreated = Test-Path -Path "D:\grontisio\gamedev\$projectName\"
while(!$directoryCreated)
{
    $directoryCreated = Test-Path -Path "D:\grontisio\gamedev\$projectName\"
}

#init git repo and copy over .gitignore and create readme
Write-Host "Initializing project git repository with gitignore and readme..."
git init "D:\grontisio\gamedev\$projectName\"

# copy generic Unity & jetbrains idea .gitignore to project folder
Copy-Item "D:\grontisio\gamedev\.gitignore" -Destination "D:\grontisio\gamedev\$projectName\"
Copy-Item "D:\grontisio\gamedev\readme.md" -Destination "D:\grontisio\gamedev\$projectName\"

"# $projectName" > "D:\grontisio\gamedev\$projectName\readme.md"