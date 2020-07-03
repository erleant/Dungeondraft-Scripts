<#
.SYNOPSIS
Convert assets from supported formats to .webp format using ImageMagick.
ImageMagick can be downloaded from https://imagemagick.org
Suported formats are: bmp, dds, exr, hdr, jpg, jpeg, png, tga, svg, svgz

.DESCRIPTION
This script iterates through a specified subfolder, creates a duplicate of the folder structure, then converts each image file found in the source folder to a .webp file in the duplicate folder structure.
Supported image types are: bmp, dds, exr, hdr, jpg, jpeg, png, tga, svg, svgz

If a destination folder is not specified, the duplicate folder name will be the same as the source folder name with " - webp" appended to its name.
If the source folder is named "My Image Files", the duplicate folder will be named "My Image Files - webp"

This script uses ImageMagick to convert the files. ImageMagick can be downloaded from https://imagemagick.org

This script will also update data files to reflect the filename changes to .webp.

.PARAMETER Source
This specifies the source folder that contains the image files you wish to convert. This script is recursive, which means it will process any and all subfolders.

.PARAMETER Destination
This specifies the destination folder to which the webp files will be saved.

.EXAMPLE
DDConvertAssets.ps1 -Source "My PNG Files" -Destination "My webp Files"

.NOTES
You must have ImageMagick installed.
https://imagemagick.org
#>

param (
    [string]$Source = "",
    [string]$Destination = ""
) # param


function Test-ValidPathName {
    param([string]$PathName)

    $IndexOfInvalidChar = $PathName.IndexOfAny([System.IO.Path]::GetInvalidPathChars())

    # IndexOfAny() returns the value -1 to indicate no such character was found
    if($IndexOfInvalidChar -eq -1) {
        return $true
    } else {
        return $false
    } # if($IndexOfInvalidChar -eq -1)
} # function Test-ValidPathName

Function ValidateInput ($Src,$Dst) {
    $ReturnValue = [System.Collections.ArrayList]@()
    if ($Src -eq "") {
        [void]$ReturnValue.add($false)
        [void]$ReturnValue.add("    No value specified for Source.")
        return $ReturnValue
    } # if ($Src -eq "")

    if (-not (Test-ValidPathName $Src)) {
        [void]$ReturnValue.add($false)
        [void]$ReturnValue.add("    Invalid path name for Source: $Src")
        return $ReturnValue
    } # if (-not (Test-ValidPathName $Src))

    if (-not (Test-Path $Src)) {
        [void]$ReturnValue.Add($false)
        [void]$ReturnValue.Add("    Cannot find Source: $Src.")
        return $ReturnValue
    } # if (-not (Test-Path $Src))

    if ($Dst -eq "") {
        [void]$ReturnValue.add($false)
        [void]$ReturnValue.add("    No value specified for Destination.")
        return $ReturnValue
    } # if ($Src -eq "")

    if (-not (Test-ValidPathName $Dst)) {
        [void]$ReturnValue.Add($false)
        [void]$ReturnValue.Add("    Invalid path name for Destination: $Dst")
        return $ReturnValue
    } # if (-not (Test-ValidPathName $Dst))

} # Function ValidateInput

Function InvalidExit {
    Write-Output ""
    Write-Output "SYNTAX"
    Write-Output "    $PSScriptRoot\DDConvertAssets.ps1 [[-Source] <String>] [[-Destination] <String>]"
    Write-Output ""
    Write-Output "REMARKS"
    Write-Output "    To see the examples, type: ""get-help $PSScriptRoot\DDConvertAssets.ps1 -examples""."
    Write-Output "    For more information, type: ""get-help $PSScriptRoot\DDConvertAssets.ps1 -detailed""."
    Write-Output "    For technical information, type: ""get-help $PSScriptRoot\DDConvertAssets.ps1 -full""."
    Write-Output ""
    Write-Output "REQUIRED DEPENDENCIES"
    Write-Output "    ImageMagick must be installed."
    Write-Output "    https://imagemagick.org/index.php"
    Write-Output ""
    Exit
} # Function InvalidExit

