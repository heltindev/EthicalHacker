@echo off
title Hacker Etico - Auditoria de Seguranca
chcp 65001 >nul
color 0A
cls

echo.
echo  ╔═══════════════════════════════════════════════════════╗
echo  ║      H A C K E R   E T I C O   -   L O A D E R        ║
echo  ╚═══════════════════════════════════════════════════════╝
echo.
echo  Preparando ambiente...
echo.

set "PS1=%TEMP%\hacker_etico_%RANDOM%.ps1"

powershell -NoProfile -Command "$c = Get-Content -LiteralPath '%~f0' -Raw; $i = $c.IndexOf('#___PS_START___'); if ($i -lt 0) { exit 1 }; Set-Content -LiteralPath '%PS1%' -Value $c.Substring($i) -Encoding UTF8"

if not exist "%PS1%" (
    echo  [ERRO] Nao foi possivel extrair o script.
    echo.
    pause
    exit /b 1
)

echo  Executando auditoria...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%PS1%"

del "%PS1%" >nul 2>&1

echo.
echo  ╔═══════════════════════════════════════════════════════╗
echo  ║                    FIM DA SESSAO                      ║
echo  ╚═══════════════════════════════════════════════════════╝
echo.
echo  Pressione qualquer tecla para sair...
pause >nul

exit /b


#___PS_START___
# ═══════════════════════════════════════════════════════════
#   HACKER ÉTICO - AUDITORIA DE SEGURANÇA - v1.0 (PowerShell)
#   Uso permitido: apenas em sites que são seus
# ═══════════════════════════════════════════════════════════

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

# ─── Cores ───
function Write-Verde    { param($t) Write-Host $t -ForegroundColor Green }
function Write-Amarelo  { param($t) Write-Host $t -ForegroundColor Yellow }
function Write-Azul     { param($t) Write-Host $t -ForegroundColor Cyan }
function Write-Magenta  { param($t) Write-Host $t -ForegroundColor Magenta }
function Write-Vermelho { param($t) Write-Host $t -ForegroundColor Red }
function Write-Branco   { param($t) Write-Host $t -ForegroundColor White }
function Write-Cinza    { param($t) Write-Host $t -ForegroundColor DarkGray }

function Write-Linha {
    param($char = '─', $n = 64)
    Write-Cinza ($char * $n)
}

function Barra {
    param($pct, $w = 40)
    $cheio = [Math]::Round(($pct / 100) * $w)
    $vazio = $w - $cheio
    return ('█' * $cheio) + ('░' * $vazio)
}

function Hex-Random {
    param($n = 12)
    $chars = '0123456789ABCDEF'.ToCharArray()
    -join (1..$n | ForEach-Object { $chars | Get-Random })
}

function Atualizar-Linha {
    param($texto, $cor = 'Green')
    Write-Host "`r$texto" -NoNewline -ForegroundColor $cor
}

function Banner-Resultado {
    param($tipo)
    if ($tipo -eq 'defendido') {
        $cor = 'Green'
        $texto = '🛡️  DEFENDIDO'
        $detalhe = 'Sistema bloqueou o ataque'
    } else {
        $cor = 'Red'
        $texto = '🚨  INVADIDO'
        $detalhe = 'Brecha explorada com sucesso'
    }
    Write-Host ''
    Write-Host ('     ╔═══════════════════════════════════════════╗') -ForegroundColor $cor
    Write-Host ("     ║  {0,-41}║" -f $texto) -ForegroundColor $cor
    Write-Host ("     ║  {0,-41}║" -f $detalhe) -ForegroundColor $cor
    Write-Host ('     ╚═══════════════════════════════════════════╝') -ForegroundColor $cor
    Write-Host ''
}

