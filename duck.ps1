Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

$cpuName = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name; $gpuName = (Get-CimInstance Win32_VideoController \vert{} Select-Object -First 1).Name; $ramGB = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 1); $osName = (Get-CimInstance Win32_OperatingSystem).Caption; $pcName = $env:COMPUTERNAME; $hwid = (Get-CimInstance -Class Win32_ComputerSystemProduct).UUID

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="DuckDuckSetting" Height="650" Width="950"
        WindowStyle="None" AllowsTransparency="True" Background="Transparent"
        WindowStartupLocation="CenterScreen">
    <Window.Resources>
        <Style TargetType="RadioButton" x:Key="MenuButton">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="#888888"/>
            <Setter Property="FontSize" Value="14"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="Margin" Value="10,5,10,5"/>
            <Setter Property="Height" Value="45"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="RadioButton">
                        <Border Background="{TemplateBinding Background}" CornerRadius="8" Padding="20,0,0,0">
                            <ContentPresenter VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Foreground" Value="White"/>
                                <Setter Property="Background" Value="#1A1A1A"/>
                            </Trigger>
                            <Trigger Property="IsChecked" Value="True">
                                <Setter Property="Foreground" Value="#4CAF50"/>
                                <Setter Property="Background" Value="#1A1A1A"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>

        <Style TargetType="Button" x:Key="BigActionButton">
            <Setter Property="Background" Value="White"/>
            <Setter Property="Foreground" Value="Black"/>
            <Setter Property="FontSize" Value="18"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Background="{TemplateBinding Background}" CornerRadius="12" Padding="20">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center"/>
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Background" Value="#E0E0E0"/>
                            </Trigger>
                            <Trigger Property="IsPressed" Value="True">
                                <Setter Property="Background" Value="#4CAF50"/>
                                <Setter Property="Foreground" Value="White"/>
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>

    <Border CornerRadius="12" Background="#0A0A0A" BorderBrush="#333" BorderThickness="1" Name="MainBorder">
        <Grid>
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="250"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>
            
            <Border Grid.Column="0" Background="#121212" CornerRadius="12,0,0,12" BorderBrush="#222" BorderThickness="0,0,1,0">
                <Grid>
                    <StackPanel Margin="0,30,0,0">
                        <StackPanel Orientation="Horizontal" Margin="20,0,0,40">
                            <Border Width="45" Height="45" CornerRadius="22" Background="#333">
                                <TextBlock Text="🦆" HorizontalAlignment="Center" VerticalAlignment="Center" FontSize="24"/>
                            </Border>
                            <StackPanel Margin="15,0,0,0" VerticalAlignment="Center">
                                <TextBlock Text="DuckDuck" Foreground="White" FontSize="18" FontWeight="Bold"/>
                                <TextBlock Text="Premium VIP" Foreground="#4CAF50" FontSize="11"/>
                            </StackPanel>
                        </StackPanel>
                        
                        <TextBlock Text="MENU" Foreground="#555" FontSize="11" FontWeight="Bold" Margin="25,0,0,10"/>
                        <RadioButton Name="MenuDashboard" Content="Dashboard" Style="{StaticResource MenuButton}" IsChecked="True"/>
                        <RadioButton Name="MenuSetup" Content="One-Click Setup" Style="{StaticResource MenuButton}"/>
                        <RadioButton Name="MenuSystemInfo" Content="System Info" Style="{StaticResource MenuButton}"/>
                    </StackPanel>
                </Grid>
            </Border>

            <Grid Grid.Column="1">
                <Button Name="BtnClose" Content="✕" Foreground="#888" Background="Transparent" BorderThickness="0" HorizontalAlignment="Right" VerticalAlignment="Top" Width="40" Height="40" Margin="0,10,10,0" FontSize="18" Cursor="Hand" Panel.ZIndex="10"/>

                <TabControl Name="MainTabControl" Background="Transparent" BorderThickness="0" Margin="40,50,40,40">
                    <TabControl.ItemContainerStyle>
                        <Style TargetType="TabItem">
                            <Setter Property="Visibility" Value="Collapsed"/>
                        </Style>
                    </TabControl.ItemContainerStyle>

                    <TabItem>
                        <StackPanel VerticalAlignment="Center" HorizontalAlignment="Center">
                            <TextBlock Text="Welcome to DuckDuckSetting" Foreground="White" FontSize="32" FontWeight="Bold" HorizontalAlignment="Center"/>
                            <TextBlock Text="The ultimate Windows &amp; FiveM Optimization tool." Foreground="#888" FontSize="16" HorizontalAlignment="Center" Margin="0,10,0,40"/>
                            
                            <Border Background="#151515" CornerRadius="12" BorderBrush="#222" BorderThickness="1" Padding="30">
                                <StackPanel>
                                    <TextBlock Text="Status: READY TO OPTIMIZE" Foreground="#4CAF50" FontSize="14" FontWeight="Bold" HorizontalAlignment="Center"/>
                                    <TextBlock Text="Please navigate to 'One-Click Setup' to begin." Foreground="#666" FontSize="12" HorizontalAlignment="Center" Margin="0,10,0,0"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </TabItem>

                    <TabItem>
                        <StackPanel>
                            <StackPanel Orientation="Horizontal" Margin="0,0,0,30">
                                <Border Width="60" Height="60" Background="#222" CornerRadius="12" Margin="0,0,20,0">
                                    <TextBlock Text="⚡" HorizontalAlignment="Center" VerticalAlignment="Center" FontSize="30" Foreground="White"/>
                                </Border>
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock Text="Auto VIP Optimization" Foreground="White" FontSize="26" FontWeight="Bold"/>
                                    <TextBlock Text="กดปุ่มเดียวเพื่อปรับแต่งระบบทั้งหมดให้พร้อมเล่น FiveM" Foreground="#888" FontSize="13"/>
                                </StackPanel>
                            </StackPanel>
                            
                            <Border Background="#151515" CornerRadius="12" BorderBrush="#333" BorderThickness="1" Padding="30">
                                <StackPanel>
                                    <TextBlock Text="ระบบจะทำการปรับแต่งดังนี้:" Foreground="White" FontSize="15" FontWeight="Bold" Margin="0,0,0,10"/>
                                    <TextBlock Text="• Optimize CPU V-Cache &amp; Thread Priority`n• Tune 32GB Memory Mapping`n• Disable Windows GameBar &amp; Anti-Stutter`n• Optimize Network TCP for Low Latency`n• Deep Clean Background Processes &amp; Temp Files" Foreground="#AAA" FontSize="13" LineHeight="22"/>
                                    
                                    <Button Name="BtnRunAll" Content="🚀 APPLY FULL OPTIMIZATION" Style="{StaticResource BigActionButton}" Margin="0,30,0,0"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </TabItem>

                    <TabItem>
                        <StackPanel>
                            <TextBlock Text="System Information" Foreground="White" FontSize="28" FontWeight="Bold" Margin="0,0,0,20"/>
                            
                            <Border Background="#151515" CornerRadius="12" BorderBrush="#222" BorderThickness="1" Padding="25">
                                <StackPanel>
                                    <TextBlock Text="Hardware ID (UUID)" Foreground="#666" FontSize="11" FontWeight="Bold"/>
                                    <TextBox Text="$hwid" Background="#111" Foreground="#4CAF50" BorderThickness="0" Padding="8" Margin="0,5,0,15" IsReadOnly="True" FontSize="13"/>
                                    
                                    <TextBlock Text="Processor:" Foreground="#666" FontSize="11" FontWeight="Bold"/>
                                    <TextBlock Text="$cpuName" Foreground="White" FontSize="14" Margin="0,3,0,15"/>
                                    
                                    <TextBlock Text="Graphics:" Foreground="#666" FontSize="11" FontWeight="Bold"/>
                                    <TextBlock Text="$gpuName" Foreground="White" FontSize="14" Margin="0,3,0,15"/>
                                    
                                    <TextBlock Text="Memory:" Foreground="#666" FontSize="11" FontWeight="Bold"/>
                                    <TextBlock Text="$ramGB GB" Foreground="White" FontSize="14"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </TabItem>

                </TabControl>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$form = [Windows.Markup.XamlReader]::Load($reader)

