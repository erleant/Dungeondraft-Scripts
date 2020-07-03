﻿<#
.SYNOPSIS
Create a properly formatted "default.dungeondraft_tags" for custom asset packs for Dungeondraft.

.DESCRIPTION
This script iterates through subfolders under the "textures\objects" folder of the specified asset folders and creates tags and tag sets based on the folders and subfolders.
Colorable objects should be placed in a "colorable" folder under their respective subfolders. For example, if you have "textures\objects\trees", and some of your trees are colorable, you would put the colorable ones in "textures\objects\trees\colorable".

The immediate folders under textures\objects will be used as the tags. If you have "textures\objects\Trees", "textures\objects\Trees\tropical" and "textures\objects\Trees\evergreen",
everything in that folder structure will be tagged as "Trees".

.PARAMETER Source
This specifies the parent folder for the asset folder(s) that will become your asset pack(s). If you're setting up three different folders to create three different asset packs, this specifies the parent folder that contains those three folders.

.PARAMETER Include
This specifies a comma-separated list of the individual folders that you wish to tag
Alternatively, you can omit this paramter or use an asterisk as its value (-Include *) to include all folders within the parent.

.PARAMETER Exclude
This specifies a comma-separated list of the individual folders that you wish to exclude from tagging.

.PARAMETER DefaultTag
This specifies the default tag for any objects that are not in a subfolder. If it is not included, root objects will not be tagged.

.EXAMPLE
DDTagAssets.ps1 -Source "My_Asset_Folders" -Include "MyDungeonPack,MyCityPack,MyNaturePack"

This example assumes you have a folder named "My_Asset_Folders", and that folder contains three other folders that you want to pack. One is named "MyDungeonPack", one is named "MyCityPack", and one is named "MyNaturePack".

.EXAMPLE
DDTagAssets.ps1 -Source "My_Asset_Folders" -Include "MyDungeonPack,MyCityPack,MyNaturePack" -DefaultTag "Miscellaneous"

This example assumes that you have objects that are not in subfolders, and that you want them tagged as "Miscellaneous".

.EXAMPLE
DDTagAssets.ps1 -Source "My_Asset_Folders" -Include * -DefaultTag "Miscellaneous"

Using an asterisk instead of a comma-separated folder list will create tag files for all folders within "My_Asset_Folders"

.EXAMPLE
DDTagAssets.ps1 -Source "My_Asset_Folders" -Include "*" "Miscellaneous" -Exclude "MyCityPack,MyNaturePack"

This will tag all folders under "My_Asset_Folders" except for "MyCityPack" and "MyNaturePack"

.NOTES
While you can have subfolders within subfolders, only the the immediate subfolders will be designated as tags.

If you have a subfolder for textures\objects\trees, everything in that folder will be tagged as "Trees", regardless of any other subfolders you have within.

The name of the tag set will the the same as the name of the asset folder.

This script assumes that:
1. You have a central location for the source files for your soon-to-be asset packs.
2. Colorable objects are stored within a "Colorable" folder within the folder it would otherwise be stored.

My_Asset_Folders
	MyDungeonPack\textures\objects
		Bones
			NonColorableBone1.png
			NonColorableBone2.png
			Colorable
				ColorableBone1.png
				ColorableBone2.png
		Debris
			NonColorableDebris1.png
			NonColorableDebris2.png
		Traps
			WoodSpiketrap.png
			MetalSpiketrap.png
			PitTrap.png
			Colorable
				SmokeTrap.png
	MyCityPack\textures\objects
		Rooftops
			Colorable
				RoofTop1.png
	MyNaturePack\textures\objects
		Bushes
			Bush1.png
			Bush2.png
		Flowers
			Colorable
				Flower1.png
				Flower2.png
		Trees
			Tree1.png
			Tree2.png
			Colorable
				Tree3.png
				Tree4.png

#>

# Command line parameters
param (
    [string]$Source = "",
    [string]$Include = "",
    [string]$Exclude = "",
    [string]$DefaultTag = ""
)

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