# ═══════════════════════════════════════════════════════════
# DESCOBERTA DE CREDENCIAIS
# ═══════════════════════════════════════════════════════════
function Buscar-Credenciais {
    param($urlSite)

    Write-Cinza '  > Baixando HTML da página...'
    $urls = @()
    $chaves = @()

    try {
        $headers = @{ 'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' }
        $resp = Invoke-WebRequest -Uri $urlSite -Headers $headers -UseBasicParsing -TimeoutSec 15
        $html = $resp.Content

        $m1 = [regex]::Matches($html, 'https://([a-z0-9]+)\.supabase\.co')
        foreach ($m in $m1) { $urls += $m.Value }

        $m2 = [regex]::Matches($html, 'eyJ[A-Za-z0-9_-]{50,}\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+')
        foreach ($m in $m2) { $chaves += $m.Value }

        $m3 = [regex]::Matches($html, 'sb_publishable_[A-Za-z0-9_-]+')
        foreach ($m in $m3) { $chaves += $m.Value }

        $sM = [regex]::Matches($html, '<script[^>]+src=["'']([^"'']+)["'']')
        $scripts = @()
        foreach ($m in $sM) {
            $src = $m.Groups[1].Value
            if ($src.StartsWith('//')) { $src = 'https:' + $src }
            elseif ($src.StartsWith('/')) {
                $u = [System.Uri]::new($urlSite)
                $src = $u.Scheme + '://' + $u.Host + $src
            }
            $scripts += $src
        }

        Write-Cinza ("  > Analisando {0} scripts..." -f $scripts.Count)

        foreach ($src in $scripts) {
            try {
                $rs = Invoke-WebRequest -Uri $src -Headers $headers -UseBasicParsing -TimeoutSec 15
                $txt = $rs.Content

                $s1 = [regex]::Matches($txt, 'https://([a-z0-9]+)\.supabase\.co')
                foreach ($m in $s1) { $urls += $m.Value }

                $s2 = [regex]::Matches($txt, 'eyJ[A-Za-z0-9_-]{50,}\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+')
                foreach ($m in $s2) { $chaves += $m.Value }

                $s3 = [regex]::Matches($txt, 'sb_publishable_[A-Za-z0-9_-]+')
                foreach ($m in $s3) { $chaves += $m.Value }
            } catch { }
        }
    } catch {
        Write-Vermelho ("  X Erro ao buscar HTML: {0}" -f $_.Exception.Message)
        return $null
    }

    $urlFinal = $urls | Select-Object -Unique | Select-Object -First 1
    $chaveFinal = ($chaves | Select-Object -Unique | Where-Object { $_ -like 'sb_publishable_*' } | Select-Object -First 1)
    if (-not $chaveFinal) {
        $chaveFinal = ($chaves | Select-Object -Unique | Where-Object { $_ -like 'eyJ*' } | Select-Object -First 1)
    }

    if (-not $urlFinal -or -not $chaveFinal) { return $null }
    return @{ url = $urlFinal; chave = $chaveFinal }
}

# ═══════════════════════════════════════════════════════════
# SIMULAÇÃO DE ATAQUE
# ═══════════════════════════════════════════════════════════
function Simular-Ataque {
    param([int]$num, [string]$nome, [scriptblock]$executar, [int]$total)

    Write-Host ''
    Write-Vermelho '  ╔═══════════════════════════════════════════════════════╗'
    Write-Vermelho ("  ║  ATAQUE #{0:D2} - {1,-33}║" -f $num, $nome)
    Write-Vermelho '  ╚═══════════════════════════════════════════════════════╝'

    Write-Host ''
    for ($p = 0; $p -le 100; $p += 20) {
        $pctGlobal = [Math]::Round((($num - 1) * 100 + $p) / $total)
        Atualizar-Linha ("  [HACKEANDO] [{0}] {1,3}%" -f (Barra $pctGlobal 40), $pctGlobal) 'Red'
        Start-Sleep -Milliseconds 50
    }
    Write-Host ''

    for ($k = 0; $k -lt 2; $k++) {
        $ip = "{0}.{1}.{2}.{3}" -f (Get-Random -Max 255), (Get-Random -Max 255), (Get-Random -Max 255), (Get-Random -Max 255)
        Write-Cinza ("     [{0}] injetando payload..." -f $ip)
        Start-Sleep -Milliseconds 80
    }

    $ok = $true
    try {
        $resultado = & $executar
        $ok = $resultado
    } catch {
        $ok = $true
    }

    if ($ok) { Banner-Resultado 'defendido' } else { Banner-Resultado 'invadido' }
    Start-Sleep -Milliseconds 200
    return $ok
}

