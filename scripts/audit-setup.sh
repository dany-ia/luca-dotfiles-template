#!/bin/bash
# audit-setup.sh
# Diagnóstico rápido de tu setup actual antes de empezar Fase 1
# Te dice dónde estás y dónde te falta llegar

echo "=================================================="
echo "  Audit de tu setup - luca-dotfiles"
echo "=================================================="
echo ""

# ============================================
# Check 1: Homebrew
# ============================================
echo "1. Homebrew"
if command -v brew &> /dev/null; then
  echo "   ✅ Instalado: $(brew --version | head -1)"
  echo "   📦 Paquetes: $(brew list --formula | wc -l | tr -d ' ') fórmulas"
else
  echo "   ❌ No instalado. Fase 1 te lo pedirá primero."
fi
echo ""

# ============================================
# Check 2: Shell
# ============================================
echo "2. Shell"
echo "   Shell actual: $SHELL"
if [[ "$SHELL" == *"zsh"* ]]; then
  echo "   ✅ zsh activo"
else
  echo "   ⚠️  No estás en zsh. Cambia con: chsh -s /bin/zsh"
fi

if [ -f ~/.zshrc ]; then
  LINES=$(wc -l < ~/.zshrc | tr -d ' ')
  if [ -L ~/.zshrc ]; then
    echo "   ✅ ~/.zshrc es symlink (versionado): $(readlink ~/.zshrc)"
  else
    echo "   ⚠️  ~/.zshrc es archivo plano ($LINES líneas). Fase 1 lo migrará a symlink."
  fi
else
  echo "   ❌ No tienes ~/.zshrc"
fi
echo ""

# ============================================
# Check 3: Git y GitHub
# ============================================
echo "3. Git y GitHub"
if command -v git &> /dev/null; then
  echo "   ✅ Git: $(git --version)"
  GITNAME=$(git config --global user.name)
  GITEMAIL=$(git config --global user.email)
  if [ -n "$GITNAME" ] && [ -n "$GITEMAIL" ]; then
    echo "   ✅ Configurado: $GITNAME <$GITEMAIL>"
  else
    echo "   ⚠️  Git no tiene identidad. Configura con git config --global."
  fi
else
  echo "   ❌ Git no instalado"
fi

if command -v gh &> /dev/null; then
  echo "   ✅ GitHub CLI: $(gh --version | head -1)"
  if gh auth status &> /dev/null; then
    GHUSER=$(gh api user --jq .login 2>/dev/null)
    echo "   ✅ Autenticado como: $GHUSER"
  else
    echo "   ⚠️  No autenticado. Corre: gh auth login"
  fi
else
  echo "   ❌ GitHub CLI no instalado"
fi
echo ""

# ============================================
# Check 4: Python
# ============================================
echo "4. Python"
if command -v python3 &> /dev/null; then
  PYPATH=$(which python3)
  PYVER=$(python3 --version)
  echo "   ✅ $PYVER"
  echo "   📍 Path: $PYPATH"
  if [[ "$PYPATH" == *"opt/homebrew"* ]]; then
    echo "   ✅ Python vía Homebrew (recomendado)"
  elif [[ "$PYPATH" == *"anaconda"* ]] || [[ "$PYPATH" == *"miniconda"* ]]; then
    echo "   ⚠️  Python vía Anaconda/Miniconda. Funciona pero genera conflictos. Considera migrar."
  fi
else
  echo "   ❌ Python3 no encontrado"
fi
echo ""

# ============================================
# Check 5: Power tools
# ============================================
echo "5. Power tools"
TOOLS=(starship atuin fzf zoxide bat eza)
for tool in "${TOOLS[@]}"; do
  if command -v $tool &> /dev/null; then
    echo "   ✅ $tool"
  else
    echo "   ❌ $tool (Fase 1 lo instala)"
  fi
done
echo ""

# ============================================
# Check 6: BI Stack
# ============================================
echo "6. Stack BI"
BISTACK=(R psql jupyter)
for tool in "${BISTACK[@]}"; do
  if command -v $tool &> /dev/null; then
    echo "   ✅ $tool"
  else
    echo "   ❌ $tool (Fase 2 lo instala)"
  fi
done
echo ""

# ============================================
# Check 7: Folder structure
# ============================================
echo "7. Estructura de proyectos"
if [ -d ~/Projects ]; then
  COUNT=$(ls -1 ~/Projects 2>/dev/null | wc -l | tr -d ' ')
  echo "   ✅ ~/Projects existe ($COUNT items)"
  if [ -d ~/Projects/luca-dotfiles ]; then
    echo "   ✅ luca-dotfiles existe"
  else
    echo "   ❌ luca-dotfiles no existe (Fase 1 lo crea)"
  fi
else
  echo "   ❌ ~/Projects no existe"
fi
echo ""

# ============================================
# Check 8: iTerm2
# ============================================
echo "8. Terminal"
if [ -d "/Applications/iTerm.app" ]; then
  echo "   ✅ iTerm2 instalado"
  ITERMFOLDER=$(defaults read com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null)
  if [ -n "$ITERMFOLDER" ]; then
    echo "   ✅ iTerm2 prefs versionados en: $ITERMFOLDER"
  else
    echo "   ⚠️  iTerm2 sin custom folder (sin versionar)"
  fi
else
  echo "   ❌ iTerm2 no instalado (Fase 1 lo instala)"
fi
echo ""

# ============================================
# Resumen
# ============================================
echo "=================================================="
echo "  Resumen"
echo "=================================================="

# Contar checks
TOTAL_BASIC=10
PASSED=0

command -v brew &> /dev/null && ((PASSED++))
[[ "$SHELL" == *"zsh"* ]] && ((PASSED++))
command -v git &> /dev/null && ((PASSED++))
command -v gh &> /dev/null && ((PASSED++))
command -v python3 &> /dev/null && ((PASSED++))
command -v starship &> /dev/null && ((PASSED++))
command -v atuin &> /dev/null && ((PASSED++))
[ -d ~/Projects ] && ((PASSED++))
[ -d "/Applications/iTerm.app" ] && ((PASSED++))
gh auth status &> /dev/null && ((PASSED++))

echo ""
echo "Setup actual: $PASSED/$TOTAL_BASIC checks"

if [ $PASSED -lt 4 ]; then
  echo "📍 Punto de partida típico. Fase 1 te toma 2 a 3 hrs."
elif [ $PASSED -lt 7 ]; then
  echo "📍 Setup intermedio. Fase 1 te toma 1 a 2 hrs (saltas pasos básicos)."
elif [ $PASSED -lt 10 ]; then
  echo "📍 Setup avanzado. Fase 1 será principalmente personalización estética."
else
  echo "🎯 Setup ya sólido. Probablemente puedes saltar Fase 1 a Fase 2 directo."
fi

echo ""
echo "Siguiente: leer docs/FASE_1_PROFESIONALIZAR.md"
echo ""