Function ValidateInput ($Src,$IncList,$ExcList) {

    if ($Src -eq "") {
        $ReturnValue = [System.Collections.ArrayList]@()
        [void]$ReturnValue.Add($false)
        [void]$ReturnValue.Add("    No value specified for Source.")
        return $ReturnValue
    } # if ($Src -eq "")

    if (-not (Test-ValidPathName $Src)) {
        $ReturnValue = [System.Collections.ArrayList]@()
        [void]$ReturnValue.Add($false)
        [void]$ReturnValue.Add("    Invalid path name for Source: $Src")
        return $ReturnValue
    } # if (-not (Test-ValidPathName $Src))

    if (-not (Test-Path $Src)) {
        $ReturnValue = [System.Collections.ArrayList]@()
        [void]$ReturnValue.Add($false)
        [void]$ReturnValue.Add("    Cannot find Source: $Src.")
        return $ReturnValue
    } # if (-not (Test-Path $Src))

    if ($IncList.count -ge 1) {
        foreach ($folder in $IncList.Split(",")) {
            if (-not (Test-ValidFileName $folder)) {
                $ReturnValue = [System.Collections.ArrayList]@()
                [void]$ReturnValue.Add($false)
                [void]$ReturnValue.Add("    Invalid folder name in inclusion list: $folder")
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))

            if (-not (Test-Path $Src\$folder)) {
                $ReturnValue = [System.Collections.ArrayList]@()
                [void]$ReturnValue.Add($false)
                [void]$ReturnValue.Add("    Included folder name not found: $folder")
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))
        } # foreach ($Pck in $IncList)
    } # if ($IncList.count -ge 1)

    if ($ExcList.count -ge 1) {
        foreach ($folder in $ExcList.Split(",")) {
            if (-not (Test-ValidFileName $folder)) {
                $ReturnValue = [System.Collections.ArrayList]@()
                [void]$ReturnValue.Add($false)
                [void]$ReturnValue.Add("    Invalid folder name in exclusion list: $folder")
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))

            if (-not (Test-Path $Src\$folder)) {
                $ReturnValue = [System.Collections.ArrayList]@()
                [void]$ReturnValue.Add($false)
                [void]$ReturnValue.Add("    Excluded folder file not found: $folder")
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))
        } # foreach ($Pck in $ExcList)
    } # if ($ExcList.count -ge 1)

} # Function ValidateInput

Function InvalidExit {
    Write-Output ""
    Write-Output "SYNTAX"
    Write-Output "    $PSScriptRoot\DDTagAssets.ps1 [[-Source] <String>] [[-Include] <String>] [[-Exclude] <String>] [[-DefaultTag] <String>]"
    Write-Output ""
    Write-Output "REMARKS"
    Write-Output "    To see the examples, type: ""get-help $PSScriptRoot\DDTagAssets.ps1 -examples""."
    Write-Output "    For more information, type: ""get-help $PSScriptRoot\DDTagAssets.ps1 -detailed""."
    Write-Output "    For technical information, type: ""get-help $PSScriptRoot\DDTagAssets.ps1 -full""."
    Write-Output ""
    Exit
} # Function InvalidExit

