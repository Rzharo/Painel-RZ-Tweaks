[System.Windows.MessageBox]::Show("Script carregado!", "Status", "OK", "Info")

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.Drawing

# Criar a janela com XAML corrigido
[xml]$xaml = @"
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Painel de Tweaks RZ" 
    Height="600" 
    Width="800" 
    ResizeMode="NoResize" 
    WindowStartupLocation="CenterScreen">
    <Grid Background="#1e1e1e">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Logo -->
        <Image Source="RzLogo_resized.png" Width="100" Height="100" Margin="10" HorizontalAlignment="Left"/>

        <!-- Abas -->
        <TabControl x:Name="Tabs" Grid.Row="1" Margin="10" Background="#2e2e2e" Foreground="White">
            <TabItem Header="Sistema">
                <StackPanel Margin="10">
                    <CheckBox x:Name="chkDragFullWindows" Content="Desativar movimentação de janelas com conteúdo"/>
                    <CheckBox x:Name="chkMenuDelay" Content="Reduzir atraso do menu"/>
                    <CheckBox x:Name="chkMinAnimate" Content="Desativar animação de minimizar"/>
                    <CheckBox x:Name="chkKeyboardDelay" Content="Reduzir atraso do teclado"/>
                </StackPanel>
            </TabItem>
            <TabItem Header="Privacidade">
                <StackPanel Margin="10">
                    <CheckBox x:Name="chkTelemetry" Content="Desativar Telemetria"/>
                    <CheckBox x:Name="chkCopilot" Content="Desativar Copilot"/>
                </StackPanel>
            </TabItem>
            <TabItem Header="Interface">
                <StackPanel Margin="10">
                    <CheckBox x:Name="chkTaskView" Content="Ocultar Botão de Tarefas"/>
                    <CheckBox x:Name="chkNotifications" Content="Desativar Notificações"/>
                </StackPanel>
            </TabItem>
            <TabItem Header="Serviços">
                <StackPanel Margin="10">
                    <CheckBox x:Name="chkAdobeServices" Content="Desativar Serviços Adobe"/>
                    <CheckBox x:Name="chkRemoveOneDrive" Content="Remover OneDrive"/>
                </StackPanel>
            </TabItem>
        </TabControl>

        <!-- Botões -->
        <StackPanel Grid.Row="2" Orientation="Horizontal" HorizontalAlignment="Right" Margin="10">
            <Button x:Name="btnAplicar" Content="Aplicar Tweaks" Width="120" Margin="5" Background="#3a3a3a" Foreground="White"/>
            <Button x:Name="btnRestaurar" Content="Desfazer Tweaks" Width="120" Margin="5" Background="#3a3a3a" Foreground="White"/>
        </StackPanel>
    </Grid>
</Window>
"@

# Corrigir o caminho da imagem se necessário
if (-not (Test-Path "RzLogo_resized.png")) {
    # Cria uma imagem temporária se não existir
    [System.Drawing.Bitmap]::new(100,100).Save("$PWD\RzLogo_resized.png")
}

# Criar o leitor de XAML corrigido
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
try {
    $window = [Windows.Markup.XamlReader]::Load($reader)
    
    # Controles
    $chkDragFullWindows = $window.FindName("chkDragFullWindows")
    $chkMenuDelay = $window.FindName("chkMenuDelay")
    $chkMinAnimate = $window.FindName("chkMinAnimate")
    $chkKeyboardDelay = $window.FindName("chkKeyboardDelay")
    $chkTelemetry = $window.FindName("chkTelemetry")
    $chkCopilot = $window.FindName("chkCopilot")
    $chkTaskView = $window.FindName("chkTaskView")
    $chkNotifications = $window.FindName("chkNotifications")
    $chkAdobeServices = $window.FindName("chkAdobeServices")
    $chkRemoveOneDrive = $window.FindName("chkRemoveOneDrive")
    $btnAplicar = $window.FindName("btnAplicar")
    $btnRestaurar = $window.FindName("btnRestaurar")

    # Função para aplicar tema
    function Set-Tema {
        param ([string]$modo)
        $window.Background = if ($modo -eq "Escuro") { "#1e1e1e" } else { "White" }
    }

    # Aplicar Tweaks
    $btnAplicar.Add_Click({
        # Seu código de aplicação de tweaks aqui
        [System.Windows.MessageBox]::Show("Tweaks aplicados com sucesso!", "Concluído", 'OK', 'Info')
    })

    # Restaurar Tweaks
    $btnRestaurar.Add_Click({
        # Seu código de restauração aqui
        [System.Windows.MessageBox]::Show("Tweaks restaurados com sucesso!", "Restaurado", 'OK', 'Info')
    })

    # Aplicar tema inicial
    Set-Tema -modo "Escuro"

    # Mostrar janela
    $window.ShowDialog() | Out-Null
}
catch {
    [System.Windows.MessageBox]::Show("Erro ao carregar a interface: $_", "Erro", 'OK', 'Error')
}
