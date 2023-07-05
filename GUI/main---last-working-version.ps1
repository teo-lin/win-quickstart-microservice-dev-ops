Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Get the list of tools
$tools = Get-Content -Raw -Path "tools.json" | ConvertFrom-Json

# Get the screen size
$screenWidth = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width
$screenHeight = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height

# Create a font with larger font size
$font = New-Object System.Drawing.Font("Segoe UI", 14)
$fontBold = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)

# Create a form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Dev Tools Installer"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size($screenWidth, $screenHeight)
$form.WindowState = "Maximized"

# Create a label 
$label = New-Object System.Windows.Forms.Label
$label.Text = "Select the tools/apps you'd like to install/update:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(140, 20)
$label.Font = $fontBold
$form.Controls.Add($label)

# Create a Panel to hold the checkboxes
$panel = New-Object System.Windows.Forms.Panel
$panel.Location = New-Object System.Drawing.Point(10, 60)
$ww = $screenWidth - 50
$hh = $screenHeight - 120
$panel.Size = New-Object System.Drawing.Size($ww, $hh)
$form.Controls.Add($panel)
$panel.AutoScroll = $true

# Create Checkboxes 
$checkboxSize = New-Object System.Drawing.Size(800, 30)
$y = 0
foreach ($tool in $tools.PSObject.Properties) {
    $checkbox = New-Object System.Windows.Forms.CheckBox
    $checkbox.Text = $tool.Value.text
    $checkbox.Size = $checkboxSize
    $checkbox.Location = New-Object System.Drawing.Point($tool.Value.location.x, $y)
    $checkbox.Font = $font
    $panel.Controls.Add($checkbox)
    $y += 26
}

# Create a button to start the installation with larger font size, bold and red font
$install_button = New-Object System.Windows.Forms.Button
$install_button.Text = "Install"
$install_button.Location = New-Object System.Drawing.Point(10, 16)
$install_button.Size = New-Object System.Drawing.Size(120, 40)
$install_button.Font = $fontBold
$install_button.ForeColor = [System.Drawing.Color]::Red
$form.Controls.Add($install_button)
$install_button.Add_Click({ Install-DevTools })

# Show the form
$form.ShowDialog() | Out-Null