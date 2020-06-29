<#
.SYNOPSIS
Copy image files from another file structure to the textures\objects folder of an asset pack folder.
Particularly with Campaign Cartographer folder structures, copy only files of the highest-available quality while avoiding duplicates.

.DESCRIPTION
This script iterates through the immediate subfolders (one level deep) of a source folder.
For each subfolder, it finds all the image files, and it replicates the folder structure to the "textures\objects" folder of the specified destination folder.
Though this script should work for any folder structure that containst assets as image files,
    it was designed primarily for Campaign Cartographer assets, as those folders contain different versions of the same asset at different qualities.
Instead of copying all versions of the same asset, this script will copy only the highest-quality version it can find.
(Copying the highest-quality version is particular to Campaign Cartographer due to Campaign Cartographer's naming conventions.)


.PARAMETER Source
This specifies the source folder whose folder structure you want to replicate.

.PARAMETER Destination
This specifies the name of the folder that you're going to pack as your custom asset pack. Do not include "textures\objects" in the path. The script automatically drills down to those.
For example, if the folder you intend to pack is "MyDungeonPack", include the full path to that folder, but no deeper. The script will automatically convert that to "MyDungeonPack\textures\objects" when it needs to do so.
If the Destination folder you specify does not exist, it will be created.

.PARAMETER CreateTagFile
Set this to $true or $false (default = $true)
If CreateTagFile is set to $true, this script will call .\DDTagAssets.ps1 to automatically create a default.dungeondraft.tags file in the data folder.
In order for this to work, both scripts must be in the same folder.

.PARAMETER Portals
Setting this parameter to $true will copy all files that start with "Door ","Doors ","Window " or "Windows " to the portals folder instead of the objects folder.
Setting this paramter to $false will copy all files to the objects folder and subfolders, regardless of them being named as doors or windows.
The default value is $true

.EXAMPLE
DDCopyAssets.ps1 -Source "C:\ProgramData\Profantasy\CC3Plus\Symbols\Castles" -Destination "My_Asset_Folders\Castles"

.EXAMPLE
DDCopyAssets.ps1 -Source "C:\ProgramData\Profantasy\CC3Plus\Symbols\Castles" -Destination "My_Asset_Folders\Castles" -CreateTagFile $true

.EXAMPLE
DDCopyAssets.ps1 "C:\ProgramData\Profantasy\CC3Plus\Symbols\Castles" "My_Asset_Folders\Castles" -Portals $true


.NOTES
If you set the CreatTagFile parameter as true, you must have the "DDTagAssets.ps1" script in the same folder as this one.
https://gitlab.com/EightBitz/dungeondraft-scripts
#>

param (
    [string]$Source = "",
    [string]$Destination = "",
    [string]$CreateTagFile = '$false',
    [string]$Portals = '$true'
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

Function ValidateInput ($Src,$Dst,$Tag,$Prt) {

    if ($Src -eq "") {
        [array]$ReturnValue = $false
        [array]$ReturnValue += "    No value specified for Source."
        return $ReturnValue
    } # if ($Src -eq "")

    if (-not (Test-ValidPathName $Src)) {
        [array]$ReturnValue = $false
        [array]$ReturnValue += "    Invalid path name for Source: $Src"
        return $ReturnValue
    } # if (-not (Test-ValidPathName $Src))

    if (-not (Test-Path $Src)) {
        [array]$ReturnValue = $false
        [array]$ReturnValue += "    Cannot find Source: $Src."
        return $ReturnValue
    } # if (-not (Test-Path $Src))

    if ($Dst -eq "") {
        [array]$ReturnValue = $false
        [array]$ReturnValue += "    No value specified for Destination."
        return $ReturnValue
    } # if ($Src -eq "")

    if (-not (Test-ValidPathName $Dst)) {
        [array]$ReturnValue = $false
        [array]$ReturnValue += "    Invalid path name for Destination: $Dst"
        return $ReturnValue
    } # if (-not (Test-ValidPathName $Dst))

    $Tag = $Tag.ToLower()
    Switch ($Tag) {
        'true' {}
        '$true' {}
        "$true" {}
        $true {}

        'false' {}
        '$false' {}
        "$false" {}
        $false {}
        default {
            [array]$ReturnValue = $false
            [array]$ReturnValue += '    CreateTagFile must be True or False'
            return $ReturnValue
        } # default
    } # Switch ($Tag)

    $Prt = $Prt.ToLower()
    Switch ($Prt) {
        'true' {}
        '$true' {}
        "$true" {}
        $true {}

        'false' {}
        '$false' {}
        "$false" {}
        $false {}
        default {
            [array]$ReturnValue = $false
            [array]$ReturnValue += '    Portals must be True or False'
            return $ReturnValue
        } # default
    } # Switch ($Tag)

} # Function ValidateInput

Function StringToBool ($Str) {
    $Str = $Str.ToLower()
    Switch ($Str) {
        'true' {[bool]$Bool = $true}
        '$true' {[bool]$Bool = $true}
        "$true" {[bool]$Bool = $true}
        $true {[bool]$Bool = $true}

        'false' {[bool]$Bool = $false}
        '$false' {[bool]$Bool = $false}
        "$false" {[bool]$Bool = $false}
        $false {[bool]$Bool = $false}
    } # Switch ($Tag)
    return $Bool
} # Function StringToBool

Function Check-Dependencies {
    param([array]$DepList)

    foreach ($Dep in $DepList) {
        if (-not (Test-Path $Dep)) {
            [array]$ReturnValue = $false
            [array]$ReturnValue += "    Missing dependendy: $Dep"
            return $ReturnValue
        } # foreach ($Dep in $DepList)
    } # foreach ($Dep in $DepList)
} # Function Check-Dependencies

Function InvalidExit {
    <# Info #> ""
    <# Info #> "SYNTAX"
    <# Info #> "    $PSScriptRoot\DDCopyAssets.ps1 [[-Source] <String>] [[-Destination] <String>] [[-CreateTagFile] <String>] [[-Portals] <String>]"
    <# Info #> ""
    <# Info #> "REMARKS"
    <# Info #> "    To see the examples, type: ""get-help $PSScriptRoot\DDCopyAssets.ps1 -examples""."
    <# Info #> "    For more information, type: ""get-help $PSScriptRoot\DDCopyAssets.ps1 -detailed""."
    <# Info #> "    For technical information, type: ""get-help $PSScriptRoot\DDCopyAssets.ps1 -full""."
    <# Info #> ""
    <# Info #> "REQUIRED DEPENDENCIES"
    <# Info #> "    $PSScriptRoot\DDTagAssets.ps1"
    <# Info #> ""
    Exit
} # Function InvalidExit

# Main {
    $StartNow = Get-Date
    $ScriptName = "DDCopyAssets"
    $Version = 3

    <# Info #> ""
    <# Info #> "### Starting $ScriptName V.$Version at $StartNow"
    <# Info #> ""

    $Validate = @()
    $Validate = ValidateInput $Source $Destination $CreateTagFile $Portals
    if ($Validate.count -ge 1) {
        $Valid = $Validate[0]
        $ExitMessage = $Validate[1]
        If (-not $Valid) {
            <# Info #> $ExitMessage
            <# Info #> "### Exiting script due to invalid input."
            <# Info #> ""
            InvalidExit
        } # If (-not $Valid)
    } else {
        <# Info #> "    Input validated."
    } # if ($Validate.count -ge 1)

    [Array]$Dependencies = ($PSScriptRoot + "\DDTagAssets.ps1")
    $Validate = @()
    $Validate = Check-Dependencies $Dependencies
    if ($Validate.count -ge 1) {
        $Valid = $Validate[0]
        $ExitMessage = $Validate[1]
        If (-not $Valid) {
            <# Info #> $ExitMessage
            <# Info #> "### Exiting script due to missing dependency."
            <# Info #> ""
            InvalidExit
        } # If (-not $Valid)
    } else {
        <# Info #> "    Dependencies validated."
    }# if ($Validate.count -ge 1)

    [bool]$CreateTagFile = StringToBool $CreateTagFile
    [bool]$Portals = StringToBool $Portals

    <# Info #> ""
    <# Info #> "    Source: $Source"
    <# Info #> "    Destination: $Destination"
    <# Info #> "    Create tag file: $CreateTagFile"
    <# Info #> "    Copy doors and windows to the portals folder instead of the objects folder: $Portals"
    <# Info #> "        (This works based on the filename starting with ""Door "", ""Doors "", ""Window "" or ""Windows "")"
    <# Info #> ""

    # Initialize some variables
    $ParentSrc = $source
    $ParentDst = $destination
    $ObjectDst = "\textures\objects"
    if ($Portals) {$PortalDst = "\textures\portals"} else {$PortalDst = "\textures\objects"}
    $FileTypes = @(".bmp",".dds",".exr",".hdr",".jpg",".jpeg",".png",".tga",".svg",".svgz")
    
    # Set up an array of wildcard patterns that includes each extension in $FileTypes
    $Wildcards = @()
    foreach ($Extension in $FileTypes) {$Wildcards += "*$Extension"}

    # Set up an array of wildcard patterns for very high quality files ("*_VH.*") that includes each extension in $FileTypes
    #     *_VH.bmp, *_VH.dds, *_VH.exr, et al
    $VHWildcards = @()
    foreach ($Extension in $FileTypes) {$VHWildcards += "*_VH$Extension"}

    # Set up an array of wildcard patterns for high quality files ("*_HI.*") that includes each extension in $FileTypes
    #     *_HI.bmp, *_HI.dds, *_HI.exr, et al
    $HIWildcards = @()
    foreach ($Extension in $FileTypes) {$HIWildcards += "*_HI$Extension"}

    # Set up an array of wildcard patterns to exlcude to only get standard quality files.
    $StandardWildcards = @()
    $StandardWildcards += $VHWildcards
    $StandardWildcards += $HIWildcards
    foreach ($Extension in $FileTypes) {
        $StandardWildcards += "*_LO$Extension"
        $StandardWildcards += "*_VL$Extension"    
    } # foreach ($Extension in $FileTypes)

    # Set up an array of wildcard patterns for very high quality doors and windows that includes each extension in $FileTypes
    #     "Door *_VH.bmp", "Door *_VH.dds", "Door *_VH.exr", et al
    $VHPortalWildcards = @()
    foreach ($Extension in $FileTypes) {
        $VHPortalWildcards += "Door *_VH$Extension"
        $VHPortalWildcards += "Doors *_VH$Extension"
        $VHPortalWildcards += "Window *_VH$Extension"
        $VHPortalWildcards += "Windows *_VH$Extension"
    } # foreach ($Extension in $FileTypes)

    # Set up an array of wildcard patterns for high quality doors and windows that includes each extension in $FileTypes
    #     "Door *_VH.bmp", "Door *_VH.dds", "Door *_VH.exr", et al
    $HIPortalWildcards = @()
    foreach ($Extension in $FileTypes) {
        $HIPortalWildcards += "Door *_HI$Extension"
        $HIPortalWildcards += "Doors *_HI$Extension"
        $HIPortalWildcards += "Window *_HI$Extension"
        $HIPortalWildcards += "Windows *_HI$Extension"
    } # foreach ($Extension in $FileTypes)

    # Set up an array of wildcard patterns for low and very low quality doors and windows to exclude each extension in $FileTypes
    #     "Door *_LO.bmp", "Door *_LO.dds", "Door *_LO.exr", et al
    $LOPortalWildCards = @()
    foreach ($Extension in $FileTypes) {
        $LOPortalWildcards += "Door *_LO$Extension"
        $LOPortalWildcards += "Doors *_LO$Extension"
        $LOPortalWildcards += "Window *_LO$Extension"
        $LOPortalWildcards += "Windows *_LO$Extension"
        $LOPortalWildcards += "Door *_VL$Extension"
        $LOPortalWildcards += "Doors *_VL$Extension"
        $LOPortalWildcards += "Window *_VL$Extension"
        $LOPortalWildcards += "Windows *_VL$Extension" 
    } # foreach ($Extension in $FileTypes)

    # Set up an array of wildcard patterns for all doors and windows to exclude each extension in $FileTypes
    $PortalWildcards = @()
    $PortalWildcards += $VHPortalWildcards
    $PortalWildcards += $HIPortalWildcards
    $PortalWildcards += $LOPortalWildcards
    $PortalWildcards += $VLPortalWildcards

    # Get all objects of very high quality (files designated as "_VH.*")
    #     and store the base names in $VHNames for later comparison
    <# Info #> "    Collecting names of very-high-quality objects for later comparison."
    $VHNames = Get-ChildItem -Recurse -File -Include $VHWildcards $Source
    $VHNames = $VHNames.Name
    foreach ($Extension in $FileTypes){$VHNames = $VHNames -replace "_VH$Extension"}

    # Get all objects of high quality (files designated as "_HI.*")
    #     and store the base names in $HINames for later comparison
    <# Info #> "    Collecting names of high-quality objects for later comparison."
    $HINames = Get-ChildItem -Recurse -File -Include $HIWildcards $Source
    $HINames = $HINames.Name
    foreach ($Extension in $FileTypes){$HINames = $HINames -replace "_HI$Extension"}


    # Get all very-high-quality objects, excluding doors and windows.
    <# Info #> "    Collecting objects of very high quality (excluding doors and windows)..."
    $NewObjects = Get-ChildItem -Recurse -File -Include $VHWildcards -Exclude $PortalWildcards $Source

    # Get all high-quality objects, excluding doors and windows, that are not duplicates of very-high-quality objects.
    <# Info #> "    Collecting objects of high quality (excluding doors and windows) that are not duplicates of very high quality objects..."
    $NewObjects += Get-ChildItem -Recurse -File -Include $HIWildcards -Exclude $PortalWildcards $Source | Where-Object {(($_.Name -replace $_.Extension -replace "_HI") -notin $VHNames)}
    
    # Get all standard-quality objects, excluding doors and windows, that are not duplicates of very-high-quality objects or high-quality objects.
    <# Info #> "    Collecting objects of standard quality (excluding doors and windows) that are not duplicates of very high quality or high quality objects..."
    $ExcludeWildcards = $StandardWildcards += $PortalWildcards
    $NewObjects += Get-ChildItem -Recurse -File -Include $Wildcards -Exclude $ExcludeWildcards $Source | Where-Object {(($_.Name -replace $_.Extension) -notin $VHNames) -and (($_.Name -replace $_.Extension) -notin $HINames)}

    # Get all very-high-quality doors and windows.
    <# Info #> "    Collecting doors and windows of very high quality..."
    $NewPortals = Get-ChildItem -Recurse -File -Include $VHPortalWildcards $Source

    # Get all high-quality doors and windows that are not duplicates of very-high-quality doors and windows.
    <# Info #> "    Collecting doors and windows of high quality that are not duplicates of high quality objects..."
    $NewPortals += Get-ChildItem -Recurse -File -Include $HIPortalWildcards $Source | Where-Object {(($_.Name -replace $_.Extension -replace "_HI") -notin $VHNames)}
    
    # Get all standard-quality doors and windows that are not duplicates of very-high-quality doors and windows or high-quality doors and windows.
    <# Info #> "    Collecting doors and windows of standard quality that are not duplicates of very high quality or high quality objects..."
    $NewPortals += Get-ChildItem -Recurse -File -Include $PortalWildcards -Exclude $LOPortalWildcards $Source | Where-Object {(($_.Name -replace $_.Extension) -notin $VHNames) -and (($_.Name -replace $_.Extension) -notin $HINames)}
    <# Info #> ""

    # Process objects
    if ($NewObjects.count -ge 1) {
        <# Info #> "    Replicating folder structure for objects..."

        $ObjectFolderList = $NewObjects.Directory.fullname | Select -Unique
        foreach ($Folder in $ObjectFolderList) {
            If ($folder.contains($ObjectDst)) {
                $ReplaceSource = $Destination
            } else {
                $ReplaceSource = $Destination + $ObjectDst
            } # If ($folder.contains($ObjectDst))

            $FolderDst = $Folder.replace($Source,$ReplaceSource)
            if (-not (Test-Path $FolderDst)) {New-Item $FolderDst -ItemType Directory | Out-Null}
        } # foreach ($Folder in $ObjectFolderList)

        # Copy Objects
        foreach ($Object in $NewObjects) {
            <# Info #> "    Copying " + $Object.fullname + "..."
            $CopySource = $Object.fullname
            $CopyDestination = $Object.fullname.replace($Source,$ReplaceSource)
            Copy-Item $CopySource $CopyDestination | Out-Null
        } # foreach ($Object in $NewObjects)
        <# Info #> ""
    } # if ($NewObjects.count -ge 1)

    # Process doors and windows
    if ($NewPortals.count -ge 1) {
        <# Info #> "    Replicating folder structure for portals..."
        $PortalFolderList = $NewPortals.Directory.fullname | Select -Unique
        foreach ($Folder in $PortalFolderList) {
            If ($folder.contains($PortalDst)) {
                $ReplaceSource = $Destination
            } else {
                $ReplaceSource = $Destination + $PortalDst
            } # If ($folder.contains($ObjectDst))

            $FolderDst = $Folder.replace($Source,$ReplaceSource)
            if (-not (Test-Path $FolderDst)) {New-Item $FolderDst -ItemType Directory | Out-Null}
        } # foreach ($Folder in $ObjectFolderList)

        foreach ($Object in $NewPortals) {
            <# Info #> "    Copying " + $Object.fullname + "..."
            $CopySource = $Object.fullname
            $CopyDestination = $Object.fullname.replace($Source,$ReplaceSource)
            Copy-Item $CopySource $CopyDestination | Out-Null
        } # foreach ($Object in $NewPortals)
        <# Info #> ""
    } # if ($NewPortals.count -ge 1)

    # If $CreateTagFile is true, run DDAssetTags7.ps1 to create the tag file. 
    if ($CreateTagFile) {
        $workingfolder = [System.IO.DirectoryInfo]$ParentDst
        $packlocation = $workingfolder.Parent.FullName 
        $assetfolders = $workingfolder.Name
        <# Info #> "    Passing control to DDTagAssets to create tag files for $ParentSrc..."
        & $PSSCriptRoot\DDTagAssets.ps1 $packlocation $assetfolders
        <# Info #> "    Retaking control from DDTagAssets."
    } # if ($CreateTagFile)

    <# Info #> ""
    <# Info #> "    Finished copying assets."
    <# Info #> $EndNow = Get-Date
    <# Info #> $RunTime = $EndNow - $StartNow
    <# Info #> "### Ending $ScriptName V.$Version at $EndNow with a run time of " + ("{0:hh\:mm\:ss}" -f $RunTime)
    <# Info #> ""
# } Main