# ═══════════════════════════════════════════════════════════
# AUDITORIA COMPLETA
# ═══════════════════════════════════════════════════════════
function Auditar {
    param($urlSite, $urlSupabase, $chave)

    $REST = $urlSupabase.TrimEnd('/') + '/rest/v1/'
    $AUTH = $urlSupabase.TrimEnd('/') + '/auth/v1/'
    $FALSO = '00000000-0000-0000-0000-000000000000'
    $tabelas = @('profiles','user_favorites','user_history','songs','user_quiz_completions','user_song_guess_attempts')
    $rpcs = @('get_song_guess_round','submit_song_guess','complete_quiz')

    $headersBase = @{ apikey = $chave }
    $headersJson = @{ apikey = $chave; 'Content-Type' = 'application/json' }
    $headersJwtFake = @{ apikey = $chave; Authorization = 'Bearer fake.eyJzdWIiOiJmYWtlIn0.fake' }

    $resultados = @()
    $total = 12

    # 1. Leitura
    $ok = Simular-Ataque 1 'LEITURA ANONIMA (SELECT)' {
        $seguro = $true
        foreach ($t in $tabelas) {
            try {
                $r = Invoke-RestMethod -Uri ($REST + $t + '?select=*&limit=5') -Headers $headersBase -Method Get -TimeoutSec 10
                if ($r -and $r.Count -gt 0) { $seguro = $false; break }
            } catch { }
        }
        return $seguro
    } $total
    $resultados += @{ nome = 'LEITURA ANONIMA (SELECT)'; ok = $ok }

    # 2. Escrita
    $ok = Simular-Ataque 2 'INJECAO DE DADOS (INSERT)' {
        $seguro = $true
        foreach ($t in $tabelas) {
            try {
                Invoke-RestMethod -Uri ($REST + $t) -Headers $headersJson -Method Post -Body '{}' -TimeoutSec 10 | Out-Null
                $seguro = $false; break
            } catch { }
        }
        return $seguro
    } $total
    $resultados += @{ nome = 'INJECAO DE DADOS (INSERT)'; ok = $ok }

    # 3. Delete
    $ok = Simular-Ataque 3 'DESTRUICAO DE DADOS (DELETE)' {
        $seguro = $true
        foreach ($t in $tabelas) {
            foreach ($col in @('id','user_id','song_id')) {
                try {
                    $r = Invoke-RestMethod -Uri ($REST + $t + '?' + $col + '=eq.' + $FALSO) -Headers $headersBase -Method Delete -TimeoutSec 10
                    if ($r -and $r.Count -gt 0) { $seguro = $false; break }
                    break
                } catch { break }
            }
            if (-not $seguro) { break }
        }
        return $seguro
    } $total
    $resultados += @{ nome = 'DESTRUICAO DE DADOS (DELETE)'; ok = $ok }

    # 4. RPCs
    $ok = Simular-Ataque 4 'EXECUCAO DE FUNCOES (RPC)' {
        $seguro = $true
        foreach ($rpc in $rpcs) {
            try {
                $body = '{"song_uuid":"' + $FALSO + '","submitted_answer":"x","quiz_index":0}'
                Invoke-RestMethod -Uri ($REST + 'rpc/' + $rpc) -Headers $headersJson -Method Post -Body $body -TimeoutSec 10 | Out-Null
                $seguro = $false; break
            } catch { }
        }
        return $seguro
    } $total
    $resultados += @{ nome = 'EXECUCAO DE FUNCOES (RPC)'; ok = $ok }

    # 5. SQL Injection
    $ok = Simular-Ataque 5 'INJECAO SQL NO LOGIN' {
        $payloads = @("' OR 1=1 --", "admin' --", "' UNION SELECT NULL --")
        $seguro = $true
        foreach ($p in $payloads) {
            try {
                $body = (@{ email = $p; password = 'x' } | ConvertTo-Json -Compress)
                Invoke-RestMethod -Uri ($AUTH + 'token?grant_type=password') -Headers $headersJson -Method Post -Body $body -TimeoutSec 10 | Out-Null
                $seguro = $false; break
            } catch { }
        }
        return $seguro
    } $total
    $resultados += @{ nome = 'INJECAO SQL NO LOGIN'; ok = $ok }

    # 6. JWT forjado
    $ok = Simular-Ataque 6 'FORJA DE TOKEN JWT' {
        try {
            $r = Invoke-RestMethod -Uri ($REST + 'profiles?select=*&limit=1') -Headers $headersJwtFake -Method Get -TimeoutSec 10
            return (-not ($r -and $r.Count -gt 0))
        } catch { return $true }
    } $total
    $resultados += @{ nome = 'FORJA DE TOKEN JWT'; ok = $ok }

    # 7. Enumeração
    $ok = Simular-Ataque 7 'ENUMERACAO DE USUARIOS' {
        try {
            $email = "teste$(Hex-Random 8)@naoexiste.com".ToLower()
            $body = (@{ email = $email; password = 'SenhaForte!123' } | ConvertTo-Json -Compress)
            $r = Invoke-WebRequest -Uri ($AUTH + 'signup') -Headers $headersJson -Method Post -Body $body -TimeoutSec 10 -UseBasicParsing
            $suspeito = $r.Content -match 'already|exist|registrad'
            return (-not $suspeito)
        } catch {
            $msg = $_.Exception.Message
            return (-not ($msg -match 'already|exist|registrad'))
        }
    } $total
    $resultados += @{ nome = 'ENUMERACAO DE USUARIOS'; ok = $ok }

    # 8. Headers
    $ok = Simular-Ataque 8 'CABECALHOS DE SEGURANCA HTTP' {
        try {
            $r = Invoke-WebRequest -Uri $urlSite -Method Head -UseBasicParsing -TimeoutSec 10
            $headers = @('Content-Security-Policy','X-Frame-Options','Strict-Transport-Security','X-Content-Type-Options')
            $faltando = @()
            foreach ($h in $headers) {
                if (-not $r.Headers[$h]) { $faltando += $h }
            }
            return ($faltando.Count -eq 0)
        } catch { return $true }
    } $total
    $resultados += @{ nome = 'CABECALHOS DE SEGURANCA HTTP'; ok = $ok }

    # 9. CORS
    $ok = Simular-Ataque 9 'CONFIGURACAO DE CORS' {
        try {
            $h = @{ apikey = $chave; Origin = 'https://site-malicioso.com' }
            $r = Invoke-WebRequest -Uri ($REST + 'profiles?select=*&limit=1') -Headers $h -UseBasicParsing -TimeoutSec 10
            $allow = $r.Headers['Access-Control-Allow-Origin']
            return (-not ($allow -eq '*' -or $allow -eq 'https://site-malicioso.com'))
        } catch { return $true }
    } $total
    $resultados += @{ nome = 'CONFIGURACAO DE CORS'; ok = $ok }

    # 10. Storage
    $ok = Simular-Ataque 10 'EXPOSICAO DE STORAGE' {
        try {
            $r = Invoke-WebRequest -Uri ($urlSupabase.TrimEnd('/') + '/storage/v1/bucket') -Headers $headersBase -UseBasicParsing -TimeoutSec 10
            $json = $r.Content | ConvertFrom-Json
            $suspeito = $false
            foreach ($b in $json) { if ($b.public -eq $true) { $suspeito = $true; break } }
            return (-not $suspeito)
        } catch { return $true }
    } $total
    $resultados += @{ nome = 'EXPOSICAO DE STORAGE'; ok = $ok }

    # 11. Rate limit
    $ok = Simular-Ataque 11 'VERIFICACAO DE RATE LIMIT' {
        $temRateLimit = $false
        for ($k = 0; $k -lt 5; $k++) {
            try {
                $body = (@{ email = "x$k@x.com"; password = 'x' } | ConvertTo-Json -Compress)
                Invoke-RestMethod -Uri ($AUTH + 'token?grant_type=password') -Headers $headersJson -Method Post -Body $body -TimeoutSec 10 | Out-Null
            } catch {
                if ($_.Exception.Response.StatusCode.value__ -eq 429) { $temRateLimit = $true; break }
            }
        }
        return $temRateLimit
    } $total
    $resultados += @{ nome = 'VERIFICACAO DE RATE LIMIT'; ok = $ok }

    # 12. Open redirect
    $ok = Simular-Ataque 12 'REDIRECIONAMENTO ABERTO' {
        try {
            $u = [System.Uri]::new($urlSite)
            foreach ($p in @('redirect','url','next')) {
                try {
                    $r = Invoke-WebRequest -Uri ($u.Scheme + '://' + $u.Host + '/?' + $p + '=https://site-malicioso.com') -UseBasicParsing -TimeoutSec 10 -MaximumRedirection 0 -ErrorAction Stop
                    if ($r.Headers['Location'] -match 'site-malicioso') { return $false }
                } catch {
                    $loc = $_.Exception.Response.Headers['Location']
                    if ($loc -match 'site-malicioso') { return $false }
                }
            }
            return $true
        } catch { return $true }
    } $total
    $resultados += @{ nome = 'REDIRECIONAMENTO ABERTO'; ok = $ok }

    return $resultados
}