# Main {
    $StartNow = Get-Date
    $ScriptName = "DDTagAssets.ps1"
    $Version = 10


    if (($Include -eq "*") -or ($Include -eq "")) {$Manifest = "all folders"} else {$Manifest = "$Include"}
    Write-Output ""
    Write-Output "### Starting $ScriptName V.$Version at $StartNow"
    Write-Output ""

    if ($Include -eq "*") {$IncludeList = ""} else {$IncludeList = $Include.Split(",")}
    $ExcludeList = $Exclude
    $Validate = [System.Collections.ArrayList]@()
    $Validate = ValidateInput $Source $IncludeList $ExcludeList
    if ($Validate.count -ge 1) {
        $Valid = $Validate[0]
        $ExitMessage = $Validate[1]
        If (-not $Valid) {
            Write-Output $ExitMessage
            Write-Output "### Exiting script due to invalid input."
            InvalidExit
        } # If (-not $Valid)
    } else {
        Write-Output "    Input validated."
    } # if ($Validate.count -ge 1)

    if (Test-Path $Source\textures\objects) {
        $SourceObject = [System.IO.DirectoryInfo]$Source
        $Source = $SourceObject.Parent.FullName
        $Include = $SourceObject.Name
    }

    Write-Output ""
    Write-Output "    Source: $Source"
    Write-Output "    Folders to Include: $Manifest"
    Write-Output "    Folders to exclude: $Exclude"
    Write-Output "    Default tag for root objects: $DefaultTag"
    Write-Output ""

    # Set the output file encoding to UTF8, otherwise Dungeondraft will crash.
    $PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

    # If an asterisk was used for $Include, get the full folder list for $Source.
    #     Otherwise, split the comma-separated folder list into an array.
    #     Store the appropriate result in the $packlist array
    if (($Include -eq "*") -or ($Include -eq "")) {
        if ($Exclude -ne "") {
            $ExcludeArray = $Exclude.Split(",")
            $packlist = (Get-ChildItem $Source -Directory).Name | Where-Object {$_ -NotIn $ExcludeArray}
            $Manifest = "all folders except $Exclude"
        } else {
            $packlist = Get-ChildItem $Source -Directory
            $Manifest = "all folders"
        } # if ($Exclude -ne "")
    } else {
        $packlist = $Include.Split(",")
        $Manifest = $Include
    } # if (($Include -eq "*") -or ($Include -eq ""))

    Write-Output "    Starting tag file creation for $Manifest within $Source"
    Write-Output ""

    # Set some variables
    $tags = "tags"
    $colorable = "Colorable"
    $sets = "sets"

    # Iterate through each folder in the $PackList array.
    foreach ($Packfolder in $PackList) {
        Write-Output "    Starting $Packfolder..."

        # Initialize some variables
        $TagObject = [PSCustomObject]@{}
        $FolderObject = [PSCustomObject]@{}
        $ColorableTag = [PSCustomObject]@{}
        $SetList = [PSCustomObject]@{}


        # Set the folder and file locations.
        $Objects = "$Source\$Packfolder\textures\objects"
   
        # Only proceed if $Objects is a valid path
        if (Test-Path $Objects) {
            Write-Output "    Getting subfolders."
            [array]$Subfolders = (Get-ChildItem $Objects -Directory).Name

            Write-Output "    Getting root objects."
            [array]$RootObjects = (Get-ChildItem $Objects -File).FullName
            if (($DefaultTag -ne "") -and ($RootObjects.Count -ge 1)) {
                [array]$tagsetmembers = $DefaultTag
                [array]$tagsetmembers += $Subfolders

                [array]$RootObjects = (Get-ChildItem $Objects -File).FullName
                if (Test-Path $Objects\Colorable) {
                    [array]$RootObjects += (Get-ChildItem $Objects\Colorable -File).FullName
                } # if (Test-Path $Objects\Colorable)

                [array]$ParsedRoot = [array]$RootObjects -replace [Regex]::Escape("$Source\$Packfolder\") -replace [Regex]::Escape("\"),[Regex]::Escape("/")
                Add-Member -InputObject $FolderObject -NotePropertyName $DefaultTag -NotePropertyValue $ParsedRoot
            } else {
                [array]$tagsetmembers += $Subfolders
            } # if (($DefaultTag -ne "") -and ($RootObjects.Count -ge 1))

            Write-Output "    Getting all objects from all subfolders."
            [array]$AllObjects = (Get-ChildItem $Objects -File -Recurse).FullName
            [array]$AllColorableObjects = [array]$AllObjects | Where-Object {$_.ToLower().Contains("\colorable\")}
            [array]$ParsedObjects = [array]$AllObjects -replace [Regex]::Escape("$Source\$Packfolder\") -replace [Regex]::Escape("\"),[Regex]::Escape("/")
            if ($AllColorableObjects.count -ge 1) {
                [array]$ParsedColorableObjects = [array]$AllColorableObjects -replace [Regex]::Escape("$Source\$Packfolder\") -replace [Regex]::Escape("\"),[Regex]::Escape("/")
            }
            
            Write-Output "    Creating tags file content."
            foreach ($folder in $Subfolders | Where-Object {$_.ToLower() -ne "colorable"}) {
                Add-Member -InputObject $FolderObject -NotePropertyName $folder -NotePropertyValue @($ParsedObjects | Where-Object {$_.Contains("/$folder/")})
            }

            if ($ParsedColorableObjects.Count -ge 1) {
                Add-Member -InputObject $FolderObject -NotePropertyName $colorable -NotePropertyValue @($ParsedColorableObjects)
            }

            Add-Member -InputObject $TagObject -NotePropertyName $tags -NotePropertyValue $FolderObject
            Add-Member -InputObject $SetList -NotePropertyName $Packfolder -NotePropertyValue $tagsetmembers
            Add-Member -InputObject $TagObject -NotePropertyName $sets -NotePropertyValue $SetList

            $datafolder = "$Source\$Packfolder\data"
            $tagfile = "$datafolder\default.dungeondraft_tags"
           `Write-Output "    Writing tags file to $tagfile."
            if (-not (Test-Path $datafolder)) {New-Item $datafolder -ItemType "directory" | Out-Null}
            Set-Content $tagfile (ConvertTo-Json $TagObject) | Out-Null
        
        } # if (Test-Path $Objects)

        Write-Output "    Finished with $Packfolder."
        Write-Output ""
    } # foreach ($Packfolder in $PackList)

    Write-Output "    Ending tagfile creation for $Manifest within $Source"
    $EndNow = Get-Date
    $RunTime = $EndNow - $StartNow
    Write-Output ("### Ending $ScriptName V.$Version at $EndNow with a run time of " + ("{0:hh\:mm\:ss}" -f $RunTime))
    Write-Output ""
# } Main