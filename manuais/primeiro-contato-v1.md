# WMK Pesquisa IA — V1.0 nativa Windows (sem Docker)

Projeto derivado de **Vane**, licenciado sob MIT. Autor das adaptações WMK: **Walney Moreira Klein — walneyk@hotmail.com**.

## Objetivo desta etapa
Preservar os recursos e a arquitetura originais. Esta versão introduz metadados WMK/pt-BR, inicializador Windows e proteção contra perda silenciosa de configurações JSON inválidas. **A interface inteira ainda não está traduzida**, e a V1.0 deve ser validada em um Windows real.

## Requisitos
- Windows 10/11 com Node.js compatível com Next.js 16 (recomenda-se Node.js 22 LTS ou posterior) e npm.
- Opcional: Ollama instalado e executando na porta 11434.
- Para pesquisa web: SearXNG instalado separadamente, com resposta JSON habilitada. **Ollama não substitui SearXNG**; sem SearXNG as pesquisas web não estarão operacionais.
- A primeira instalação do npm necessita internet.

## Como iniciar
No PowerShell, na pasta do projeto:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\iniciar-windows.ps1 -Install
```

Depois, para rodar novamente:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\iniciar-windows.ps1
```

Abra http://localhost:3000 e complete o assistente de configuração. Para preparar a compilação de produção:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\iniciar-windows.ps1 -Mode production
```

O comando de produção recompila o aplicativo antes de iniciar.

## Configurar pesquisa web sem Docker

O Vane necessita uma instância SearXNG existente (local ou remota). Instale-a e configure-a pelos métodos oficiais para seu ambiente (por exemplo, um serviço Linux/WSL nativo, sem Docker), permitindo `format=json` nas preferências de saída. Um SearXNG hospedado por terceiros pode processar suas consultas: escolha um serviço confiável.

Defina `SEARXNG_API_URL` no PowerShell ANTES de iniciar ou informe a URL na tela inicial, por exemplo:

```powershell
$env:SEARXNG_API_URL = 'http://127.0.0.1:8080'
powershell -ExecutionPolicy Bypass -File .\scripts\iniciar-windows.ps1
```

**Atenção:** a URL acima é ilustrativa. O SearXNG deve estar realmente ativo nela. Faça a verificação `http://127.0.0.1:8080/search?q=teste&format=json` e confirme que retorna JSON.

## Configuração Ollama
Inicie Ollama e valide `http://127.0.0.1:11434/api/tags`. No assistente do Vane, adicione Ollama, selecione modelos instalados e configure um modelo de chat. Nem todos os modelos suportam todas as funcionalidades.

## Dados e recuperação
O arquivo de configuração fica em `data/config.json`. Se um JSON inválido for detectado, esta branch cria `data/config.json.invalid-<timestamp>.bak` antes de restaurar configurações iniciais. Mantenha backup também do banco SQLite e dos documentos em `data/`.

## Critérios de aceite (a validar)
- npm install e npm run build executados com sucesso no Windows
- assistente de configuração abre em http://localhost:3000
- Ollama configurado responde a um teste de chat
- SearXNG configurado retorna resultados com fontes
- reiniciar não apaga histórico e preferências
- arquivo de configuração inválido gera backup sem perda do original
- funcionalidades existentes do Vane não sofreram regressões

## Segurança
Não publique portas, configuração ou API diretamente na internet enquanto não houver autenticação robusta. O README original ainda lista autenticação como recurso futuro. Proteja chaves de API e arquivos da pasta data.

## Próximas etapas
Auditoria completa de fluxo de chat, upload e RAG; suíte de testes; branding visual completo, i18n pt-BR e diagnóstico de provedores, sem eliminar as capacidades do Vane.