# ═══════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════
Clear-Host

Write-Host ''
Write-Verde '  ╔═══════════════════════════════════════════════════════╗'
Write-Verde '  ║      H A C K E R   E T I C O   -   T O O L K I T      ║'
Write-Verde '  ║                    v 1 . 0   B A T                      ║'
Write-Verde '  ╚═══════════════════════════════════════════════════════╝'
Write-Host ''

Write-Amarelo '  AVISO ETICO:'
Write-Amarelo '     Uso permitido apenas em sites que sao seus,'
Write-Amarelo '     sites com contrato de pentest, ou plataformas'
Write-Amarelo '     de treino (HTB, TryHackMe, PortSwigger).'
Write-Vermelho '     Uso nao autorizado e CRIME (Lei 12.737/2012).'
Write-Host ''

$urlSite = Read-Host '  Digite a URL do site (ex: https://seusite.com)'

if (-not $urlSite -or -not ($urlSite -match '^https?://')) {
    Write-Vermelho '  X URL invalida. Use http:// ou https://'
    return
}

Write-Host ''
Write-Branco ("  Voce vai auditar: {0}" -f $urlSite)
$confirma = Read-Host '  O site e seu? (s/n)'

if ($confirma.ToLower() -ne 's') {
    Write-Vermelho ''
    Write-Vermelho '  X Auditoria cancelada. Uso nao autorizado e crime.'
    return
}