$MainBorder =$form.FindName("MainBorder")
$BtnClose =$form.FindName("BtnClose")
$MainTabControl =$form.FindName("MainTabControl")

$MenuDashboard =$form.FindName("MenuDashboard")
$MenuSetup =$form.FindName("MenuSetup")
$MenuSystemInfo =$form.FindName("MenuSystemInfo")
$BtnRunAll =$form.FindName("BtnRunAll")

$MainBorder.Add_MouseLeftButtonDown({$form.DragMove() })
$BtnClose.Add_Click({$form.Close() })

$MenuDashboard.Add_Checked({$MainTabControl.SelectedIndex = 0 })
$MenuSetup.Add_Checked({$MainTabControl.SelectedIndex = 1 })
$MenuSystemInfo.Add_Checked({$MainTabControl.SelectedIndex = 2 })

$BtnRunAll.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("กำลังเริ่มการตั้งค่า VIP Optimization กรุณารอสักครู่...", "DuckDuckSetting", 0, 64)
    
    cmd.exe /c 'reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FiveM.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d 3 /f >nul 2>&1'
    cmd.exe /c 'reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 26 /f >nul 2>&1'
    cmd.exe /c 'reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "DisablePagingExecutive" /t REG_DWORD /d 1 /f >nul 2>&1'
    cmd.exe /c 'reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "LargeSystemCache" /t REG_DWORD /d 1 /f >nul 2>&1'
    cmd.exe /c 'reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f >nul 2>&1'
    cmd.exe /c 'reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul 2>&1'
    cmd.exe /c 'netsh int tcp set global autotuninglevel=normal >nul 2>&1'
    cmd.exe /c 'reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TcpAckFrequency" /t REG_DWORD /d 1 /f >nul 2>&1'
    cmd.exe /c 'reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v "TCPNoDelay" /t REG_DWORD /d 1 /f >nul 2>&1'
    cmd.exe /c 'taskkill /f /im "OneDrive.exe" 2>nul'
    cmd.exe /c 'taskkill /f /im "SearchIndexer.exe" 2>nul'
    cmd.exe /c 'del /s /f /q "%USERPROFILE%\AppData\Local\Temp\*" 2>nul'
    
    [System.Windows.Forms.MessageBox]::Show("ตั้งค่าเสร็จสิ้น! กรุณารีสตาร์ทเครื่อง 1 ครั้ง", "DuckDuckSetting", 0, 64)
})

$form.ShowDialog() | Out-Null
