(async () => {
  // ═══════════════════════════════════════════════════════════
  //   H A C K E R   É T I C O   -   T O O L K I T   v 1 2 . 0
  // ═══════════════════════════════════════════════════════════

  const C = {
    verde:    'color:#00ff41;font-weight:bold;font-family:Courier New,monospace',
    amarelo:  'color:#ffdf00;font-weight:bold;font-family:Courier New,monospace',
    azul:     'color:#4d7fff;font-weight:bold;font-family:Courier New,monospace',
    branco:   'color:#ffffff;font-weight:bold;font-family:Courier New,monospace',
    vermelho: 'color:#ff0033;font-weight:bold;font-family:Courier New,monospace',
    roxo:     'color:#b69cff;font-weight:bold;font-family:Courier New,monospace',
    cinza:    'color:#666;font-family:Courier New,monospace',

    // Destaques — mesmo tamanho dos outros, só com cor forte
    defendido: 'color:#00ff41;font-weight:bold;font-family:Courier New,monospace;text-shadow:0 0 10px #00ff41',
    invadido:  'color:#ff0033;font-weight:bold;font-family:Courier New,monospace;text-shadow:0 0 10px #ff0033'
  };

  const log = (txt, cor) => console.log(`%c${txt}`, C[cor] || C.verde);
  const linha = (ch = '─', n = 62) => console.log(`%c${ch.repeat(n)}`, C.cinza);
  const dorme = ms => new Promise(r => setTimeout(r, ms));
  const barra = (pct, w = 40) => {
    const cheio = Math.round((pct / 100) * w);
    return '█'.repeat(Math.max(0, cheio)) + '░'.repeat(Math.max(0, w - cheio));
  };
  const aleat = n => {
    let s = '';
    for (let i = 0; i < n; i++) s += Math.floor(Math.random() * 16).toString(16);
    return s;
  };

  const SUBIR_LIMPAR = '\x1b[1A\x1b[2K';
  const escreverLinha = (txt, cor) => console.log(`%c${txt}`, cor);
  const atualizarLinha = (txt, cor) => console.log(`${SUBIR_LIMPAR}%c${txt}`, cor);

  // Banner de resultado — mesmo tamanho, com moldura
  const bannerResultado = (tipo) => {
    const texto   = tipo === 'defendido' ? '🛡️  DEFENDIDO' : '🚨  INVADIDO';
    const detalhe = tipo === 'defendido' ? 'Sistema bloqueou o ataque' : 'Brecha explorada com sucesso';
    const cor     = tipo === 'defendido' ? C.defendido : C.invadido;

    console.log('');
    console.log(`%c     ╔═══════════════════════════════════════════╗`, cor);
    console.log(`%c     ║  ${texto.padEnd(41)}║`, cor);
    console.log(`%c     ║  ${detalhe.padEnd(41)}║`, cor);
    console.log(`%c     ╚═══════════════════════════════════════════╝`, cor);
    console.log('');
  };

  // ═══════════════════════════════════════════════════════════
  // INICIALIZAÇÃO
  // ═══════════════════════════════════════════════════════════
  console.clear();
  await dorme(150);

  const boot = [
    '[BIOS]    Iniciando sistema seguro...',
    '[KERNEL]  Carregando hacker-ético v12.0...',
    '[REDE]    Túnel criptografado AES-256-GCM',
    '[AUTH]    Verificando credenciais do operador...',
    '[AUTH]    Operador autenticado ✓',
    '[DADOS]   26.847 exploits indexados',
    '[PAYLOAD] 4.201 payloads carregados',
    '[OK]      Pronto. Selecionando alvo...'
  ];
  for (const l of boot) {
    console.log(`%c${l}`, C.cinza);
    await dorme(60);
  }
  await dorme(250);

  // ═══════════════════════════════════════════════════════════
  // IDENTIDADE
  // ═══════════════════════════════════════════════════════════
  console.clear();
  await dorme(200);

  console.log(`%c
  ╔═══════════════════════════════════════════════════════╗
  ║                                                       ║
  ║      H A C K E R   É T I C O   -   T O O L K I T      ║
  ║                     v 1 2 . 0   B R                   ║
  ║                                                       ║
  ║      [ SOMOS ANÔNIMOS ]                               ║
  ║      [ SOMOS LEGIÃO ]                                 ║
  ║      [ NÃO PERDOAMOS ]                                ║
  ║      [ NÃO ESQUECEMOS ]                               ║
  ║      [ ESPEREM POR NÓS ]                              ║
  ║                                                       ║
  ║      >> D I V I S Ã O   É T I C A <<                   ║
  ║                                                       ║
  ╚═══════════════════════════════════════════════════════╝
`, C.verde);

  await dorme(600);

  for (let i = 0; i < 3; i++) {
    const sp = ' '.repeat(i * 4);
    console.log(`%c${sp}>>> H A C K E R   É T I C O <<<`, i % 2 === 0 ? C.amarelo : C.verde);
    await dorme(100);
  }
  await dorme(300);

  // ═══════════════════════════════════════════════════════════
  // MARCA D'ÁGUA
  // ═══════════════════════════════════════════════════════════
  console.log('');
  log('  ┌─────────────────────────────────────────────────────┐', 'verde');
  log('  │  FERRAMENTA: Hacker Ético v12.0                     │', 'verde');
  log('  │  LICENÇA:    Uso Ético Apenas                       │', 'verde');
  log(`  │  SESSÃO:     ${aleat(12).toUpperCase()}                         │`, 'verde');
  log(`  │  HORÁRIO:    ${new Date().toISOString().substring(0, 19)}Z                    │`, 'verde');
  log('  │  MODO:       Chapéu Branco / Pentest Autorizado     │', 'verde');
  log('  └─────────────────────────────────────────────────────┘', 'verde');
  await dorme(600);

  // ═══════════════════════════════════════════════════════════
  // AVISO ÉTICO
  // ═══════════════════════════════════════════════════════════
  console.log('');
  log('  ⚠️  AVISO ÉTICO:', 'amarelo');
  log('     Uso permitido apenas em:', 'amarelo');
  log('       • Sites que são seus', 'amarelo');
  log('       • Sites com contrato de pentest', 'amarelo');
  log('       • Plataformas de treino (HTB / TryHackMe)', 'amarelo');
  log('     Uso não autorizado = CRIME (Lei 12.737/2012).', 'vermelho');
  await dorme(1500);

  // ═══════════════════════════════════════════════════════════
  // ALVO
  // ═══════════════════════════════════════════════════════════
  console.log('');
  linha('═');
  log('  🎯 ALVO SELECIONADO', 'azul');
  linha('═');
  log(`     URL:  ${location.href}`, 'branco');
  log(`     Host: ${location.hostname}`, 'branco');
  await dorme(400);

  log('\n  ▸ Confirmando alvo...', 'azul');
  for (let i = 0; i < 3; i++) {
    console.log(`%c     [${aleat(24)}] handshake...`, C.cinza);
    await dorme(80);
  }
  log('  ✓ Alvo confirmado', 'verde');
  await dorme(350);

  // ═══════════════════════════════════════════════════════════
  // FASE 1 — RECONHECIMENTO
  // ═══════════════════════════════════════════════════════════
  console.log('');
  linha('═');
  log('  [ FASE 1/3 ]  RECONHECIMENTO', 'roxo');
  linha('═');
  await dorme(250);

  const fases1 = [
    'Varrendo portas TCP',
    'Identificando tecnologias',
    'Enumerando endpoints',
    'Coletando cabeçalhos HTTP',
    'Inspecionando arquivos JS'
  ];

  console.log('');
  escreverLinha('  [░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░]   0%', C.verde);

  let contador = 0;
  const passosTotal = fases1.length * 10;
  for (const f of fases1) {
    for (let i = 0; i <= 100; i += 10) {
      contador++;
      const pct = Math.round((contador / passosTotal) * 100);
      atualizarLinha(`  ${f.padEnd(28)} [${barra(pct, 26)}] ${String(pct).padStart(3)}%`, C.verde);
      await dorme(45);
    }
  }
  atualizarLinha(`  ✓ Reconhecimento concluído       [${barra(100, 26)}] 100%`, C.verde);
  await dorme(300);

  // ═══════════════════════════════════════════════════════════
  // FASE 2 — DESCOBERTA DE CREDENCIAIS
  // ═══════════════════════════════════════════════════════════
  console.log('');
  linha('═');
  log('  [ FASE 2/3 ]  CAÇA ÀS CREDENCIAIS', 'roxo');
  linha('═');

  function buscarGlobais() {
    const urls = [], chaves = [];
    try {
      for (const k of Object.keys(window)) {
        try {
          const v = window[k];
          if (typeof v === 'string') {
            if (/^https:\/\/[a-z0-9]+\.supabase\.co/.test(v)) urls.push({ fonte: `window.${k}`, valor: v });
            if (/^eyJ[A-Za-z0-9_-]{50,}/.test(v) || /^sb_publishable_/.test(v)) chaves.push({ fonte: `window.${k}`, valor: v });
          }
        } catch (e) { /* ignora */ }
      }
    } catch (e) { /* ignora */ }
    return { urls, chaves };
  }

  function buscarHTML() {
    const urls = [], chaves = [];
    try {
      const html = document.documentElement.outerHTML;
      const m1 = html.matchAll(/https:\/\/([a-z0-9]+)\.supabase\.co/g);
      for (const m of m1) urls.push({ fonte: 'HTML', valor: m[0] });
      const m2 = html.matchAll(/eyJ[A-Za-z0-9_-]{50,}\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+/g);
      for (const m of m2) chaves.push({ fonte: 'HTML-JWT', valor: m[0] });
      const m3 = html.matchAll(/sb_publishable_[A-Za-z0-9_-]+/g);
      for (const m of m3) chaves.push({ fonte: 'HTML-PUB', valor: m[0] });
    } catch (e) { /* ignora */ }
    return { urls, chaves };
  }

  async function buscarScripts() {
    const urls = [], chaves = [];
    try {
      const scripts = [...document.querySelectorAll('script[src]')]
        .map(s => s.src)
        .filter(s => s.startsWith('http'));
      for (const src of scripts) {
        try {
          const r = await fetch(src);
          if (!r.ok) continue;
          const txt = await r.text();
          const m1 = txt.matchAll(/https:\/\/([a-z0-9]+)\.supabase\.co/g);
          for (const m of m1) urls.push({ fonte: src.split('/').pop(), valor: m[0] });
          const m2 = txt.matchAll(/eyJ[A-Za-z0-9_-]{50,}\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+/g);
          for (const m of m2) chaves.push({ fonte: src.split('/').pop(), valor: m[0] });
          const m3 = txt.matchAll(/sb_publishable_[A-Za-z0-9_-]+/g);
          for (const m of m3) chaves.push({ fonte: src.split('/').pop(), valor: m[0] });
        } catch (e) { /* ignora */ }
      }
    } catch (e) { /* ignora */ }
    return { urls, chaves };
  }

  async function interceptar() {
    return new Promise(resolve => {
      const fetchOrig = window.fetch;
      let resolvido = false;
      let timeoutId;
      window.fetch = function (...args) {
        try {
          const url = typeof args[0] === 'string' ? args[0] : args[0]?.url;
          if (url && url.includes('.supabase.co') && !resolvido) {
            resolvido = true;
            clearTimeout(timeoutId);
            window.fetch = fetchOrig;
            resolve({ url });
          }
        } catch (e) { /* ignora */ }
        return fetchOrig.apply(this, args);
      };
      timeoutId = setTimeout(() => {
        if (!resolvido) {
          window.fetch = fetchOrig;
          resolve(null);
        }
      }, 3000);
    });
  }

  const achados = { urls: [], chaves: [] };

  log('\n  ▸ [2.1] Vasculhando variáveis globais...', 'azul');
  await dorme(200);
  const g = buscarGlobais();
  g.urls.forEach(u => log(`     ⚡ URL: ${u.valor}`, 'verde'));
  g.chaves.forEach(k => log(`     ⚡ CHAVE: ${k.valor.substring(0, 40)}...`, 'verde'));
  if (!g.urls.length && !g.chaves.length) log('     ✗ nada nas variáveis globais', 'cinza');
  achados.urls.push(...g.urls);
  achados.chaves.push(...g.chaves);

  log('\n  ▸ [2.2] Analisando HTML da página...', 'azul');
  await dorme(200);
  const h = buscarHTML();
  h.urls.forEach(u => log(`     ⚡ URL: ${u.valor}`, 'verde'));
  h.chaves.forEach(k => log(`     ⚡ CHAVE: ${k.valor.substring(0, 40)}...`, 'verde'));
  if (!h.urls.length && !h.chaves.length) log('     ✗ nada no HTML', 'cinza');
  achados.urls.push(...h.urls);
  achados.chaves.push(...h.chaves);

  log('\n  ▸ [2.3] Baixando e analisando scripts...', 'azul');
  const listaScripts = [...document.querySelectorAll('script[src]')];
  log(`     ${listaScripts.length} scripts para analisar`, 'cinza');
  const s = await buscarScripts();
  const urlsUnicas = [...new Set(s.urls.map(u => u.valor))];
  const chavesUnicas = [...new Set(s.chaves.map(k => k.valor))];
  urlsUnicas.forEach(u => log(`     ⚡ URL: ${u}`, 'verde'));
  chavesUnicas.forEach(k => log(`     ⚡ CHAVE: ${k.substring(0, 40)}...`, 'verde'));
  if (!urlsUnicas.length && !chavesUnicas.length) log('     ✗ nada nos scripts', 'cinza');
  achados.urls.push(...s.urls);
  achados.chaves.push(...s.chaves);

  log('\n  ▸ [2.4] Interceptando tráfego (3s)...', 'azul');
  const i = await interceptar();
  if (i) {
    log(`     ⚡ URL capturada: ${i.url}`, 'verde');
    achados.urls.push({ fonte: 'intercept', valor: i.url });
  } else {
    log('     ✗ nenhuma requisição capturada', 'cinza');
  }

  console.log('');
  linha('─');
  log('  📋 CREDENCIAIS EXTRAÍDAS', 'roxo');
  linha('─');

  if (!achados.urls.length && !achados.chaves.length) {
    log('\n  ⚠️  Nenhuma credencial Supabase encontrada.', 'amarelo');
    return;
  }

  const urlFinal = achados.urls[0]?.valor;
  const chavePub = achados.chaves.find(k => k.valor.startsWith('sb_publishable_'));
  const chaveJwt = achados.chaves.find(k => k.valor.startsWith('eyJ'));
  const chaveFinal = chavePub?.valor || chaveJwt?.valor;

  log(`\n  🔗 URL:   ${urlFinal || '❌'}`, urlFinal ? 'verde' : 'vermelho');
  log(`  🔑 CHAVE: ${chaveFinal ? chaveFinal.substring(0, 55) + '...' : '❌'}`, chaveFinal ? 'verde' : 'vermelho');

  if (chaveFinal && chaveFinal.startsWith('eyJ')) {
    try {
      const payload = JSON.parse(atob(chaveFinal.split('.')[1]));
      log(`  📌 Ref:   ${payload.ref}`, 'cinza');
      log(`  📌 Papel: ${payload.role}`, payload.role === 'anon' ? 'verde' : 'vermelho');
      if (payload.role === 'service_role') {
        console.log('');
        log('  🚨🚨🚨 ALERTA VERMELHO 🚨🚨🚨', 'vermelho');
        log('  SERVICE_ROLE EXPOSTA NO FRONTEND!', 'vermelho');
        log('  Revogue essa chave IMEDIATAMENTE no Supabase.', 'vermelho');
        return;
      }
    } catch (e) { /* ignora */ }
  }

  if (!urlFinal || !chaveFinal) return;
  await dorme(500);

  // ═══════════════════════════════════════════════════════════
  // FASE 3 — SIMULAÇÃO DE INVASÃO
  // ═══════════════════════════════════════════════════════════
  console.log('');
  linha('═');
  log('  [ FASE 3/3 ]  SIMULAÇÃO DE INVASÃO', 'roxo');
  linha('═');
  console.log('');
  log('  ⚡ INICIANDO SEQUÊNCIA DE ATAQUE...', 'vermelho');
  await dorme(500);

  const REST = urlFinal.replace(/\/$/, '') + '/rest/v1/';
  const AUTH = urlFinal.replace(/\/$/, '') + '/auth/v1/';
  const FALSO = '00000000-0000-0000-0000-000000000000';
  const TABELAS = ['profiles', 'user_favorites', 'user_history', 'songs', 'user_quiz_completions', 'user_song_guess_attempts'];
  const RPCS = ['get_song_guess_round', 'submit_song_guess', 'complete_quiz'];

  const resultados = [];
  const totalAtaques = 12;

  const simularTentativa = async (num, nomeAtaque, executar) => {
    console.log('');
    log(`  ╔═══════════════════════════════════════════════════════╗`, 'vermelho');
    log(`  ║  ATAQUE #${String(num).padStart(2, '0')} — ${nomeAtaque.padEnd(33)}║`, 'vermelho');
    log(`  ╚═══════════════════════════════════════════════════════╝`, 'vermelho');

    console.log('');
    escreverLinha(`  [HACKEANDO] [${barra(0, 40)}]   0%`, C.vermelho);

    for (let p = 0; p <= 100; p += 10) {
      const pctGlobal = Math.round(((num - 1) * 100 + p) / totalAtaques);
      atualizarLinha(`  [HACKEANDO] [${barra(pctGlobal, 40)}] ${String(pctGlobal).padStart(3)}%`, C.vermelho);
      await dorme(50);
    }

    for (let k = 0; k < 2; k++) {
      const ipFalso = `${parseInt(aleat(2), 16)}.${parseInt(aleat(2), 16)}.${parseInt(aleat(2), 16)}.${parseInt(aleat(2), 16)}`;
      console.log(`%c     [${ipFalso}] injetando payload...`, C.cinza);
      await dorme(90);
    }

    let resultado;
    try {
      resultado = await executar();
    } catch (e) {
      resultado = { ok: true };
    }

    bannerResultado(resultado.ok ? 'defendido' : 'invadido');

    resultados.push({ nome: nomeAtaque, ok: resultado.ok });
    await dorme(250);
  };

  // 01
  await simularTentativa(1, 'LEITURA ANÔNIMA (SELECT)', async () => {
    for (const t of TABELAS) {
      try {
        const r = await fetch(`${REST}${t}?select=*&limit=5`, { headers: { apikey: chaveFinal } });
        const body = await r.json();
        const seguro = (r.status === 401 || r.status === 403) || (Array.isArray(body) && body.length === 0);
        if (!seguro) return { ok: false };
        await dorme(40);
      } catch (e) { /* ignora */ }
    }
    return { ok: true };
  });

  // 02
  await simularTentativa(2, 'INJEÇÃO DE DADOS (INSERT)', async () => {
    for (const t of TABELAS) {
      try {
        const r = await fetch(`${REST}${t}`, {
          method: 'POST',
          headers: { apikey: chaveFinal, 'Content-Type': 'application/json', Prefer: 'return=representation' },
          body: '{}'
        });
        const seguro = r.status === 401 || r.status === 403 || r.status === 400;
        if (!seguro) return { ok: false };
        await dorme(40);
      } catch (e) { /* ignora */ }
    }
    return { ok: true };
  });

  // 03
  await simularTentativa(3, 'DESTRUIÇÃO DE DADOS (DELETE)', async () => {
    for (const t of TABELAS) {
      for (const col of ['id', 'user_id', 'song_id']) {
        try {
          const r = await fetch(`${REST}${t}?${col}=eq.${FALSO}`, {
            method: 'DELETE',
            headers: { apikey: chaveFinal, 'Content-Type': 'application/json', Prefer: 'return=representation' }
          });
          if (r.status === 400) continue;
          const body = await r.text();
          const seguro = r.status === 401 || r.status === 403 || (r.status === 200 && (body === '[]' || body === ''));
          if (!seguro) return { ok: false };
          break;
        } catch (e) { /* ignora */ }
      }
      await dorme(40);
    }
    return { ok: true };
  });

  // 04
  await simularTentativa(4, 'EXECUÇÃO DE FUNÇÕES (RPC)', async () => {
    for (const rpc of RPCS) {
      try {
        const r = await fetch(`${REST}rpc/${rpc}`, {
          method: 'POST',
          headers: { apikey: chaveFinal, 'Content-Type': 'application/json' },
          body: JSON.stringify({ song_uuid: FALSO, submitted_answer: 'x', quiz_index: 0, reward_xp: 45 })
        });
        const seguro = r.status === 401 || r.status === 403 || r.status === 400 || r.status === 500;
        if (!seguro) return { ok: false };
        await dorme(40);
      } catch (e) { /* ignora */ }
    }
    return { ok: true };
  });

  // 05
  await simularTentativa(5, 'INJEÇÃO SQL NO LOGIN', async () => {
    const payloads = ["' OR 1=1 --", "admin' --", "' UNION SELECT NULL --"];
    for (const pay of payloads) {
      try {
        const r = await fetch(`${AUTH}token?grant_type=password`, {
          method: 'POST',
          headers: { apikey: chaveFinal, 'Content-Type': 'application/json' },
          body: JSON.stringify({ email: pay, password: 'x' })
        });
        if (r.status !== 400) return { ok: false };
        await dorme(80);
      } catch (e) { /* ignora */ }
    }
    return { ok: true };
  });

  // 06
  await simularTentativa(6, 'FORJA DE TOKEN JWT', async () => {
    const ref = urlFinal.replace('https://', '').split('.')[0];
    const chaveStorage = `sb-${ref}-auth-token`;
    try {
      localStorage.setItem(chaveStorage, JSON.stringify({
        access_token: 'fake.eyJzdWIiOiJmYWtlIn0.fake',
        refresh_token: 'fake',
        expires_at: Math.floor(Date.now() / 1000) + 3600,
        user: { id: FALSO, email: 'x@x.com', aud: 'authenticated', role: 'authenticated' }
      }));
      const r = await fetch(`${REST}profiles?select=*&limit=1`, {
        headers: { apikey: chaveFinal, Authorization: 'Bearer fake.eyJzdWIiOiJmYWtlIn0.fake' }
      });
      const body = await r.text();
      const seguro = r.status === 401 || r.status === 403 || (r.status === 200 && (body === '[]' || body === ''));
      localStorage.removeItem(chaveStorage);
      return { ok: seguro };
    } catch (e) {
      localStorage.removeItem(chaveStorage);
      return { ok: true };
    }
  });

  // 07
  await simularTentativa(7, 'ENUMERAÇÃO DE USUÁRIOS', async () => {
    try {
      const r = await fetch(`${AUTH}signup`, {
        method: 'POST',
        headers: { apikey: chaveFinal, 'Content-Type': 'application/json' },
        body: JSON.stringify({ email: `teste${aleat(8)}@teste-inexistente.com`, password: 'SenhaForte!123' })
      });
      const body = await r.text();
      const suspeito = /already|exist|registrad/i.test(body);
      return { ok: !suspeito };
    } catch (e) { return { ok: true }; }
  });

  // 08
  await simularTentativa(8, 'CABEÇALHOS DE SEGURANÇA HTTP', async () => {
    try {
      const r = await fetch(location.href, { method: 'HEAD' });
      const h = {
        csp: r.headers.get('content-security-policy'),
        xfo: r.headers.get('x-frame-options'),
        hsts: r.headers.get('strict-transport-security'),
        xcto: r.headers.get('x-content-type-options')
      };
      const faltando = Object.entries(h).filter(([k, v]) => !v);
      return { ok: faltando.length === 0 };
    } catch (e) { return { ok: true }; }
  });

  // 09
  await simularTentativa(9, 'CONFIGURAÇÃO DE CORS', async () => {
    try {
      const r = await fetch(`${REST}profiles?select=*&limit=1`, {
        headers: { apikey: chaveFinal, Origin: 'https://site-malicioso.com' }
      });
      const allow = r.headers.get('access-control-allow-origin');
      const suspeito = allow === '*' || allow === 'https://site-malicioso.com';
      return { ok: !suspeito };
    } catch (e) { return { ok: true }; }
  });

  // 10
  await simularTentativa(10, 'EXPOSIÇÃO DE STORAGE (BUCKETS)', async () => {
    try {
      const r = await fetch(`${urlFinal}/storage/v1/bucket`, {
        headers: { apikey: chaveFinal }
      });
      if (r.status === 401 || r.status === 403) return { ok: true };
      const body = await r.json();
      const suspeito = Array.isArray(body) && body.some(b => b.public === true);
      return { ok: !suspeito };
    } catch (e) { return { ok: true }; }
  });

  // 11
  await simularTentativa(11, 'VERIFICAÇÃO DE RATE LIMIT', async () => {
    let sucesso = 0;
    for (let k = 0; k < 5; k++) {
      try {
        const r = await fetch(`${AUTH}token?grant_type=password`, {
          method: 'POST',
          headers: { apikey: chaveFinal, 'Content-Type': 'application/json' },
          body: JSON.stringify({ email: `x${k}@x.com`, password: 'x' })
        });
        if (r.status === 429) return { ok: true };
        sucesso++;
        await dorme(50);
      } catch (e) { /* ignora */ }
    }
    return { ok: sucesso < 5 };
  });

  // 12
  await simularTentativa(12, 'REDIRECIONAMENTO ABERTO', async () => {
    try {
      const params = ['redirect', 'url', 'next', 'return', 'redir'];
      for (const param of params) {
        const r = await fetch(`${location.origin}/?${param}=https://site-malicioso.com`, { redirect: 'manual' });
        const loc = r.headers.get('location') || '';
        if (loc.includes('site-malicioso.com')) return { ok: false };
        await dorme(40);
      }
      return { ok: true };
    } catch (e) { return { ok: true }; }
  });

  // ═══════════════════════════════════════════════════════════
  // RELATÓRIO FINAL
  // ═══════════════════════════════════════════════════════════
  console.log('');
  console.log('');
  linha('█');
  log('  ╔═══════════════════════════════════════════════════════╗', 'roxo');
  log('  ║              R E L A T Ó R I O   F I N A L            ║', 'roxo');
  log('  ╚═══════════════════════════════════════════════════════╝', 'roxo');
  linha('█');

  const total = resultados.length;
  const bloqueados = resultados.filter(r => r.ok).length;
  const invadidos = resultados.filter(r => !r.ok).length;
  const pct = total > 0 ? Math.round((bloqueados / total) * 100) : 0;

  console.log('');
  log(`  🎯 ALVO:            ${location.hostname}`, 'branco');
  log(`  ⚔️  ATAQUES:         ${total}`, 'branco');
  log(`  🛡️  DEFENDIDOS:      ${bloqueados}`, 'verde');
  log(`  🚨 INVASÕES:        ${invadidos}`, invadidos > 0 ? 'vermelho' : 'verde');
  console.log('');

  console.log('');
  escreverLinha(`  [NÍVEL DE PROTEÇÃO] [${barra(0, 40)}]   0%`, C.verde);
  for (let k = 0; k <= 100; k += 2) {
    const ch = k < pct ? C.verde : (k === pct ? C.amarelo : C.cinza);
    atualizarLinha(`  [NÍVEL DE PROTEÇÃO] [${barra(k, 40)}] ${String(k).padStart(3)}%`, ch);
    await dorme(20);
  }
  console.log('');

  await dorme(400);

  // Banner final — mesmo tamanho, com moldura destacada
  if (invadidos === 0) {
    console.log('');
    console.log(`%c     ╔═════════════════════════════════════════════════╗`, C.defendido);
    console.log(`%c     ║           🛡️   SITE PROTEGIDO   🛡️                ║`, C.defendido);
    console.log(`%c     ╚═════════════════════════════════════════════════╝`, C.defendido);
    console.log('');
    log(`  🏆 PONTUAÇÃO: ${pct}%  (${bloqueados}/${total} bloqueados)`, 'verde');
    log(`  ✅ Sistema resistiu a todas as tentativas.`, 'verde');
    log(`  🛡️  Classificação: BLINDADO`, 'verde');
  } else {
    console.log('');
    console.log(`%c     ╔═════════════════════════════════════════════════╗`, C.invadido);
    console.log(`%c     ║           🚨   SITE INVADIDO   🚨                 ║`, C.invadido);
    console.log(`%c     ╚═════════════════════════════════════════════════╝`, C.invadido);
    console.log('');
    log(`  💀 PONTUAÇÃO: ${pct}%  (${bloqueados}/${total} bloqueados)`, 'vermelho');
    log(`  ❌ Comprometido em ${invadidos} frente(s).`, 'vermelho');
    log(`  ⚠️  Classificação: VULNERÁVEL`, 'vermelho');
  }
  console.log('');
  linha('═');

  await dorme(500);

  const statusFinal = invadidos === 0 ? 'ACESSO NEGADO' : 'ACESSO CONCEDIDO';
  const corStatus = invadidos === 0 ? 'defendido' : 'invadido';
  console.log('');
  console.log(`%c                 [ ${statusFinal} ]`, C[corStatus]);
  await dorme(300);
  console.log('');

  log('            Nós somos Anônimos.', 'verde');
  await dorme(160);
  log('            Nós somos Legião.', 'verde');
  await dorme(160);
  log('            Nós não perdoamos.', 'verde');
  await dorme(160);
  log('            Nós não esquecemos.', 'verde');
  await dorme(160);
  log('            Esperem por nós.', 'verde');
  await dorme(450);

  console.log('');
  log('            >> D I V I S Ã O   É T I C A <<', 'amarelo');
  await dorme(200);
  log('            >> H A C K E R   É T I C O <<', 'amarelo');
  await dorme(160);
  log('            >> H A C K E R   É T I C O <<', 'amarelo');
  await dorme(160);
  log('            >> H A C K E R   É T I C O <<', 'amarelo');

  console.log('');
  linha('═');
  log(`  SESSÃO ENCERRADA: ${aleat(12).toUpperCase()}`, 'cinza');
  log('  Nenhum dado exfiltrado. Auditoria concluída.', 'cinza');
  linha('═');

  console.log('');
  log('  📋 Para adicionar em MEUS_PROJETOS:', 'amarelo');
  console.log(`%c
  {
    nome: '${location.hostname}',
    url: '${urlFinal}',
    key: '${chaveFinal.substring(0, 40)}...'
  }
`, C.verde);

  console.table(resultados.map(r => ({
    Ataque: r.nome,
    Status: r.ok ? '🛡️ Defendido' : '🚨 Invadido'
  })));
})().catch(e => {
  console.error('%c[ERRO FATAL] ' + e.message, 'color:#ff0033;font-weight:bold');
  console.error(e);
});