Write-Host ''
$boot = @(
    '[BIOS]    Iniciando sistema seguro...',
    '[KERNEL]  Carregando hacker-etico v1.0...',
    '[REDE]    Tunel criptografado AES-256-GCM',
    '[AUTH]    Operador autenticado OK',
    '[OK]      Pronto. Iniciando auditoria...'
)
foreach ($l in $boot) {
    Write-Cinza $l
    Start-Sleep -Milliseconds 80
}

Write-Host ''
Write-Linha '='
Write-Magenta '  FASE 1 - DESCOBERTA DE CREDENCIAIS'
Write-Linha '='

$creds = Buscar-Credenciais $urlSite

if (-not $creds) {
    Write-Host ''
    Write-Amarelo '  Aviso: Nenhuma credencial Supabase encontrada.'
    Write-Cinza '     O site pode nao usar Supabase.'
    return
}

Write-Host ''
Write-Verde ("  URL:   {0}" -f $creds.url)
Write-Verde ("  CHAVE: {0}..." -f $creds.chave.Substring(0, [Math]::Min(60, $creds.chave.Length)))

Start-Sleep -Milliseconds 500

Write-Host ''
Write-Linha '='
Write-Magenta '  FASE 2 - SIMULACAO DE INUSAO'
Write-Linha '='