# Main {
    $StartNow = Get-Date
    $ScriptName = "DDConvertAssets.ps1"
    $Version = 4

    Write-Output ""
    Write-Output "### Starting $ScriptName V.$Version at $StartNow"
    Write-Output ""

    if ($Destination -eq "") {$Destination = "$Source - webp"}
    $Validate = [System.Collections.ArrayList]@()
    $Validate = ValidateInput $Source $Destination
    if ($Validate.count -ge 1) {
        $Valid = $Validate[0]
        $ExitMessage = $Validate[1]
        If (-not $Valid) {
            Write-Output $ExitMessage
            Write-Output "### Exiting script due to invalid input."
            Write-Output ""
            InvalidExit
        } # If (-not $Valid)
    } else {
        Write-Output "    Input validated."
    } # if ($Validate.count -ge 1)

    
    $ProgramFiles = $env:ProgramFiles

    $ImageMagick = ((Get-Item $ProgramFiles\ImageMagick*\magick.exe).FullName)

    if ($ImageMagick -eq $null) {
        $Validate = [System.Collections.ArrayList]@()
        [void]$Validate.add($false)
        [void]$Validate.add("    Missing dependency: ImageMagick is not installed.")
    } # if ($ImageMagick = $null)
    

    if ($Validate.count -ge 1) {
        $Valid = $Validate[0]
        $ExitMessage = $Validate[1]
        If (-not $Valid) {
            Write-Output $ExitMessage
            Write-Output "### Exiting script due to missing dependency."
            Write-Output ""
            InvalidExit
        } # If (-not $Valid)
    } else {
        Write-Output "    Dependencies validated."
    }# if ($Validate.count -ge 1)

    Write-Output ""
    Write-Output "    Source: $Source"
    Write-Output "    Destination: $Destination"
    Write-Output ""

    $Source = Get-Item $Source
    if (Test-Path $Destination) {
        Write-Output "    Parent destination folder already exists."
    } else {
        Write-Output "    Creating parent destination folder..."
        New-Item $Destination -ItemType Directory | Out-Null
    } # if (Test-Path $Destination)
    Write-Output ""

    # Create a duplicate folder structure in a "$Source - webp" folder.
    Write-Output "    Replicating  folder structure..."
    $Destination = Get-Item $Destination
    $FolderList = (Get-ChildItem $source -Recurse -Directory).FullName.replace($source,$Destination)
    foreach ($folder in $FolderList) {
        if (Test-Path $folder) {
            Write-Output "        $folder already exists."
        } else {
            Write-Output "        Creating $folder."
            New-Item $folder -ItemType Directory | Out-Null
        } # if (Test-Path $folder)
    } # foreach ($folder in $FolderList)
    Write-Output "    Finished Replicating folder structure."
    Write-Output ""

    $FileTypes = @(".bmp",".dds",".exr",".hdr",".jpg",".jpeg",".png",".tga",".svg",".svgz",".webp")
    $Wildcards = [System.Collections.ArrayList]@()
    foreach ($Extension in $FileTypes) {[void]$Wildcards.add("*$Extension")}

    Write-Output "    Collecting  the list of all compatible image files from the parent source (.BMP, .DDS, .EXR, .HDR, .JPG, .JPEG, .PNG, .TGA, .SVG, .SVGZ)."
    $ImageFiles = Get-ChildItem -Recurse -File -Include $Wildcards $Source

    Write-Output "    Collecting  the list of all data files from the parent source (.dungeondraft_tags, .dungeondraft_tileset, .dungeondraft_wall, .json)."
    $DataFiles = @("*.dungeondraft_tags","*.dungeondraft_tileset","*.dungeondraft_wall","*.json")
    $DataFiles = Get-ChildItem $Source -Recurse -File -Include $DataFiles

    # Set the file output encoding to UTF8
    $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

    # In the collection of data files, replace instances of .png with .webp
    Write-Output "    Replacing filename extensions in all data files with .webp (.BMP, .DDS, .EXR, .HDR, .JPG, .JPEG, .PNG, .TGA, .SVG, .SVGZ)."
    foreach ($file in $DataFiles) {
        $DestinationFile = $file.fullname.replace($Source,$Destination)

        $FileContent = Get-Content $file.fullname
        foreach ($Extension in $FileTypes) {
            $FileContent = $FileContent -replace $Extension,'.webp'
        } # foreach ($Extension in $FileTypes)
        Set-Content $DestinationFile $FileContent | Out-Null

    } # foreach ($file in $DataFiles)
    Write-Output ""
    Write-Output  "    Converting each asset to webp..."
    foreach ($asset in $ImageFiles) {
        $ImageAsset = $asset.FullName
        $WEBPasset = $asset.DirectoryName + "\" + $asset.BaseName + ".webp"
        $WEBPasset = $WEBPasset.Replace($source,$Destination)
        if (Test-Path $WEBPasset) {
            Write-Output  "        $WEBPasset already exists."
        } else {
            if ($asset.extension -eq ".webp") {
                Write-Output  "        Copying $ImageAsset"
                Write-Output  "             to $WEBPasset"
                Copy-Item $ImageAsset $WEBPasset
            } else {
                Write-Output  "        Converting $ImageAsset"
                Write-Output  "                to $WEBPasset"
                & $ImageMagick convert $ImageAsset $WEBPasset
            }
        } # if (Test-Path $WEBPasset)
    } # foreach ($asset in $PNGFiles)
    Write-Output  "    Finished converting assets."
    $EndNow = Get-Date
    $RunTime = $EndNow - $StartNow
    Write-Output  ("### Ending $ScriptName V.$Version at $EndNow with a run time of " + ("{0:hh\:mm\:ss}" -f $RunTime))
    Write-Output  ""
# } Main