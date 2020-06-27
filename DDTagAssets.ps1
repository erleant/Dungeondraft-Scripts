<#
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

    if ($IncList.count -ge 1) {
        foreach ($folder in $IncList.Split(",")) {
            if (-not (Test-ValidFileName $folder)) {
                [array]$ReturnValue = $false
                [array]$ReturnValue += "    Invalid folder name in inclusion list: $folder"
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))

            if (-not (Test-Path $Src\$folder)) {
                [array]$ReturnValue = $false
                [array]$ReturnValue += "    Included folder name not found: $folder"
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))
        } # foreach ($Pck in $IncList)
    } # if ($IncList.count -ge 1)

    if ($ExcList.count -ge 1) {
        foreach ($folder in $ExcList.Split(",")) {
            if (-not (Test-ValidFileName $folder)) {
                [array]$ReturnValue = $false
                [array]$ReturnValue += "    Invalid folder name in exclusion list: $folder"
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))

            if (-not (Test-Path $Src\$folder)) {
                [array]$ReturnValue = $false
                [array]$ReturnValue += "    Excluded folder file not found: $folder"
                return $ReturnValue
            } # if (-not (Test-ValidPathName $Src))
        } # foreach ($Pck in $ExcList)
    } # if ($ExcList.count -ge 1)

} # Function ValidateInput

Function InvalidExit {
    <# Info #> ""
    <# Info #> "SYNTAX"
    <# Info #> "    $PSScriptRoot\DDTagAssets.ps1 [[-Source] <String>] [[-Include] <String>] [[-Exclude] <String>] [[-DefaultTag] <String>]"
    <# Info #> ""
    <# Info #> "REMARKS"
    <# Info #> "    To see the examples, type: ""get-help $PSScriptRoot\DDTagAssets.ps1 -examples""."
    <# Info #> "    For more information, type: ""get-help $PSScriptRoot\DDTagAssets.ps1 -detailed""."
    <# Info #> "    For technical information, type: ""get-help $PSScriptRoot\DDTagAssets.ps1 -full""."
    <# Info #> ""
    Exit
} # Function InvalidExit

