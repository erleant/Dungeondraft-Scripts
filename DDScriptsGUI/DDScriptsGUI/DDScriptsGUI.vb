Public Class DDScriptGUIForm

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        DDConvertAssetsGroupBox.Hide()
        DDConvertPacksGroupBox.Hide()
        DDCopyAssetsGroupBox.Hide()
        DDTagAssetsGroupBox.Hide()

        Me.Size = New Size(798, 245)
        TitlePanel.BringToFront()
        TitlePanel.Show()
    End Sub

    '###### Menu Items ######
    Private Sub DDConvertAssetssMenuItem_Click(sender As Object, e As EventArgs) Handles DDConvertAssetsMenuItem.Click
        TitlePanel.Hide()
        'DDConvertAssetsGroupBox.Hide()
        DDConvertPacksGroupBox.Hide()
        DDCopyAssetsGroupBox.Hide()
        DDTagAssetsGroupBox.Hide()

        Me.Size = New Size(798, 201)
        DDConvertAssetsGroupBox.BringToFront()
        DDConvertAssetsGroupBox.Show()
    End Sub

    Private Sub DDConvertPacksMenuItem_Click(sender As Object, e As EventArgs) Handles DDConvertPacksMenuItem.Click
        TitlePanel.Hide()
        DDConvertAssetsGroupBox.Hide()
        'DDConvertPacksGroupBox.Hide()
        DDCopyAssetsGroupBox.Hide()
        DDTagAssetsGroupBox.Hide()

        Me.Size = New Size(798, 649)
        DDConvertPacksGroupBox.BringToFront()
        DDConvertPacksGroupBox.Show()
    End Sub

    Private Sub DDCopyAssetssMenuItem_Click(sender As Object, e As EventArgs) Handles DDCopyAssetsMenuItem.Click
        TitlePanel.Hide()
        DDConvertAssetsGroupBox.Hide()
        DDConvertPacksGroupBox.Hide()
        'DDCopyAssetsGroupBox.Hide()
        DDTagAssetsGroupBox.Hide()

        Me.Size = New Size(798, 201)
        DDCopyAssetsGroupBox.BringToFront()
        DDCopyAssetsGroupBox.Show()
    End Sub

    Private Sub DDTagAssetsMenuItem_Click(sender As Object, e As EventArgs) Handles DDTagAssetsMenuItem.Click
        TitlePanel.Hide()
        DDConvertAssetsGroupBox.Hide()
        DDConvertPacksGroupBox.Hide()
        DDCopyAssetsGroupBox.Hide()
        'DDTagAssetsGroupBox.Hide()

        Me.Size = New Size(798, 649)
        DDTagAssetsGroupBox.BringToFront()
        DDTagAssetsGroupBox.Show()
    End Sub

    '###### Convert Assets Group Box ######
    Private Sub ConvertAssetsSourceTextBox_LostFocus(sender As Object, e As EventArgs) Handles ConvertAssetsSourceTextBox.LostFocus
        Dim UserFolder As String = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
        Dim SourceFolderName As String
        Dim IsFolderNameValid As Boolean
        Dim DoesFolderExist As Boolean
        Dim SourceFolder As System.IO.DirectoryInfo
        Dim DestinationFolderName As String

        SourceFolderName = ConvertAssetsSourceTextBox.Text
        IsFolderNameValid = IsValidPathName(SourceFolderName)
        DoesFolderExist = System.IO.Directory.Exists(SourceFolderName)
        If IsFolderNameValid And DoesFolderExist Then
            SourceFolder = New System.IO.DirectoryInfo(SourceFolderName)
            DestinationFolderName = UserFolder & "\Dungeondraft\Converted Assets\" & SourceFolder.Name
            ConvertAssetsDestinationTextBox.Text = DestinationFolderName
        End If
    End Sub

    Private Sub ConvertAssetsSourceBrowseButton_Click(sender As Object, e As EventArgs) Handles ConvertAssetsSourceBrowseButton.Click
        ConvertAssetsSourceBrowserDialog.ShowDialog()
        ConvertAssetsSourceTextBox.Text = ConvertAssetsSourceBrowserDialog.SelectedPath

        Dim UserFolder As String = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
        Dim SourceFolderName As String
        Dim IsFolderNameValid As Boolean
        Dim DoesFolderExist As Boolean
        Dim SourceFolder As System.IO.DirectoryInfo
        Dim DestinationFolderName As String

        SourceFolderName = ConvertAssetsSourceTextBox.Text
        IsFolderNameValid = IsValidPathName(SourceFolderName)
        DoesFolderExist = System.IO.Directory.Exists(SourceFolderName)
        If IsFolderNameValid And DoesFolderExist Then
            SourceFolder = New System.IO.DirectoryInfo(SourceFolderName)
            DestinationFolderName = UserFolder & "\Dungeondraft\Converted Assets\" & SourceFolder.Name
            ConvertAssetsDestinationTextBox.Text = DestinationFolderName
        End If
    End Sub

    Private Sub ConvertAssetsDestinationBrowseButton_Click(sender As Object, e As EventArgs) Handles ConvertAssetsDestinationBrowseButton.Click
        ConvertAssetsDestinationBrowserDialog.ShowDialog()
        ConvertAssetsDestinationTextBox.Text = ConvertAssetsDestinationBrowserDialog.SelectedPath
    End Sub

    Private Sub ConvertAssetsStartButton_Click(sender As Object, e As EventArgs) Handles ConvertAssetsStartButton.Click
        Dim PowerShellPath As String = Environment.SystemDirectory & "\WindowsPowerShell\v1.0\powershell.exe"
        Dim PowerShellArg As String
        Dim ScriptName As String = "'.\DDConvertAssets.ps1'"
        Dim SourceFolderName As String = ConvertAssetsSourceTextBox.Text
        Dim DestinationFolderName As String = ConvertAssetsDestinationTextBox.Text
        Dim IsSourceFolderNameValid As String
        Dim DoesSourceFolderExist As Boolean
        Dim IsDestinationFolderNameValid As String
        Dim ScriptParameters As String
        Dim RunScript As New System.Diagnostics.Process
        Dim LogFolderName As String = "logs"
        Dim LogFileName As String = LogFolderName & "\DDConvertAssets.log"

        IsSourceFolderNameValid = IsValidPathName(SourceFolderName)
        DoesSourceFolderExist = System.IO.Directory.Exists(SourceFolderName)

        IsDestinationFolderNameValid = IsValidPathName(DestinationFolderName)

        If SourceFolderName <> "" And IsSourceFolderNameValid And DoesSourceFolderExist Then
            If DestinationFolderName <> "" And IsDestinationFolderNameValid Then
                ScriptParameters = "-Source '" & SourceFolderName & "'"
                ScriptParameters &= " -Destination '" & DestinationFolderName & "'"

                If ConvertAssetsLogCheckBox.Checked Then
                    If Not System.IO.Directory.Exists(LogFolderName) Then
                        My.Computer.FileSystem.CreateDirectory(LogFolderName)
                    End If
                    ScriptParameters &= " > '" & LogFileName & "'"
                End If

                PowerShellArg = "-executionpolicy bypass -command ""& " & ScriptName & " " & ScriptParameters & """"

                RunScript = Process.Start(PowerShellPath, PowerShellArg)
            Else
                MsgBox("Destination folder name is invalid.")
            End If
        Else
            MsgBox("Source folder name is either invalid or does not exist.")
        End If
    End Sub

    '###### Convert Packs Group Box ######
    Private Sub ConvertPacksSourceTextBox_LostFocus(sender As Object, e As EventArgs) Handles ConvertPacksSourceTextBox.LostFocus
        ConvertPacksCheckedListBox.Items.Clear()

        Dim UserFolder As String = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
        Dim SourceFolderName As String
        Dim IsFolderNameValid As Boolean
        Dim DoesFolderExist As Boolean
        Dim SourceFolder As System.IO.DirectoryInfo
        Dim DestinationFolderName As String

        SourceFolderName = ConvertPacksSourceTextBox.Text
        IsFolderNameValid = IsValidPathName(SourceFolderName)
        DoesFolderExist = System.IO.Directory.Exists(SourceFolderName)
        If IsFolderNameValid And DoesFolderExist Then
            SourceFolder = New System.IO.DirectoryInfo(SourceFolderName)
            DestinationFolderName = UserFolder & "\Dungeondraft"
            ConvertPacksDestinationTextBox.Text = DestinationFolderName
            For Each PackFile As String In My.Computer.FileSystem.GetFiles(SourceFolderName)
                Dim PackName As New System.IO.DirectoryInfo(PackFile)
                If PackName.Extension = ".dungeondraft_pack" Then
                    ConvertPacksCheckedListBox.Items.Add(PackName.Name)
                    ConvertPacksCheckedListBox.SetItemChecked(ConvertPacksCheckedListBox.Items.Count - 1, True)
                End If
            Next
        End If
    End Sub

    Private Sub ConvertPacksSourceBrowseButton_Click(sender As Object, e As EventArgs) Handles ConvertPacksSourceBrowseButton.Click
        ConvertPacksCheckedListBox.Items.Clear()
        ConvertPacksSourceBrowserDialog.ShowDialog()
        ConvertPacksSourceTextBox.Text = ConvertPacksSourceBrowserDialog.SelectedPath

        Dim UserFolder As String = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
        Dim SourceFolderName As String
        Dim IsFolderNameValid As Boolean
        Dim DoesFolderExist As Boolean
        Dim SourceFolder As System.IO.DirectoryInfo
        Dim DestinationFolderName As String

        SourceFolderName = ConvertPacksSourceTextBox.Text
        IsFolderNameValid = IsValidPathName(SourceFolderName)
        DoesFolderExist = System.IO.Directory.Exists(SourceFolderName)
        If IsFolderNameValid And DoesFolderExist Then
            SourceFolder = New System.IO.DirectoryInfo(SourceFolderName)
            DestinationFolderName = UserFolder & "\Dungeondraft\Converted Packs\" & SourceFolder.Name
            ConvertPacksDestinationTextBox.Text = DestinationFolderName
            For Each PackFile As String In My.Computer.FileSystem.GetFiles(SourceFolderName)
                Dim PackName As New System.IO.DirectoryInfo(PackFile)
                If PackName.Extension = ".dungeondraft_pack" Then
                    ConvertPacksCheckedListBox.Items.Add(PackName.Name)
                    ConvertPacksCheckedListBox.SetItemChecked(ConvertPacksCheckedListBox.Items.Count - 1, True)
                End If
            Next
        End If
    End Sub

    Private Sub ConvertPacksDestinationBrowseButton_Click(sender As Object, e As EventArgs) Handles ConvertPacksDestinationBrowseButton.Click
        ConvertPacksDestinationBrowserDialog.ShowDialog()
        ConvertPacksDestinationTextBox.Text = ConvertPacksDestinationBrowserDialog.SelectedPath
    End Sub

    Private Sub ConvertPacksSelectAllButton_Click(sender As Object, e As EventArgs) Handles ConvertPacksSelectAllButton.Click
        Dim Count As Integer
        For Count = 0 To ConvertPacksCheckedListBox.Items.Count - 1
            ConvertPacksCheckedListBox.SetItemChecked(Count, True)
        Next
    End Sub

    Private Sub ConvertPacksSelectNoneButton_Click(sender As Object, e As EventArgs) Handles ConvertPacksSelectNoneButton.Click
        Dim Count As Integer
        For Count = 0 To ConvertPacksCheckedListBox.Items.Count - 1
            ConvertPacksCheckedListBox.SetItemChecked(Count, False)
        Next
    End Sub

    Private Sub ConvertPacksStartButton_Click(sender As Object, e As EventArgs) Handles ConvertPacksStartButton.Click
        Dim PowerShellPath As String = Environment.SystemDirectory & "\WindowsPowerShell\v1.0\powershell.exe"
        Dim PowerShellArg As String
        Dim ScriptName As String = "'.\DDConvertPacks.ps1'"
        Dim SourceFolderName As String = ConvertPacksSourceTextBox.Text
        Dim DestinationFolderName As String = ConvertPacksDestinationTextBox.Text
        Dim IsSourceFolderNameValid As String
        Dim DoesSourceFolderExist As Boolean
        Dim IsDestinationFolderNameValid As String
        Dim Include As String
        Dim Exclude As String
        Dim LoopCount As Integer
        Dim CleanUp As Boolean = ConvertPacksCleanUpCheckBox.Checked
        Dim ScriptParameters As String
        Dim RunScript As New System.Diagnostics.Process
        Dim LogFolderName As String = "logs"
        Dim LogFileName As String = LogFolderName & "\DDConvertPacks.log"

        Dim FullCount As Integer = ConvertPacksCheckedListBox.Items.Count
        Dim IncludeCount As Integer = ConvertPacksCheckedListBox.CheckedItems.Count
        Dim ExcludeCount As Integer = FullCount - IncludeCount

        Dim IncludeList As New List(Of String)
        Dim ExcludeList As New List(Of String)

        IsSourceFolderNameValid = IsValidPathName(SourceFolderName)
        DoesSourceFolderExist = System.IO.Directory.Exists(SourceFolderName)
        IsDestinationFolderNameValid = IsValidPathName(DestinationFolderName)

        If SourceFolderName <> "" And IsSourceFolderNameValid And DoesSourceFolderExist Then
            If DestinationFolderName <> "" And IsDestinationFolderNameValid Then
                ScriptParameters = "-Source '" & SourceFolderName & "'"
                ScriptParameters = ScriptParameters & " -Destination '" & DestinationFolderName & "'"

                For LoopCount = 0 To IncludeCount - 1
                    IncludeList.Add(ConvertPacksCheckedListBox.CheckedItems(LoopCount).ToString())
                Next

                For LoopCount = 0 To FullCount - 1
                    If Not ConvertPacksCheckedListBox.CheckedItems.Contains(ConvertPacksCheckedListBox.Items(LoopCount)) Then
                        ExcludeList.Add(ConvertPacksCheckedListBox.Items(LoopCount).ToString())
                    End If
                Next

                Include = ""
                Exclude = ""
                If ExcludeCount <> FullCount Then
                    If IncludeCount = FullCount Then
                        ScriptParameters &= " -Include *"
                    ElseIf IncludeCount <= ExcludeCount Then
                        For LoopCount = 0 To IncludeCount - 1
                            Include &= IncludeList(LoopCount)
                            If LoopCount <> IncludeCount - 1 Then
                                Include &= ","
                            End If
                        Next
                        ScriptParameters &= " -Include '" & Include & "'"
                    ElseIf ExcludeCount < IncludeCount Then
                        For LoopCount = 0 To ExcludeCount - 1
                            Exclude &= ExcludeList(LoopCount)
                            If LoopCount <> ExcludeCount - 1 Then
                                Exclude &= ","
                            End If
                        Next
                        ScriptParameters &= " -Exclude '" & Exclude & "'"
                    End If

                    ScriptParameters = ScriptParameters & " -CleanUp " & CleanUp

                    If ConvertPacksLogCheckBox.Checked Then
                        If Not System.IO.Directory.Exists(LogFolderName) Then
                            My.Computer.FileSystem.CreateDirectory(LogFolderName)
                        End If
                        ScriptParameters &= " > '" & LogFileName & "'"
                    End If

                    PowerShellArg = "-executionpolicy bypass -command ""& " & ScriptName & " " & ScriptParameters & """"

                    RunScript = Process.Start(PowerShellPath, PowerShellArg)
                Else
                    MsgBox("Nothing was selected.")
                End If

            Else
                MsgBox("Destination folder name is invalid.")
            End If
        Else
                MsgBox("Source folder name is either invalid or does not exist.")
        End If
    End Sub

    '###### Copy Assets Group Box ######
    Private Sub CopyAssetsSourceTextBox_LostFocus(sender As Object, e As EventArgs) Handles CopyAssetsSourceTextBox.LostFocus
        Dim UserFolder As String = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
        Dim SourceFolderName As String
        Dim IsFolderNameValid As Boolean
        Dim DoesFolderExist As Boolean
        Dim SourceFolder As System.IO.DirectoryInfo
        Dim DestinationFolderName As String

        SourceFolderName = CopyAssetsSourceTextBox.Text
        IsFolderNameValid = IsValidPathName(SourceFolderName)
        DoesFolderExist = System.IO.Directory.Exists(SourceFolderName)
        If IsFolderNameValid And DoesFolderExist Then
            SourceFolder = New System.IO.DirectoryInfo(SourceFolderName)
            DestinationFolderName = UserFolder & "\Dungeondraft\Copied Assets\" & SourceFolder.Name
            CopyAssetsDestinationTextBox.Text = DestinationFolderName
        End If
    End Sub

    Private Sub CopyAssetsSourceBrowseButton_Click(sender As Object, e As EventArgs) Handles CopyAssetsSourceBrowseButton.Click
        CopyAssetsSourceBrowserDialog.ShowDialog()
        CopyAssetsSourceTextBox.Text = CopyAssetsSourceBrowserDialog.SelectedPath

        Dim UserFolder As String = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
        Dim SourceFolderName As String
        Dim IsFolderNameValid As Boolean
        Dim DoesFolderExist As Boolean
        Dim SourceFolder As System.IO.DirectoryInfo
        Dim DestinationFolderName As String

        SourceFolderName = CopyAssetsSourceTextBox.Text
        IsFolderNameValid = IsValidPathName(SourceFolderName)
        DoesFolderExist = System.IO.Directory.Exists(SourceFolderName)
        If IsFolderNameValid And DoesFolderExist Then
            SourceFolder = New System.IO.DirectoryInfo(SourceFolderName)
            DestinationFolderName = UserFolder & "\Dungeondraft\Copied Assets\" & SourceFolder.Name
            CopyAssetsDestinationTextBox.Text = DestinationFolderName
        End If
    End Sub

    Private Sub CopyAssetsDestinationBrowseButton_Click(sender As Object, e As EventArgs) Handles CopyAssetsDestinationBrowseButton.Click
        CopyAssetsDestinationBrowserDialog.ShowDialog()
        CopyAssetsDestinationTextBox.Text = CopyAssetsDestinationBrowserDialog.SelectedPath
    End Sub

    Private Sub CopyAssetsStartButton_Click(sender As Object, e As EventArgs) Handles CopyAssetsStartButton.Click
        Dim PowerShellPath As String = Environment.SystemDirectory & "\WindowsPowerShell\v1.0\powershell.exe"
        Dim PowerShellArg As String
        Dim ScriptName As String = "'.\DDCopyAssets.ps1'"
        Dim SourceFolderName As String = CopyAssetsSourceTextBox.Text
        Dim DestinationFolderName As String = CopyAssetsDestinationTextBox.Text
        Dim CreateTagFile As Boolean = CopyAssetsCreateTagsCheckBox.Checked
        Dim Portals As Boolean = CopyAssetsPortalsCheckBox.Checked
        Dim IsSourceFolderNameValid As String
        Dim DoesSourceFolderExist As Boolean
        Dim IsDestinationFolderNameValid As String
        Dim ScriptParameters As String
        Dim RunScript As New System.Diagnostics.Process
        Dim LogFolderName As String = "logs"
        Dim LogFileName As String = LogFolderName & "\DDCopyAssets.log"

        IsSourceFolderNameValid = IsValidPathName(SourceFolderName)
        DoesSourceFolderExist = System.IO.Directory.Exists(SourceFolderName)

        IsDestinationFolderNameValid = IsValidPathName(DestinationFolderName)

        If SourceFolderName <> "" And IsSourceFolderNameValid And DoesSourceFolderExist Then
            If DestinationFolderName <> "" And IsDestinationFolderNameValid Then
                ScriptParameters = "-Source '" & SourceFolderName & "'"
                ScriptParameters &= " -Destination '" & DestinationFolderName & "'"

                ScriptParameters &= " -CreateTagFile " & CreateTagFile

                ScriptParameters &= " -Portals " & Portals

                If DDCopyAssetsLogCheckBox.Checked Then
                    If Not System.IO.Directory.Exists(LogFolderName) Then
                        My.Computer.FileSystem.CreateDirectory(LogFolderName)
                    End If
                    ScriptParameters &= " > '" & LogFileName & "'"
                End If

                PowerShellArg = "-executionpolicy bypass -command ""& " & ScriptName & " " & ScriptParameters & """"

                RunScript = Process.Start(PowerShellPath, PowerShellArg)
            Else
                MsgBox("Destination folder name is invalid.")
            End If
        Else
            MsgBox("Source folder name is either invalid or does not exist.")
        End If
    End Sub

    '###### Tag Assets Group Box ######

    Private Sub TagAssetsTextBox_LostFocus(sender As Object, e As EventArgs) Handles TagAssetsSourceTextBox.LostFocus
        TagAssetsCheckedListBox.Items.Clear()
        Dim SourceFolderName As String
        Dim IsFolderNameValid As Boolean
        Dim DoesFolderExist As Boolean
        SourceFolderName = TagAssetsSourceTextBox.Text
        IsFolderNameValid = IsValidPathName(SourceFolderName)
        DoesFolderExist = System.IO.Directory.Exists(SourceFolderName)

        If IsFolderNameValid And DoesFolderExist Then
            For Each TagFolder As String In My.Computer.FileSystem.GetDirectories(SourceFolderName)
                Dim FolderName As New System.IO.DirectoryInfo(TagFolder)
                TagAssetsCheckedListBox.Items.Add(FolderName.Name)
                TagAssetsCheckedListBox.SetItemChecked(TagAssetsCheckedListBox.Items.Count - 1, True)
            Next
        End If
    End Sub

    Private Sub TagAssetsBrowseButton_Click(sender As Object, e As EventArgs) Handles TagAssetsBrowseButton.Click
        TagAssetsCheckedListBox.Items.Clear()
        TagAssetsSourceBrowserDialog.ShowDialog()
        TagAssetsSourceTextBox.Text = TagAssetsSourceBrowserDialog.SelectedPath

        Dim SourceFolderName As String
        Dim IsFolderNameValid As Boolean
        Dim DoesFolderExist As Boolean
        SourceFolderName = TagAssetsSourceTextBox.Text
        IsFolderNameValid = IsValidPathName(SourceFolderName)
        DoesFolderExist = System.IO.Directory.Exists(SourceFolderName)
        If IsFolderNameValid And DoesFolderExist Then
            For Each TagFolder As String In My.Computer.FileSystem.GetDirectories(SourceFolderName)
                Dim FolderName As New System.IO.DirectoryInfo(TagFolder)
                TagAssetsCheckedListBox.Items.Add(FolderName.Name)
                TagAssetsCheckedListBox.SetItemChecked(TagAssetsCheckedListBox.Items.Count - 1, True)
            Next
        End If
    End Sub

    Private Sub TagAssetsSelectAllButton_Click(sender As Object, e As EventArgs) Handles TagAssetsSelectAllButton.Click
        Dim Count As Integer
        For Count = 0 To TagAssetsCheckedListBox.Items.Count - 1
            TagAssetsCheckedListBox.SetItemChecked(Count, True)
        Next
    End Sub

    Private Sub TagAssetsSelectNoneButton_Click(sender As Object, e As EventArgs) Handles TagAssetsSelectNoneButton.Click
        Dim Count As Integer
        For Count = 0 To TagAssetsCheckedListBox.Items.Count - 1
            TagAssetsCheckedListBox.SetItemChecked(Count, False)
        Next
    End Sub

    Private Sub TagAssetsStartButton_Click(sender As Object, e As EventArgs) Handles TagAssetsStartButton.Click
        Dim PowerShellPath As String = Environment.SystemDirectory & "\WindowsPowerShell\v1.0\powershell.exe"
        Dim PowerShellArg As String
        Dim ScriptName As String = "'.\DDTagAssets.ps1'"
        Dim SourceFolderName As String = TagAssetsSourceTextBox.Text
        Dim IsSourceFolderNameValid As String
        Dim DoesSourceFolderExist As Boolean
        Dim DefaultTag As String = TagAssetsDefaultTagTextBox.Text
        Dim Include As String
        Dim Exclude As String
        Dim LoopCount As Integer
        Dim ScriptParameters As String
        Dim RunScript As New System.Diagnostics.Process
        Dim LogFolderName As String = "logs"
        Dim LogFileName As String = LogFolderName & "\DDTagAssets.log"

        Dim FullCount As Integer = TagAssetsCheckedListBox.Items.Count
        Dim IncludeCount As Integer = TagAssetsCheckedListBox.CheckedItems.Count
        Dim ExcludeCount As Integer = FullCount - IncludeCount

        Dim IncludeList As New List(Of String)
        Dim ExcludeList As New List(Of String)

        IsSourceFolderNameValid = IsValidPathName(SourceFolderName)
        DoesSourceFolderExist = System.IO.Directory.Exists(SourceFolderName)
        If SourceFolderName <> "" And IsSourceFolderNameValid And DoesSourceFolderExist Then
            ScriptParameters = "-Source '" & SourceFolderName & "'"

            For LoopCount = 0 To IncludeCount - 1
                IncludeList.Add(TagAssetsCheckedListBox.CheckedItems(LoopCount).ToString())
            Next

            For LoopCount = 0 To FullCount - 1
                If Not TagAssetsCheckedListBox.CheckedItems.Contains(TagAssetsCheckedListBox.Items(LoopCount)) Then
                    ExcludeList.Add(TagAssetsCheckedListBox.Items(LoopCount).ToString())
                End If
            Next

            Include = ""
            Exclude = ""
            If ExcludeCount <> FullCount Then
                If IncludeCount = FullCount Then
                    ScriptParameters &= " -Include *"
                ElseIf IncludeCount <= ExcludeCount Then
                    For LoopCount = 0 To IncludeCount - 1
                        Include &= IncludeList(LoopCount)
                        If LoopCount <> IncludeCount - 1 Then
                            Include &= ","
                        End If
                    Next
                    ScriptParameters &= " -Include '" & Include & "'"
                ElseIf ExcludeCount < IncludeCount Then
                    For LoopCount = 0 To ExcludeCount - 1
                        Exclude &= ExcludeList(LoopCount)
                        If LoopCount <> ExcludeCount - 1 Then
                            Exclude &= ","
                        End If
                    Next
                    ScriptParameters &= " -Exclude '" & Exclude & "'"
                End If

                If DefaultTag <> "" Then
                    ScriptParameters = ScriptParameters & " -DefaultTag '" & DefaultTag & "'"
                End If

                If TagAssetsLogCheckBox.Checked Then
                    If Not System.IO.Directory.Exists(LogFolderName) Then
                        My.Computer.FileSystem.CreateDirectory(LogFolderName)
                    End If
                    ScriptParameters &= " > '" & LogFileName & "'"
                End If

                PowerShellArg = "-executionpolicy bypass -command ""& " & ScriptName & " " & ScriptParameters & """"

                RunScript = Process.Start(PowerShellPath, PowerShellArg)
            Else
                MsgBox("Nothing was selected.")
            End If
        Else
                MsgBox("Source folder name is either invalid or does not exist.")
        End If

    End Sub

End Class
