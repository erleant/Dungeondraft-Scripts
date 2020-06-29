<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class DDScriptGUIForm
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.MenuStrip1 = New System.Windows.Forms.MenuStrip()
        Me.SelectScriptToolStripMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.DDConvertAssetsMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.DDConvertPacksMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.DDCopyAssetsMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.DDTagAssetsMenuItem = New System.Windows.Forms.ToolStripMenuItem()
        Me.DDConvertPacksGroupBox = New System.Windows.Forms.GroupBox()
        Me.ConvertPacksStartButton = New System.Windows.Forms.Button()
        Me.ConvertPacksSelectNoneButton = New System.Windows.Forms.Button()
        Me.ConvertPacksSelectAllButton = New System.Windows.Forms.Button()
        Me.ConvertPacksCheckedListBox = New System.Windows.Forms.CheckedListBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.ConvertPacksCleanUpCheckBox = New System.Windows.Forms.CheckBox()
        Me.ConvertPacksDestinationTextBox = New System.Windows.Forms.TextBox()
        Me.ConvertPacksSourceTextBox = New System.Windows.Forms.TextBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.ConvertPacksDestinationBrowseButton = New System.Windows.Forms.Button()
        Me.ConvertPacksSourceBrowseButton = New System.Windows.Forms.Button()
        Me.DDTagAssetsGroupBox = New System.Windows.Forms.GroupBox()
        Me.TagAssetsStartButton = New System.Windows.Forms.Button()
        Me.TagAssetsSelectNoneButton = New System.Windows.Forms.Button()
        Me.TagAssetsSelectAllButton = New System.Windows.Forms.Button()
        Me.Label6 = New System.Windows.Forms.Label()
        Me.TagAssetsCheckedListBox = New System.Windows.Forms.CheckedListBox()
        Me.TagAssetsDefaultTagTextBox = New System.Windows.Forms.TextBox()
        Me.Label5 = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.TagAssetsSourceTextBox = New System.Windows.Forms.TextBox()
        Me.TagAssetsBrowseButton = New System.Windows.Forms.Button()
        Me.ConvertPacksSourceBrowserDialog = New System.Windows.Forms.FolderBrowserDialog()
        Me.ConvertPacksDestinationBrowserDialog = New System.Windows.Forms.FolderBrowserDialog()
        Me.TagAssetsSourceBrowserDialog = New System.Windows.Forms.FolderBrowserDialog()
        Me.DDCopyAssetsGroupBox = New System.Windows.Forms.GroupBox()
        Me.CopyAssetsPortalsCheckBox = New System.Windows.Forms.CheckBox()
        Me.CopyAssetsCreateTagsCheckBox = New System.Windows.Forms.CheckBox()
        Me.CopyAssetsSourceTextBox = New System.Windows.Forms.TextBox()
        Me.CopyAssetsDestinationTextBox = New System.Windows.Forms.TextBox()
        Me.Label8 = New System.Windows.Forms.Label()
        Me.Label7 = New System.Windows.Forms.Label()
        Me.CopyAssetsStartButton = New System.Windows.Forms.Button()
        Me.CopyAssetsDestinationBrowseButton = New System.Windows.Forms.Button()
        Me.CopyAssetsSourceBrowseButton = New System.Windows.Forms.Button()
        Me.CopyAssetsSourceBrowserDialog = New System.Windows.Forms.FolderBrowserDialog()
        Me.CopyAssetsDestinationBrowserDialog = New System.Windows.Forms.FolderBrowserDialog()
        Me.DDConvertAssetsGroupBox = New System.Windows.Forms.GroupBox()
        Me.Label10 = New System.Windows.Forms.Label()
        Me.ConvertAssetsSourceTextBox = New System.Windows.Forms.TextBox()
        Me.ConvertAssetsDestinationTextBox = New System.Windows.Forms.TextBox()
        Me.Label9 = New System.Windows.Forms.Label()
        Me.ConvertAssetsStartButton = New System.Windows.Forms.Button()
        Me.ConvertAssetsDestinationBrowseButton = New System.Windows.Forms.Button()
        Me.ConvertAssetsSourceBrowseButton = New System.Windows.Forms.Button()
        Me.ConvertAssetsSourceBrowserDialog = New System.Windows.Forms.FolderBrowserDialog()
        Me.ConvertAssetsDestinationBrowserDialog = New System.Windows.Forms.FolderBrowserDialog()
        Me.ConvertAssetsLogCheckBox = New System.Windows.Forms.CheckBox()
        Me.TagAssetsLogCheckBox = New System.Windows.Forms.CheckBox()
        Me.DDCopyAssetsLogCheckBox = New System.Windows.Forms.CheckBox()
        Me.ConvertPacksLogCheckBox = New System.Windows.Forms.CheckBox()
        Me.TitlePanel = New System.Windows.Forms.Panel()
        Me.Label11 = New System.Windows.Forms.Label()
        Me.Label12 = New System.Windows.Forms.Label()
        Me.Label13 = New System.Windows.Forms.Label()
        Me.MenuStrip1.SuspendLayout()
        Me.DDConvertPacksGroupBox.SuspendLayout()
        Me.DDTagAssetsGroupBox.SuspendLayout()
        Me.DDCopyAssetsGroupBox.SuspendLayout()
        Me.DDConvertAssetsGroupBox.SuspendLayout()
        Me.TitlePanel.SuspendLayout()
        Me.SuspendLayout()
        '
        'MenuStrip1
        '
        Me.MenuStrip1.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.SelectScriptToolStripMenuItem})
        Me.MenuStrip1.Location = New System.Drawing.Point(0, 0)
        Me.MenuStrip1.Name = "MenuStrip1"
        Me.MenuStrip1.Size = New System.Drawing.Size(782, 24)
        Me.MenuStrip1.TabIndex = 0
        Me.MenuStrip1.Text = "MenuStrip1"
        '
        'SelectScriptToolStripMenuItem
        '
        Me.SelectScriptToolStripMenuItem.DropDownItems.AddRange(New System.Windows.Forms.ToolStripItem() {Me.DDConvertAssetsMenuItem, Me.DDConvertPacksMenuItem, Me.DDCopyAssetsMenuItem, Me.DDTagAssetsMenuItem})
        Me.SelectScriptToolStripMenuItem.Name = "SelectScriptToolStripMenuItem"
        Me.SelectScriptToolStripMenuItem.Size = New System.Drawing.Size(83, 20)
        Me.SelectScriptToolStripMenuItem.Text = "Select Script"
        '
        'DDConvertAssetsMenuItem
        '
        Me.DDConvertAssetsMenuItem.Name = "DDConvertAssetsMenuItem"
        Me.DDConvertAssetsMenuItem.Size = New System.Drawing.Size(165, 22)
        Me.DDConvertAssetsMenuItem.Text = "DDConvertAssets"
        '
        'DDConvertPacksMenuItem
        '
        Me.DDConvertPacksMenuItem.Name = "DDConvertPacksMenuItem"
        Me.DDConvertPacksMenuItem.Size = New System.Drawing.Size(165, 22)
        Me.DDConvertPacksMenuItem.Text = "DDConvertPacks"
        '
        'DDCopyAssetsMenuItem
        '
        Me.DDCopyAssetsMenuItem.Name = "DDCopyAssetsMenuItem"
        Me.DDCopyAssetsMenuItem.Size = New System.Drawing.Size(165, 22)
        Me.DDCopyAssetsMenuItem.Text = "DDCopyAssets"
        '
        'DDTagAssetsMenuItem
        '
        Me.DDTagAssetsMenuItem.Name = "DDTagAssetsMenuItem"
        Me.DDTagAssetsMenuItem.Size = New System.Drawing.Size(165, 22)
        Me.DDTagAssetsMenuItem.Text = "DDTagAssets"
        '
        'DDConvertPacksGroupBox
        '
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksLogCheckBox)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksStartButton)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksSelectNoneButton)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksSelectAllButton)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksCheckedListBox)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.Label3)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksCleanUpCheckBox)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksDestinationTextBox)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksSourceTextBox)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.Label2)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.Label1)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksDestinationBrowseButton)
        Me.DDConvertPacksGroupBox.Controls.Add(Me.ConvertPacksSourceBrowseButton)
        Me.DDConvertPacksGroupBox.Location = New System.Drawing.Point(12, 33)
        Me.DDConvertPacksGroupBox.Name = "DDConvertPacksGroupBox"
        Me.DDConvertPacksGroupBox.Size = New System.Drawing.Size(758, 565)
        Me.DDConvertPacksGroupBox.TabIndex = 1
        Me.DDConvertPacksGroupBox.TabStop = False
        Me.DDConvertPacksGroupBox.Text = "DDConvertPacks"
        '
        'ConvertPacksStartButton
        '
        Me.ConvertPacksStartButton.Location = New System.Drawing.Point(658, 194)
        Me.ConvertPacksStartButton.Name = "ConvertPacksStartButton"
        Me.ConvertPacksStartButton.Size = New System.Drawing.Size(94, 26)
        Me.ConvertPacksStartButton.TabIndex = 9
        Me.ConvertPacksStartButton.Text = "Start"
        Me.ConvertPacksStartButton.UseVisualStyleBackColor = True
        '
        'ConvertPacksSelectNoneButton
        '
        Me.ConvertPacksSelectNoneButton.Location = New System.Drawing.Point(658, 162)
        Me.ConvertPacksSelectNoneButton.Name = "ConvertPacksSelectNoneButton"
        Me.ConvertPacksSelectNoneButton.Size = New System.Drawing.Size(94, 26)
        Me.ConvertPacksSelectNoneButton.TabIndex = 8
        Me.ConvertPacksSelectNoneButton.Text = "Select None"
        Me.ConvertPacksSelectNoneButton.UseVisualStyleBackColor = True
        '
        'ConvertPacksSelectAllButton
        '
        Me.ConvertPacksSelectAllButton.Location = New System.Drawing.Point(658, 130)
        Me.ConvertPacksSelectAllButton.Name = "ConvertPacksSelectAllButton"
        Me.ConvertPacksSelectAllButton.Size = New System.Drawing.Size(94, 26)
        Me.ConvertPacksSelectAllButton.TabIndex = 7
        Me.ConvertPacksSelectAllButton.Text = "Select All"
        Me.ConvertPacksSelectAllButton.UseVisualStyleBackColor = True
        '
        'ConvertPacksCheckedListBox
        '
        Me.ConvertPacksCheckedListBox.FormattingEnabled = True
        Me.ConvertPacksCheckedListBox.Location = New System.Drawing.Point(6, 130)
        Me.ConvertPacksCheckedListBox.Name = "ConvertPacksCheckedListBox"
        Me.ConvertPacksCheckedListBox.Size = New System.Drawing.Size(646, 429)
        Me.ConvertPacksCheckedListBox.TabIndex = 6
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(6, 111)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(134, 16)
        Me.Label3.TabIndex = 7
        Me.Label3.Text = "Pack Files to Convert"
        '
        'ConvertPacksCleanUpCheckBox
        '
        Me.ConvertPacksCleanUpCheckBox.AutoSize = True
        Me.ConvertPacksCleanUpCheckBox.Checked = True
        Me.ConvertPacksCleanUpCheckBox.CheckState = System.Windows.Forms.CheckState.Checked
        Me.ConvertPacksCleanUpCheckBox.Location = New System.Drawing.Point(129, 83)
        Me.ConvertPacksCleanUpCheckBox.Name = "ConvertPacksCleanUpCheckBox"
        Me.ConvertPacksCleanUpCheckBox.Size = New System.Drawing.Size(273, 20)
        Me.ConvertPacksCleanUpCheckBox.TabIndex = 4
        Me.ConvertPacksCleanUpCheckBox.Text = "Remove working folders after conversion."
        Me.ConvertPacksCleanUpCheckBox.UseVisualStyleBackColor = True
        '
        'ConvertPacksDestinationTextBox
        '
        Me.ConvertPacksDestinationTextBox.Location = New System.Drawing.Point(129, 55)
        Me.ConvertPacksDestinationTextBox.Name = "ConvertPacksDestinationTextBox"
        Me.ConvertPacksDestinationTextBox.Size = New System.Drawing.Size(523, 22)
        Me.ConvertPacksDestinationTextBox.TabIndex = 2
        '
        'ConvertPacksSourceTextBox
        '
        Me.ConvertPacksSourceTextBox.Location = New System.Drawing.Point(129, 23)
        Me.ConvertPacksSourceTextBox.Name = "ConvertPacksSourceTextBox"
        Me.ConvertPacksSourceTextBox.Size = New System.Drawing.Size(523, 22)
        Me.ConvertPacksSourceTextBox.TabIndex = 0
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(6, 58)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(117, 16)
        Me.Label2.TabIndex = 3
        Me.Label2.Text = "Destination Folder"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(30, 26)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(93, 16)
        Me.Label1.TabIndex = 2
        Me.Label1.Text = "Source Folder"
        '
        'ConvertPacksDestinationBrowseButton
        '
        Me.ConvertPacksDestinationBrowseButton.Location = New System.Drawing.Point(658, 53)
        Me.ConvertPacksDestinationBrowseButton.Name = "ConvertPacksDestinationBrowseButton"
        Me.ConvertPacksDestinationBrowseButton.Size = New System.Drawing.Size(94, 26)
        Me.ConvertPacksDestinationBrowseButton.TabIndex = 3
        Me.ConvertPacksDestinationBrowseButton.Text = "Browse"
        Me.ConvertPacksDestinationBrowseButton.UseVisualStyleBackColor = True
        '
        'ConvertPacksSourceBrowseButton
        '
        Me.ConvertPacksSourceBrowseButton.Location = New System.Drawing.Point(658, 21)
        Me.ConvertPacksSourceBrowseButton.Name = "ConvertPacksSourceBrowseButton"
        Me.ConvertPacksSourceBrowseButton.Size = New System.Drawing.Size(94, 26)
        Me.ConvertPacksSourceBrowseButton.TabIndex = 1
        Me.ConvertPacksSourceBrowseButton.Text = "Browse"
        Me.ConvertPacksSourceBrowseButton.UseVisualStyleBackColor = True
        '
        'DDTagAssetsGroupBox
        '
        Me.DDTagAssetsGroupBox.Controls.Add(Me.TagAssetsLogCheckBox)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.TagAssetsStartButton)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.TagAssetsSelectNoneButton)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.TagAssetsSelectAllButton)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.Label6)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.TagAssetsCheckedListBox)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.TagAssetsDefaultTagTextBox)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.Label5)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.Label4)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.TagAssetsSourceTextBox)
        Me.DDTagAssetsGroupBox.Controls.Add(Me.TagAssetsBrowseButton)
        Me.DDTagAssetsGroupBox.Location = New System.Drawing.Point(12, 33)
        Me.DDTagAssetsGroupBox.Name = "DDTagAssetsGroupBox"
        Me.DDTagAssetsGroupBox.Size = New System.Drawing.Size(758, 565)
        Me.DDTagAssetsGroupBox.TabIndex = 2
        Me.DDTagAssetsGroupBox.TabStop = False
        Me.DDTagAssetsGroupBox.Text = "DDTagAssets GUI"
        '
        'TagAssetsStartButton
        '
        Me.TagAssetsStartButton.Location = New System.Drawing.Point(658, 194)
        Me.TagAssetsStartButton.Name = "TagAssetsStartButton"
        Me.TagAssetsStartButton.Size = New System.Drawing.Size(94, 26)
        Me.TagAssetsStartButton.TabIndex = 7
        Me.TagAssetsStartButton.Text = "Start"
        Me.TagAssetsStartButton.UseVisualStyleBackColor = True
        '
        'TagAssetsSelectNoneButton
        '
        Me.TagAssetsSelectNoneButton.Location = New System.Drawing.Point(658, 162)
        Me.TagAssetsSelectNoneButton.Name = "TagAssetsSelectNoneButton"
        Me.TagAssetsSelectNoneButton.Size = New System.Drawing.Size(94, 26)
        Me.TagAssetsSelectNoneButton.TabIndex = 6
        Me.TagAssetsSelectNoneButton.Text = "Select None"
        Me.TagAssetsSelectNoneButton.UseVisualStyleBackColor = True
        '
        'TagAssetsSelectAllButton
        '
        Me.TagAssetsSelectAllButton.Location = New System.Drawing.Point(658, 130)
        Me.TagAssetsSelectAllButton.Name = "TagAssetsSelectAllButton"
        Me.TagAssetsSelectAllButton.Size = New System.Drawing.Size(94, 26)
        Me.TagAssetsSelectAllButton.TabIndex = 5
        Me.TagAssetsSelectAllButton.Text = "Select All"
        Me.TagAssetsSelectAllButton.UseVisualStyleBackColor = True
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(6, 111)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(96, 16)
        Me.Label6.TabIndex = 6
        Me.Label6.Text = "Folders to Tag"
        '
        'TagAssetsCheckedListBox
        '
        Me.TagAssetsCheckedListBox.FormattingEnabled = True
        Me.TagAssetsCheckedListBox.Location = New System.Drawing.Point(6, 130)
        Me.TagAssetsCheckedListBox.Name = "TagAssetsCheckedListBox"
        Me.TagAssetsCheckedListBox.Size = New System.Drawing.Size(646, 429)
        Me.TagAssetsCheckedListBox.TabIndex = 4
        '
        'TagAssetsDefaultTagTextBox
        '
        Me.TagAssetsDefaultTagTextBox.Location = New System.Drawing.Point(105, 55)
        Me.TagAssetsDefaultTagTextBox.Name = "TagAssetsDefaultTagTextBox"
        Me.TagAssetsDefaultTagTextBox.Size = New System.Drawing.Size(547, 22)
        Me.TagAssetsDefaultTagTextBox.TabIndex = 2
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(21, 58)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(78, 16)
        Me.Label5.TabIndex = 3
        Me.Label5.Text = "Default Tag"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(6, 26)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(93, 16)
        Me.Label4.TabIndex = 2
        Me.Label4.Text = "Source Folder"
        '
        'TagAssetsSourceTextBox
        '
        Me.TagAssetsSourceTextBox.Location = New System.Drawing.Point(105, 23)
        Me.TagAssetsSourceTextBox.Name = "TagAssetsSourceTextBox"
        Me.TagAssetsSourceTextBox.Size = New System.Drawing.Size(547, 22)
        Me.TagAssetsSourceTextBox.TabIndex = 0
        '
        'TagAssetsBrowseButton
        '
        Me.TagAssetsBrowseButton.Location = New System.Drawing.Point(658, 21)
        Me.TagAssetsBrowseButton.Name = "TagAssetsBrowseButton"
        Me.TagAssetsBrowseButton.Size = New System.Drawing.Size(94, 26)
        Me.TagAssetsBrowseButton.TabIndex = 1
        Me.TagAssetsBrowseButton.Text = "Browse"
        Me.TagAssetsBrowseButton.UseVisualStyleBackColor = True
        '
        'DDCopyAssetsGroupBox
        '
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.DDCopyAssetsLogCheckBox)
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.CopyAssetsPortalsCheckBox)
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.CopyAssetsCreateTagsCheckBox)
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.CopyAssetsSourceTextBox)
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.CopyAssetsDestinationTextBox)
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.Label8)
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.Label7)
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.CopyAssetsStartButton)
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.CopyAssetsDestinationBrowseButton)
        Me.DDCopyAssetsGroupBox.Controls.Add(Me.CopyAssetsSourceBrowseButton)
        Me.DDCopyAssetsGroupBox.Location = New System.Drawing.Point(12, 33)
        Me.DDCopyAssetsGroupBox.Name = "DDCopyAssetsGroupBox"
        Me.DDCopyAssetsGroupBox.Size = New System.Drawing.Size(758, 117)
        Me.DDCopyAssetsGroupBox.TabIndex = 3
        Me.DDCopyAssetsGroupBox.TabStop = False
        Me.DDCopyAssetsGroupBox.Text = "DDCopyAssets GUI"
        '
        'CopyAssetsPortalsCheckBox
        '
        Me.CopyAssetsPortalsCheckBox.AutoSize = True
        Me.CopyAssetsPortalsCheckBox.Checked = True
        Me.CopyAssetsPortalsCheckBox.CheckState = System.Windows.Forms.CheckState.Checked
        Me.CopyAssetsPortalsCheckBox.Location = New System.Drawing.Point(268, 89)
        Me.CopyAssetsPortalsCheckBox.Name = "CopyAssetsPortalsCheckBox"
        Me.CopyAssetsPortalsCheckBox.Size = New System.Drawing.Size(128, 20)
        Me.CopyAssetsPortalsCheckBox.TabIndex = 5
        Me.CopyAssetsPortalsCheckBox.Text = "Separate Portals"
        Me.CopyAssetsPortalsCheckBox.UseVisualStyleBackColor = True
        '
        'CopyAssetsCreateTagsCheckBox
        '
        Me.CopyAssetsCreateTagsCheckBox.AutoSize = True
        Me.CopyAssetsCreateTagsCheckBox.Location = New System.Drawing.Point(135, 89)
        Me.CopyAssetsCreateTagsCheckBox.Name = "CopyAssetsCreateTagsCheckBox"
        Me.CopyAssetsCreateTagsCheckBox.Size = New System.Drawing.Size(127, 20)
        Me.CopyAssetsCreateTagsCheckBox.TabIndex = 4
        Me.CopyAssetsCreateTagsCheckBox.Text = "Create Tags File"
        Me.CopyAssetsCreateTagsCheckBox.UseVisualStyleBackColor = True
        '
        'CopyAssetsSourceTextBox
        '
        Me.CopyAssetsSourceTextBox.Location = New System.Drawing.Point(135, 23)
        Me.CopyAssetsSourceTextBox.Name = "CopyAssetsSourceTextBox"
        Me.CopyAssetsSourceTextBox.Size = New System.Drawing.Size(517, 22)
        Me.CopyAssetsSourceTextBox.TabIndex = 0
        '
        'CopyAssetsDestinationTextBox
        '
        Me.CopyAssetsDestinationTextBox.Location = New System.Drawing.Point(135, 55)
        Me.CopyAssetsDestinationTextBox.Name = "CopyAssetsDestinationTextBox"
        Me.CopyAssetsDestinationTextBox.Size = New System.Drawing.Size(517, 22)
        Me.CopyAssetsDestinationTextBox.TabIndex = 2
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(12, 58)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(117, 16)
        Me.Label8.TabIndex = 4
        Me.Label8.Text = "Destination Folder"
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(36, 26)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(93, 16)
        Me.Label7.TabIndex = 3
        Me.Label7.Text = "Source Folder"
        '
        'CopyAssetsStartButton
        '
        Me.CopyAssetsStartButton.Location = New System.Drawing.Point(658, 85)
        Me.CopyAssetsStartButton.Name = "CopyAssetsStartButton"
        Me.CopyAssetsStartButton.Size = New System.Drawing.Size(94, 26)
        Me.CopyAssetsStartButton.TabIndex = 7
        Me.CopyAssetsStartButton.Text = "Start"
        Me.CopyAssetsStartButton.UseVisualStyleBackColor = True
        '
        'CopyAssetsDestinationBrowseButton
        '
        Me.CopyAssetsDestinationBrowseButton.Location = New System.Drawing.Point(658, 53)
        Me.CopyAssetsDestinationBrowseButton.Name = "CopyAssetsDestinationBrowseButton"
        Me.CopyAssetsDestinationBrowseButton.Size = New System.Drawing.Size(94, 26)
        Me.CopyAssetsDestinationBrowseButton.TabIndex = 3
        Me.CopyAssetsDestinationBrowseButton.Text = "Browse"
        Me.CopyAssetsDestinationBrowseButton.UseVisualStyleBackColor = True
        '
        'CopyAssetsSourceBrowseButton
        '
        Me.CopyAssetsSourceBrowseButton.Location = New System.Drawing.Point(658, 21)
        Me.CopyAssetsSourceBrowseButton.Name = "CopyAssetsSourceBrowseButton"
        Me.CopyAssetsSourceBrowseButton.Size = New System.Drawing.Size(94, 26)
        Me.CopyAssetsSourceBrowseButton.TabIndex = 1
        Me.CopyAssetsSourceBrowseButton.Text = "Browse"
        Me.CopyAssetsSourceBrowseButton.UseVisualStyleBackColor = True
        '
        'DDConvertAssetsGroupBox
        '
        Me.DDConvertAssetsGroupBox.Controls.Add(Me.ConvertAssetsLogCheckBox)
        Me.DDConvertAssetsGroupBox.Controls.Add(Me.Label10)
        Me.DDConvertAssetsGroupBox.Controls.Add(Me.ConvertAssetsSourceTextBox)
        Me.DDConvertAssetsGroupBox.Controls.Add(Me.ConvertAssetsDestinationTextBox)
        Me.DDConvertAssetsGroupBox.Controls.Add(Me.Label9)
        Me.DDConvertAssetsGroupBox.Controls.Add(Me.ConvertAssetsStartButton)
        Me.DDConvertAssetsGroupBox.Controls.Add(Me.ConvertAssetsDestinationBrowseButton)
        Me.DDConvertAssetsGroupBox.Controls.Add(Me.ConvertAssetsSourceBrowseButton)
        Me.DDConvertAssetsGroupBox.Location = New System.Drawing.Point(12, 33)
        Me.DDConvertAssetsGroupBox.Name = "DDConvertAssetsGroupBox"
        Me.DDConvertAssetsGroupBox.Size = New System.Drawing.Size(758, 117)
        Me.DDConvertAssetsGroupBox.TabIndex = 7
        Me.DDConvertAssetsGroupBox.TabStop = False
        Me.DDConvertAssetsGroupBox.Text = "DDConvertAssets GUI"
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(30, 26)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(93, 16)
        Me.Label10.TabIndex = 6
        Me.Label10.Text = "Source Folder"
        '
        'ConvertAssetsSourceTextBox
        '
        Me.ConvertAssetsSourceTextBox.Location = New System.Drawing.Point(129, 23)
        Me.ConvertAssetsSourceTextBox.Name = "ConvertAssetsSourceTextBox"
        Me.ConvertAssetsSourceTextBox.Size = New System.Drawing.Size(523, 22)
        Me.ConvertAssetsSourceTextBox.TabIndex = 0
        '
        'ConvertAssetsDestinationTextBox
        '
        Me.ConvertAssetsDestinationTextBox.Location = New System.Drawing.Point(129, 55)
        Me.ConvertAssetsDestinationTextBox.Name = "ConvertAssetsDestinationTextBox"
        Me.ConvertAssetsDestinationTextBox.Size = New System.Drawing.Size(523, 22)
        Me.ConvertAssetsDestinationTextBox.TabIndex = 2
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(6, 58)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(117, 16)
        Me.Label9.TabIndex = 3
        Me.Label9.Text = "Destination Folder"
        '
        'ConvertAssetsStartButton
        '
        Me.ConvertAssetsStartButton.Location = New System.Drawing.Point(658, 85)
        Me.ConvertAssetsStartButton.Name = "ConvertAssetsStartButton"
        Me.ConvertAssetsStartButton.Size = New System.Drawing.Size(94, 26)
        Me.ConvertAssetsStartButton.TabIndex = 5
        Me.ConvertAssetsStartButton.Text = "Start"
        Me.ConvertAssetsStartButton.UseVisualStyleBackColor = True
        '
        'ConvertAssetsDestinationBrowseButton
        '
        Me.ConvertAssetsDestinationBrowseButton.Location = New System.Drawing.Point(658, 53)
        Me.ConvertAssetsDestinationBrowseButton.Name = "ConvertAssetsDestinationBrowseButton"
        Me.ConvertAssetsDestinationBrowseButton.Size = New System.Drawing.Size(94, 26)
        Me.ConvertAssetsDestinationBrowseButton.TabIndex = 3
        Me.ConvertAssetsDestinationBrowseButton.Text = "Browse"
        Me.ConvertAssetsDestinationBrowseButton.UseVisualStyleBackColor = True
        '
        'ConvertAssetsSourceBrowseButton
        '
        Me.ConvertAssetsSourceBrowseButton.Location = New System.Drawing.Point(658, 21)
        Me.ConvertAssetsSourceBrowseButton.Name = "ConvertAssetsSourceBrowseButton"
        Me.ConvertAssetsSourceBrowseButton.Size = New System.Drawing.Size(94, 26)
        Me.ConvertAssetsSourceBrowseButton.TabIndex = 1
        Me.ConvertAssetsSourceBrowseButton.Text = "Browse"
        Me.ConvertAssetsSourceBrowseButton.UseVisualStyleBackColor = True
        '
        'ConvertAssetsLogCheckBox
        '
        Me.ConvertAssetsLogCheckBox.AutoSize = True
        Me.ConvertAssetsLogCheckBox.Location = New System.Drawing.Point(129, 83)
        Me.ConvertAssetsLogCheckBox.Name = "ConvertAssetsLogCheckBox"
        Me.ConvertAssetsLogCheckBox.Size = New System.Drawing.Size(244, 20)
        Me.ConvertAssetsLogCheckBox.TabIndex = 4
        Me.ConvertAssetsLogCheckBox.Text = "Send output to DDConvertAssets.log"
        Me.ConvertAssetsLogCheckBox.UseVisualStyleBackColor = True
        '
        'TagAssetsLogCheckBox
        '
        Me.TagAssetsLogCheckBox.AutoSize = True
        Me.TagAssetsLogCheckBox.Location = New System.Drawing.Point(105, 83)
        Me.TagAssetsLogCheckBox.Name = "TagAssetsLogCheckBox"
        Me.TagAssetsLogCheckBox.Size = New System.Drawing.Size(223, 20)
        Me.TagAssetsLogCheckBox.TabIndex = 3
        Me.TagAssetsLogCheckBox.Text = "Send output to DDTagAssets.log"
        Me.TagAssetsLogCheckBox.UseVisualStyleBackColor = True
        '
        'DDCopyAssetsLogCheckBox
        '
        Me.DDCopyAssetsLogCheckBox.AutoSize = True
        Me.DDCopyAssetsLogCheckBox.Location = New System.Drawing.Point(402, 89)
        Me.DDCopyAssetsLogCheckBox.Name = "DDCopyAssetsLogCheckBox"
        Me.DDCopyAssetsLogCheckBox.Size = New System.Drawing.Size(230, 20)
        Me.DDCopyAssetsLogCheckBox.TabIndex = 6
        Me.DDCopyAssetsLogCheckBox.Text = "Send output to DDCopyAssets.log"
        Me.DDCopyAssetsLogCheckBox.UseVisualStyleBackColor = True
        '
        'ConvertPacksLogCheckBox
        '
        Me.ConvertPacksLogCheckBox.AutoSize = True
        Me.ConvertPacksLogCheckBox.Location = New System.Drawing.Point(408, 83)
        Me.ConvertPacksLogCheckBox.Name = "ConvertPacksLogCheckBox"
        Me.ConvertPacksLogCheckBox.Size = New System.Drawing.Size(238, 20)
        Me.ConvertPacksLogCheckBox.TabIndex = 5
        Me.ConvertPacksLogCheckBox.Text = "Send ouput to DDConvertPacks.log"
        Me.ConvertPacksLogCheckBox.UseVisualStyleBackColor = True
        '
        'TitlePanel
        '
        Me.TitlePanel.Controls.Add(Me.Label13)
        Me.TitlePanel.Controls.Add(Me.Label12)
        Me.TitlePanel.Controls.Add(Me.Label11)
        Me.TitlePanel.Location = New System.Drawing.Point(12, 33)
        Me.TitlePanel.Name = "TitlePanel"
        Me.TitlePanel.Size = New System.Drawing.Size(758, 150)
        Me.TitlePanel.TabIndex = 8
        '
        'Label11
        '
        Me.Label11.AutoSize = True
        Me.Label11.Font = New System.Drawing.Font("Middle Ages", 24.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label11.Location = New System.Drawing.Point(208, 18)
        Me.Label11.Name = "Label11"
        Me.Label11.Size = New System.Drawing.Size(341, 36)
        Me.Label11.TabIndex = 0
        Me.Label11.Text = "GUI Interface For"
        '
        'Label12
        '
        Me.Label12.AutoSize = True
        Me.Label12.Font = New System.Drawing.Font("Middle Ages", 24.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label12.Location = New System.Drawing.Point(67, 58)
        Me.Label12.Name = "Label12"
        Me.Label12.Size = New System.Drawing.Size(624, 36)
        Me.Label12.TabIndex = 1
        Me.Label12.Text = "EightBitz's Dungeondraft Scripts"
        '
        'Label13
        '
        Me.Label13.AutoSize = True
        Me.Label13.Font = New System.Drawing.Font("Middle Ages", 15.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label13.Location = New System.Drawing.Point(33, 102)
        Me.Label13.Name = "Label13"
        Me.Label13.Size = New System.Drawing.Size(691, 23)
        Me.Label13.TabIndex = 2
        Me.Label13.Text = "Select the script you wish to use from the Select Script menu."
        '
        'DDScriptGUIForm
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(8.0!, 16.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(782, 610)
        Me.Controls.Add(Me.DDConvertPacksGroupBox)
        Me.Controls.Add(Me.DDTagAssetsGroupBox)
        Me.Controls.Add(Me.TitlePanel)
        Me.Controls.Add(Me.DDCopyAssetsGroupBox)
        Me.Controls.Add(Me.DDConvertAssetsGroupBox)
        Me.Controls.Add(Me.MenuStrip1)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.MainMenuStrip = Me.MenuStrip1
        Me.Margin = New System.Windows.Forms.Padding(4)
        Me.Name = "DDScriptGUIForm"
        Me.Text = "DDScripts GUI"
        Me.MenuStrip1.ResumeLayout(False)
        Me.MenuStrip1.PerformLayout()
        Me.DDConvertPacksGroupBox.ResumeLayout(False)
        Me.DDConvertPacksGroupBox.PerformLayout()
        Me.DDTagAssetsGroupBox.ResumeLayout(False)
        Me.DDTagAssetsGroupBox.PerformLayout()
        Me.DDCopyAssetsGroupBox.ResumeLayout(False)
        Me.DDCopyAssetsGroupBox.PerformLayout()
        Me.DDConvertAssetsGroupBox.ResumeLayout(False)
        Me.DDConvertAssetsGroupBox.PerformLayout()
        Me.TitlePanel.ResumeLayout(False)
        Me.TitlePanel.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Friend WithEvents MenuStrip1 As MenuStrip
    Friend WithEvents SelectScriptToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents DDConvertAssetsMenuItem As ToolStripMenuItem
    Friend WithEvents DDConvertPacksMenuItem As ToolStripMenuItem
    Friend WithEvents DDCopyAssetsMenuItem As ToolStripMenuItem
    Friend WithEvents DDTagAssetsMenuItem As ToolStripMenuItem
    Friend WithEvents DDConvertPacksGroupBox As GroupBox
    Friend WithEvents ConvertPacksDestinationBrowseButton As Button
    Friend WithEvents ConvertPacksSourceBrowseButton As Button
    Friend WithEvents Label1 As Label
    Friend WithEvents ConvertPacksDestinationTextBox As TextBox
    Friend WithEvents ConvertPacksSourceTextBox As TextBox
    Friend WithEvents Label2 As Label
    Friend WithEvents ConvertPacksCheckedListBox As CheckedListBox
    Friend WithEvents Label3 As Label
    Friend WithEvents ConvertPacksCleanUpCheckBox As CheckBox
    Friend WithEvents ConvertPacksStartButton As Button
    Friend WithEvents ConvertPacksSelectNoneButton As Button
    Friend WithEvents ConvertPacksSelectAllButton As Button
    Friend WithEvents ConvertPacksSourceBrowserDialog As FolderBrowserDialog
    Friend WithEvents ConvertPacksDestinationBrowserDialog As FolderBrowserDialog
    Friend WithEvents DDTagAssetsGroupBox As GroupBox
    Friend WithEvents TagAssetsStartButton As Button
    Friend WithEvents TagAssetsSelectNoneButton As Button
    Friend WithEvents TagAssetsSelectAllButton As Button
    Friend WithEvents Label6 As Label
    Friend WithEvents TagAssetsCheckedListBox As CheckedListBox
    Friend WithEvents TagAssetsDefaultTagTextBox As TextBox
    Friend WithEvents Label5 As Label
    Friend WithEvents Label4 As Label
    Friend WithEvents TagAssetsSourceTextBox As TextBox
    Friend WithEvents TagAssetsBrowseButton As Button
    Friend WithEvents TagAssetsSourceBrowserDialog As FolderBrowserDialog
    Friend WithEvents DDCopyAssetsGroupBox As GroupBox
    Friend WithEvents CopyAssetsStartButton As Button
    Friend WithEvents CopyAssetsDestinationBrowseButton As Button
    Friend WithEvents CopyAssetsSourceBrowseButton As Button
    Friend WithEvents CopyAssetsPortalsCheckBox As CheckBox
    Friend WithEvents CopyAssetsCreateTagsCheckBox As CheckBox
    Friend WithEvents CopyAssetsSourceTextBox As TextBox
    Friend WithEvents CopyAssetsDestinationTextBox As TextBox
    Friend WithEvents Label8 As Label
    Friend WithEvents Label7 As Label
    Friend WithEvents CopyAssetsSourceBrowserDialog As FolderBrowserDialog
    Friend WithEvents CopyAssetsDestinationBrowserDialog As FolderBrowserDialog
    Friend WithEvents DDConvertAssetsGroupBox As GroupBox
    Friend WithEvents Label10 As Label
    Friend WithEvents ConvertAssetsSourceTextBox As TextBox
    Friend WithEvents ConvertAssetsDestinationTextBox As TextBox
    Friend WithEvents Label9 As Label
    Friend WithEvents ConvertAssetsStartButton As Button
    Friend WithEvents ConvertAssetsDestinationBrowseButton As Button
    Friend WithEvents ConvertAssetsSourceBrowseButton As Button
    Friend WithEvents ConvertAssetsSourceBrowserDialog As FolderBrowserDialog
    Friend WithEvents ConvertAssetsDestinationBrowserDialog As FolderBrowserDialog
    Friend WithEvents ConvertPacksLogCheckBox As CheckBox
    Friend WithEvents TagAssetsLogCheckBox As CheckBox
    Friend WithEvents DDCopyAssetsLogCheckBox As CheckBox
    Friend WithEvents ConvertAssetsLogCheckBox As CheckBox
    Friend WithEvents TitlePanel As Panel
    Friend WithEvents Label13 As Label
    Friend WithEvents Label12 As Label
    Friend WithEvents Label11 As Label
End Class