# Main {
    $StartNow = Get-Date
    $ScriptName = "DDTagAssets"
    $Version = 8

    if (($Include -eq "*") -or ($Include -eq "")) {$Manifest = "all folders"} else {$Manifest = "$Include"}
    <# Info #> ""
    <# Info #> "### Starting $ScriptName V.$Version at $StartNow"
    <# Info #> ""

    if ($Include -eq "*") {$IncludeList = ""} else {$IncludeList = $Include.Split(",")}
    $ExcludeList = $Exclude
    $Validate = @()
    $Validate = ValidateInput $Source $IncludeList $ExcludeList
    if ($Validate.count -ge 1) {
        $Valid = $Validate[0]
        $ExitMessage = $Validate[1]
        If (-not $Valid) {
            <# Info #> $ExitMessage
            <# Info #> "### Exiting script due to invalid input."
            InvalidExit
        } # If (-not $Valid)
    } else {
        <# Info #> "    Input validated."
    } # if ($Validate.count -ge 1)

    <# Info #> ""
    <# Info #> "    Source: $Source"
    <# Info #> "    Folders to Include: $Manifest"
    <# Info #> "    Folders to exclude: $Exclude"
    <# Info #> "    Default tag for root objects: $DefaultTag"
    <# Info #> ""

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

    <# Info #> "    Starting tag file creation for $Manifest within $Source"
    <# Info #> ""

    # Set some variables
    $tags = "tags"
    $colorable = "Colorable"
    $sets = "sets"

    # Iterate through each folder in the $PackList array.
    foreach ($Packfolder in $PackList) {
        <# Info #> "    Starting $Packfolder..."

        # Initialize some variables
        $TagObject = [PSCustomObject]@{}
        $FolderObject = [PSCustomObject]@{}
        $ColorableTag = [PSCustomObject]@{}
        $SetList = [PSCustomObject]@{}
        $AllColorableAssets = @()
        $SetArrayList = @()
        $ParsedList = @()
        $ParsedColor = @()
        $NewList = @()

        # Set the folder and file locations.
        $Objects = "$Source\$Packfolder\textures\objects"

        # Only proceed if $Objects is a valid path
        if (Test-Path $Objects) {

            # If a value has been specified for $DefaultTag,
            #     Process all the objects in the root folder, if there are any.
            $Objects = Get-Item "$Source\$Packfolder\textures\objects"
            if ($DefaultTag -ne "") {
                <# Info #> "        Processing " + $Objects.FullName + "..."
                $PartToRemove = $Objects.Parent.Parent.FullName + "\"
                $FileList = Get-ChildItem $Objects -File 
                if ($FileList.count -ge 1) {

                    # Get the list of file names, truncate everything before "textures\objects",
                    #     then replace all the backslashes with forward slashes.
                    [Array]$NewList += $FileList.FullName
                    [Array]$ParsedList += [Array]$NewList.Replace($PartToRemove, '').Replace('\', '/')

                    # Add the $DefaultTag value to the array list to be used for tag sets.
                    $SetArrayList += $DefaultTag
                } # if ($FileList.count -ge 1)


                # Process the "Colorable" folder in the root folder, if there is one. 
                $ColorableFolder = "$Objects\Colorable"
                # $ColorList = @()
                # $ParsedColor = @()
                # $ParsedList = @()
                If (Test-Path $ColorableFolder) {
                    $ColorableObjects = Get-ChildItem $ColorableFolder -File 
                    If ($ColorableObjects.count -ge 1) {
                        # Get the list of colorable file names, truncate everything before "textures\objects",
                        #     then replace all the backslashes with forward slashes.
                        $ColorList = $ColorableObjects.FullName
                        [Array]$ParsedColor += $ColorList.Replace($PartToRemove, '').Replace('\', '/')

                        # Add the colorable file names for the root folder to the list of other file names in the root folder.
                        [Array]$ParsedList += [Array]$ParsedList + [Array]$ParsedColor

                        # Keep a list of all colorable file names for this asset pack to add them all to the "Colorable" tag.
                        $AllColorableAssets += [Array]$ParsedColor
                    } # If ($ColorableObjects.count -gt 1)
                } # If (Test-Path $ColorableFolder)

                # If there were any objects in the root folder, add the file names to the $FolderObject as a value of the $DefaultTag property.
                if ([Array]$ParsedList.Count -ge 1) {Add-Member -InputObject $FolderObject -NotePropertyName $DefaultTag -NotePropertyValue $ParsedList}
            } else {
                <# Info #> "        Processing " + $Objects.FullName + "..."
                $PartToRemove = $Objects.Parent.Parent.FullName + "\"

                # Process the "Colorable" folder in the root folder, if there is one. 
                $ColorableFolder = "$Objects\Colorable"
                # $ColorList = @()
                # $ParsedColor = @()
                # $ParsedList = @()
                If (Test-Path $ColorableFolder) {
                    $ColorableObjects = Get-ChildItem $ColorableFolder -File 
                    If ($ColorableObjects.count -ge 1) {
                        # Get the list of colorable file names, truncate everything before "textures\objects",
                        #     then replace all the backslashes with forward slashes.
                        $ColorList = $ColorableObjects.FullName
                        [Array]$ParsedColor += $ColorList.Replace($PartToRemove, '').Replace('\', '/')

                        # Add the colorable file names for the root folder to the list of other file names in the root folder.
                        [Array]$ParsedList += [Array]$ParsedList + [Array]$ParsedColor

                        # Keep a list of all colorable file names for this asset pack to add them all to the "Colorable" tag.
                        $AllColorableAssets += [Array]$ParsedColor
                    } # If ($ColorableObjects.count -gt 1)
                } # If (Test-Path $ColorableFolder)

                # If there were any objects in the root folder, add the file names to the $FolderObject as a value of the $DefaultTag property.
            } # if ($DefaultTag -ne "")

            # Process each subfolder in the root folder (except for the "Colorable" folder, which we've already processed).
            $Parent = Get-ChildItem $Objects -Directory -Exclude "colorable"
            foreach ($folder in $Parent) {
                <# Info #> "        Processing " + $folder.fullname + "..."
                $PartToRemove = $folder.Parent.Parent.Parent.FullName + "\"

                $FileList = Get-ChildItem $folder.FullName -Recurse -File
                if ($FileList.count -ge 1) {
                    # Get the list of file names, truncate everything before "textures\objects",
                    #     then replace all the backslashes with forward slashes.
                    [Array]$NewList = $FileList.FullName
                    [Array]$ParsedList = [Array]$NewList.Replace($PartToRemove, '').Replace('\', '/')
                } # if ($FileList.count -ge 1)
                
                
                # Process the "Colorable" folders in the given subfolder.
                $ColorableFolders = Get-ChildItem -Recurse -Directory $folder.fullname -Filter "Colorable"
                if ($ColorableFolders.Count -ge 1) {
                    $ColorableObjects = Get-ChildItem $ColorableFolders.FullName -Recurse -File
                    $ColorList = @()
                    $ParsedColor = @()
                    If ($ColorableObjects.count -ge 1) {
                        # Get the list of colorable file names, truncate everything before "textures\objects",
                        #     then replace all the backslashes with forward slashes.
                        $ColorList = $ColorableObjects.FullName
                        [Array]$ParsedColor = $ColorList.Replace($PartToRemove, '').Replace('\', '/')
    
                        # Add the colorable file names for this subfolder to the list of other file names in this subfolder.
                        [Array]$ParsedList = [Array]$ParsedList + [Array]$ParsedColor

                        # Keep a list of all colorable file names for this asset pack to add them all to the "Colorable" tag.
                        $AllColorableAssets += [Array]$ParsedColor
                    }
                } # If ($ColorableObjects.count -ge 1)

                # Add the file names from this subfolder to the $FolderObject as a value of the subfolder's name (the subfolder's name being the property).
                $name = $folder.Name
                Add-Member -InputObject $FolderObject -NotePropertyName $name -NotePropertyValue $ParsedList
            
            } # foreach ($folder in $Parent)

  
            if ($FolderObject -ne $null) {$AssetCount = ($FolderObject | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name).count}
            if ($AllColorableAssets -ne $null) {$ColorableCount = $AllColorableAssets.count}
            if (($AssetCount -ge 1) -or ($ColorableCount -ge 1)) {
                <# Info #> "        Creating $tagfile for " + $folder.FullName + "..."

                # Add the $FolderObject (containing all subfolders processed in the above loop) to the $TagObject as a value of the $tags property
                Add-Member -InputObject $TagObject -NotePropertyName $tags -NotePropertyValue $FolderObject

                # If we collected any colorable assets, add $AllColorableAssets to the $FolderObject as a value of the $colorable property
                if ($AllColorableAssets.Count -ge 1) {Add-Member -InputObject $FolderObject -NotePropertyName $colorable -NotePropertyValue $AllColorableAssets}
        
                # If there were any subfolders under the root, add them to the array list to be used for tag sets,
                #     then add the $SetArrayList to the $SetList object as a value of the $Packfolder property.
                if ($Parent.Count -ge 1) {$SetArrayList += $Parent.Name}
                if ($SetArrayList.Count -ge 1) {Add-Member -InputObject $SetList -NotePropertyName $Packfolder -NotePropertyValue $SetArrayList}

                # Add the $SetList to the $TagObject as a value of the $sets property.
                Add-Member -InputObject $TagObject -NotePropertyName $sets -NotePropertyValue $SetList

                # Write the $TagObject to JSON, and write the JSON to the proper file in the proper location.
                $datafolder = "$Source\$Packfolder\data"
                if (-not (Test-Path $datafolder)) {New-Item $datafolder -ItemType "directory" | Out-Null}
                $tagfile = "$datafolder\default.dungeondraft_tags"
            
                Set-Content $tagfile (ConvertTo-Json $TagObject) | Out-Null
            } else {
                <# Info #> "        Skipping tag file creation for " + $Packfolder.Name + "..."
            } # if ($FolderObject.count -ge 1)
        
        } # if (Test-Path $Objects)

        <# Info #> "    Finished with $Packfolder."
        <# Info #> ""
    } # foreach ($Packfolder in $PackList)

    <# Info #> "    Ending tagfile creation for $Manifest within $Source"
    <# Info #> $EndNow = Get-Date
    <# Info #> $RunTime = $EndNow - $StartNow
    <# Info #> "### Ending $ScriptName V.$Version at $EndNow with a run time of " + ("{0:hh\:mm\:ss}" -f $RunTime)
    <# Info #> ""
# } Main