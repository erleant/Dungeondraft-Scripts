<#
.SYNOPSIS
Unpack .dungeondraft_pack files, and convert any .png objects within to .webp

.DESCRIPTION
This script uses "dungeondraft-unpack.exe" to unpack .dungeondraft_pack files.
Then it uses the "DDConvertAssets.ps1" PowerShell script to create a duplicate folder structure while converting image files to .webp files.
Then it uses "dungeondraft-pack.exe" to repack the Converted Folders into .dungeondraft_pack files.
The "DDConvertAssets.ps1" script also updates the data files to reflect the changes in filenames.

.PARAMETER Source
This specifies the name of the asset pack or the name of the folder that contains the asset packs that you wish to convert.

.PARAMETER Destination
This specifies the parent folder where you wish to create the converted asset folders.
If this parameter is omitted, the default destination will be the same name as the source folder, appended with " - webp".
For example, if the source folder is "My_AssetPacks", the default destination folder will be "My_AssetPacks - webp".

Three folders will be created in the destination.
    "Unpacked Assets" will contain the original, unpacked assets.
    "Converted Folders" will contain a copy of everything in "Unpacked Assets" with all images converted to .webp and all data files updated to reflect this change.
    "Converted Packs" will contain .dungeondraft_pack files created from the folders in "Converted Folders".

.PARAMETER Include
This specifies a comma-separated list of the asset packs you wish to convert. Do not include the full path. Just include the file name.
If you omit this parameter, or if you include it with a value of *, the script will include all asset packs within the folder you specified as the source.

.PARAMETER Exclude
If you choose to include all asset packs in the source folder, this specifies a comma-separated list of any asset packs you might wish to exclude from conversion.
As with the Include parameter, Do not include the full path. Just include the file name.

.EXAMPLE
DDConvertPacks -Source "C:\Custom Assets"

Convert all the all the asset packs in "C:\Custom Assets" with the resulting files and folders to be stored in "C:\Custom Assets - webp"

.EXAMPLE
DDConvertPacks -Source "C:\Custom Assets" -Include *

Convert all the the asset packs in "C:\Custom Assets" with the resulting files and folders to be stored in "C:\Custom Assets - webp"

.EXAMPLE
DDConvertPacks -Source "C:\Custom Assets" -Include "AssetPack1.dungeondraft_pack"

Convert AssetPack1.dungeondraft_pack in "C:\Custom Assets" with the resulting files and folders to be stored in "C:\Custom Assets - webp"

.EXAMPLE
DDConvertPacks -Source "C:\Custom Assets" -Include "AssetPack1.dungeondraft_pack,AssetPack2.dungeondraft_pack"

Convert AssetPack1.dungeondraft_pack and AssetPack2.dungeondraft_pack in "C:\Custom Assets" with the resulting files and folders to be stored in "C:\Custom Assets - webp"

.EXAMPLE
DDConvertPacks -Source "C:\Custom Assets" -Exclude "AssetPack3.dungeondraft_pack,AssetPack4.dungeondraft_pack"

Convert all the the asset packs in "C:\Custom Assets", except for AssetPack3.dungeondraft.pack and AssetPack4.dungeondraft.pack, with the resulting files and folders to be stored in "C:\Custom Assets - webp"

.EXAMPLE
DDConvertPacks -Source "C:\Custom Assets" -Destination "C:\webp Assets"

Convert all the all the asset packs in "C:\Custom Assets" with the resulting files and folders to be stored in "C:\webp Assets"

.EXAMPLE
DDConvertPacks -Source "C:\Custom Assets\My Mods.dungeondraft_pack"

Convert only "C:\Custom Assets\My Mods.dungeondraft_pack" with the resulting files and folders to be stored in "C:\Custom Assets - webp"

.EXAMPLE
DDConvertPacks -Source "C:\Custom Assets\My Mods.dungeondraft_pack" -Destination "C:\webp Assets"

Convert only "C:\Custom Assets\My Mods.dungeondraft_pack" with the resulting files and folders to be stored in "C:\webp Assets"

.NOTES

You must have the "DDConvertAssets.ps1" PowerShell script in the same folder as this script.
This can be found at https://gitlab.com/EightBitz/dungeondraft-scripts