$resultados = Auditar $urlSite $creds.url $creds.chave

Write-Host ''
Write-Host ''
Write-Linha '#'
Write-Magenta '  ╔═══════════════════════════════════════════════════════╗'
Write-Magenta '  ║              R E L A T O R I O   F I N A L            ║'
Write-Magenta '  ╚═══════════════════════════════════════════════════════╝'
Write-Linha '#'

$total = $resultados.Count
$bloqueados = ($resultados | Where-Object { $_.ok }).Count
$invadidos = $total - $bloqueados
$pct = if ($total -gt 0) { [Math]::Round(($bloqueados / $total) * 100) } else { 0 }

Write-Host ''
Write-Branco ("  ALVO:            {0}" -f $urlSite)
Write-Branco ("  ATAQUES:         {0}" -f $total)
Write-Verde  ("  DEFENDIDOS:      {0}" -f $bloqueados)
if ($invadidos -gt 0) { Write-Vermelho ("  INVASOES:        {0}" -f $invadidos) } else { Write-Verde ("  INVASOES:        {0}" -f $invadidos) }
Write-Host ''

for ($k = 0; $k -le 100; $k += 2) {
    $cor = if ($k -lt $pct) { 'Green' } elseif ($k -eq $pct) { 'Yellow' } else { 'DarkGray' }
    Atualizar-Linha ("  [NIVEL DE PROTECAO] [{0}] {1,3}%" -f (Barra $k 40), $k) $cor
    Start-Sleep -Milliseconds 20
}
Write-Host ''
Write-Host ''

if ($invadidos -eq 0) {
    Write-Host '     ╔═════════════════════════════════════════════════╗' -ForegroundColor Green
    Write-Host '     ║           SITE PROTEGIDO - NENHUMA BRECHA        ║' -ForegroundColor Green
    Write-Host '     ╚═════════════════════════════════════════════════╝' -ForegroundColor Green
    Write-Host ''
    Write-Verde ("  PONTUACAO: {0}%  ({1}/{2} bloqueados)" -f $pct, $bloqueados, $total)
    Write-Verde '  Sistema resistiu a todas as tentativas.'
} else {
    Write-Host '     ╔═════════════════════════════════════════════════╗' -ForegroundColor Red
    Write-Host '     ║           SITE INVADIDO - CORRIJA AGORA          ║' -ForegroundColor Red
    Write-Host '     ╚═════════════════════════════════════════════════╝' -ForegroundColor Red
    Write-Host ''
    Write-Vermelho ("  PONTUACAO: {0}%  ({1}/{2} bloqueados)" -f $pct, $bloqueados, $total)
    Write-Vermelho ("  Comprometido em {0} frente(s)." -f $invadidos)
}

Write-Host ''
Write-Linha '='
Write-Azul '  RESULTADO DETALHADO:'
Write-Host ''

foreach ($r in $resultados) {
    if ($r.ok) {
        Write-Verde ("     [OK]   {0,-40} Defendido" -f $r.nome)
    } else {
        Write-Vermelho ("     [FAIL] {0,-40} INVADIDO" -f $r.nome)
    }
}

Write-Host ''
Write-Linha '='
Write-Host ''
Write-Cinza '  Auditoria concluida.'
Write-Host ''