You must have "dungeondraft-unpack.exe" and "dungeondraft-pack.exe" in the same folder as this script.
These can be found at https://github.com/Ryex/Dungeondraft-GoPackager/releases/tag/v1.0.0

You must have "dungeondraft-pack.exe" and "dungeondraft-pack.exe" in the same folder as this script.
These can be found at https://github.com/Ryex/Dungeondraft-GoPackager/releases/tag/v1.0.0 
#>

# Command line parameters
param (
    [string]$Source = "",
    [string]$Destination = "",
    [string]$Include = "",
    [string]$Exclude = "",
    [string]$CleanUp= '$true'
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

function Test-ValidFileName {
    param([string]$FileName)

    $IndexOfInvalidChar = $FileName.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars())

    # IndexOfAny() returns the value -1 to indicate no such character was found
    if($IndexOfInvalidChar -eq -1) {
        return $true
    } else {
        return $false
    }
} # function Test-ValidFileName

Function ValidateInput ($Src,$Dst,$IncList,$ExcList,$Cln) {

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

    if (-not (Test-ValidPathName $Dst)) {
        [array]$ReturnValue = $false
        [array]$ReturnValue += "    Invalid path name for Destination: $Dst"
        return $ReturnValue
    } # if (-not (Test-ValidPathName $Dst))

    if ($IncList.count -ge 1) {
        foreach ($Pck in $IncList.Split(",")) {
            if (-not (Test-ValidFileName $Pck)) {
                [array]$ReturnValue = $false
                [array]$ReturnValue += "    Invalid file name in inclusion list: $Pck"
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))

            if (-not (Test-Path $Src\$Pck)) {
                [array]$ReturnValue = $false
                [array]$ReturnValue += "    Included pack file not found: $Pck"
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))
        } # foreach ($Pck in $IncList)
    } # if ($IncList.count -ge 1)

    if ($ExcList.count -ge 1) {
        foreach ($Pck in $ExcList.Split(",")) {
            if (-not (Test-ValidFileName $Pck)) {
                [array]$ReturnValue = $false
                [array]$ReturnValue += "    Invalid file name in exclusion list: $Pck"
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))

            if (-not (Test-Path $Src\$Pck)) {
                [array]$ReturnValue = $false
                [array]$ReturnValue += "    Excluded pack file not found: $Pck"
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))
        } # foreach ($Pck in $ExcList)
    } # if ($ExcList.count -ge 1)

    $Cln = $Cln.ToLower()
    Switch ($Cln) {
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
            [array]$ReturnValue += '    CleanUp must be True or False'
            return $ReturnValue
        } # default
    } # Switch ($Cln)

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
    <# Info #> "    $PSScriptRoot\DDConvertPacks.ps1 [[-Source] <String>] [[-Destination] <String>] [[-Include] <String>] [[-Exclude] <String>] [[-CleanUp] <String>]"
    <# Info #> ""
    <# Info #> "REMARKS"
    <# Info #> "    To see the examples, type: ""get-help $PSScriptRoot\DDConvertPacks.ps1 -examples""."
    <# Info #> "    For more information, type: ""get-help $PSScriptRoot\DDConvertPacks.ps1 -detailed""."
    <# Info #> "    For technical information, type: ""get-help $PSScriptRoot\DDConvertPacks.ps1 -full""."
    <# Info #> ""
    <# Info #> "REQUIRED DEPENDENCIES"
    <# Info #> "    $PSScriptRoot\DDConvertAssets.ps1"
    <# Info #> "    $PSScriptRoot\dungeondraft-unpack.exe"
    <# Info #> "    $PSScriptRoot\dungeondraft-pack.exe"
    <# Info #> ""
    Exit
} # Function InvalidExit

# Main {
    $StartNow = Get-Date
    $ScriptName = "DDConvertPacks"
    $Version = 3

    <# Info #> ""
    <# Info #> "### Starting $ScriptName V.$Version at $StartNow"
    <# Info #> ""

    if ($Destination -eq "") {$Destination = "$Source - webp"}
    $Validate = @()
    $Validate = ValidateInput $Source $Destination $Include $Exclude $CleanUp
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

    [Array]$Dependencies = ($PSScriptRoot + "\DDConvertAssets.ps1")
    [Array]$Dependencies += ($PSScriptRoot + "\dungeondraft-unpack.exe")
    [Array]$Dependencies += ($PSScriptRoot + "\dungeondraft-pack.exe")
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

    # If an asterisk was used for $AssetFolders, get the full folder list for $AssetParent.
    #     Otherwise, split the comma-separated folder list into an array.
    #     Store the appropriate result in the $Include array
    $SourceItem = Get-Item $Source
    if (($SourceItem).PSIsContainer) {
        if (($Include -eq "*") -or ($Include -eq "")) {
            if ($Exclude -ne "") {
                $ExcludeArray = $Exclude.Split(",")
                $SelectedPacks = (Get-ChildItem $Source -Recurse -File -Filter "*.dungeondraft_pack") | Where-Object {$_.Name -NotIn $ExcludeArray}
                $Manifest = "all packs except $Exclude"
            } else {
                $SelectedPacks = Get-ChildItem $Source -Recurse -File -Filter "*.dungeondraft_pack"
                $Manifest = "all packs"
            } # if ($Exclude -ne "")
        } else {
            $SplitPacks = $Include.Split(",")
            foreach ($Pack in $SplitPacks) {[Array]$SelectedPacks += Get-Item $Source\$Pack}
            $Manifest = $Include
        } # if ($Include -eq "*")
    } else {
        if ($Destination -eq "") {$Destination = $SourceItem.Directory.FullName + " - webp"}
        $SelectedPacks = $SourceItem
        $Manifest = $SourceItem.Name
    } # if (($SourceItem).PSIsContainer)

    if (($Include -eq "*") -or ($Include -eq "")) {$PackSelection = "<all folders>"}
    <# Info #> ""
    <# Info #> "    Source: $Source"
    <# Info #> "    Destination: $Destination"
    <# Info #> "    Packs to include: $Manifest"
    <# Info #> "    Packs to exclude: $Exclude"
    <# Info #> ""

    $UnpackDestination = "$Destination\Unpacked Assets"
    $ConvertDestination = "$Destination\Converted Folders" 
    $RepackDestination = "$Destination\Converted Packs"

    <# Info #> "    Processing each pack file..."
    <# Info #> ""
    foreach ($Pack in $SelectedPacks) {
        $PackBaseName = $Pack.BaseName
        $PackName = $Pack.Name
        $UnpackSource = $Pack.FullName

        # Only process this particular pack if there's no folder for it yet.
        if (Test-Path $PackName) {
            <# Info #> "        Skipping $PackName" + ": This pack file has already been unpacked."
        } else {
            <# Info #> "        Unpacking ""$PackName"" with dungeondraft-unpack.exe..."
            & $PSScriptRoot\dungeondraft-unpack.exe $UnpackSource $UnpackDestination | Out-Null

            # If the destination folder does not yet exist, run the conversion.
            if (Test-Path "$ConvertDestination\$PackBasename") {
                <# Info #> "        Skipping conversion of ""$PackName"": The destination folder already exists."
            } else {
                <# Info #> "        Converting objects in $UnpackDestination\$PackBaseName to .webp with DDConvertAssets.ps1..."
                & $PSScriptRoot\DDConvertAssets.ps1 "$UnpackDestination\$PackBaseName" "$ConvertDestination\$PackBaseName"
            } # if (Test-Path $GUIDDestination)

            <# Info #> "        Packing $ConvertDestination\$PackBaseName with dungeondraft-pack.exe..."
            & $PSScriptRoot\dungeondraft-pack.exe "$ConvertDestination\$PackBaseName" $RepackDestination | Out-Null

        } # if (Test-Path $PackName)
        <# Info #> "        Finished unpacking and converting $PackName."
        <# Info #> ""
    } # foreach ($Pack in $Include)
    <# Info #> "    Finished processing pack files."
    <# Info #> ""

    [bool]$CleanUp = StringToBool $CleanUp
    if ($CleanUp) {
        <# Info #> "    Removing $UnpackDestination..."
        Remove-Item $UnpackDestination -Recurse
        <# Info #> "    Removing $ConvertDestination..."
        Remove-Item $ConvertDestination -Recurse
        <# Info #> ""
    } # if ($CleanUp)

    $EndNow = Get-Date
    $RunTime = $EndNow - $StartNow
    <# Info #> ""
    <# Info #> "### Ending $ScriptName V.$Version at $EndNow with a run time of " + ("{0:hh\:mm\:ss}" -f $RunTime)
    <# Info #> ""
# } Main