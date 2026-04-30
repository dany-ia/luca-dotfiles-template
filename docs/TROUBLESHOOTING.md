# Troubleshooting

Errores comunes a lo largo del manual y soluciones rápidas.

Asume que ya sabes leer mensajes de error y debuggear básicamente. Aquí van
los fixes específicos a este setup.

---

## Fase 1

### "command not found: brew" después de instalar Homebrew

```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
source ~/.zshrc
```

---

### iTerm2 no permite abrir (developer no identificado)

Click derecho en iTerm2 en Applications → Open. Te pregunta si confías, sí.

---

### El tema Tokyo Night no aparece en Color Presets

Verificar que se descargó:

```bash
ls -la ~/Downloads/Tokyo*
```

Si no, repetir el `curl`. Después volver a Preferences → Profiles → Colors
→ Color Presets → Import.

---

### MesloLGS NF no aparece en Font picker

iTerm2 cachea fuentes al arrancar. **Cmd+Q completo** (no solo cerrar
ventana), reabrir.

---

### "command not found: starship" después de instalarlo

```bash
which starship
```

Si responde con path, falta recargar:

```bash
source ~/.zshrc
```

Si no responde, Homebrew no está en PATH. Volver al primer error de esta
sección.

---

### Mi prompt no muestra colores ni iconos

Probablemente la fuente Nerd Font no está seleccionada en iTerm2.
Preferences → Profiles → Text → Font: MesloLGS NF.

Verifica también:

```bash
ls -la ~/.config/starship.toml
```

Debe ser symlink a `~/Projects/luca-dotfiles/starship.toml`.

---

## Fase 2

### "atuin login: invalid credentials"

Recordar: password y encryption key son **dos cosas distintas**. Si las
pegaste en el orden equivocado, falla.

Cuando el prompt pide:
1. Primero **password** (texto que tú elegiste)
2. Después **encryption key** (cadena larga generada por Atuin)

Si no recuerdas el password:

```bash
atuin account password-reset
```

(Y guárdalos en password manager esta vez.)

---

### "pip install" falla con "externally-managed-environment"

Estás instalando globalmente. Mal. Usa virtualenvs:

```bash
cd ~/Projects/tu-proyecto
python3 -m venv venv
source venv/bin/activate
pip install pandas
```

Si **realmente** quieres instalar global (no recomendado):

```bash
pip install pandas --break-system-packages
```

---

### "psql: command not found"

```bash
echo 'export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"' >> ~/Projects/luca-dotfiles/zshrc
source ~/.zshrc
```

---

### "could not connect to server" al usar psql

PostgreSQL no está corriendo:

```bash
brew services start postgresql@16
brew services list
```

Status debe decir "started".

---

### `new_bi_project` falla con "command not found"

No recargaste después de agregar la función al zshrc:

```bash
source ~/.zshrc
```

Si persiste, verifica que la función esté realmente en el zshrc:

```bash
grep "new_bi_project" ~/.zshrc
```

Debe mostrar la línea de definición.

---

### Jupyter Lab abre página en blanco

Cierra el browser, abre la URL manualmente:

```bash
jupyter lab --no-browser
```

Te da una URL con token. Pégala en tu browser.

---

### RStudio no detecta R

1. RStudio → Tools → Global Options → General → R version → Change
2. Selecciona la versión que muestra `/opt/homebrew/bin/R`
3. Restart RStudio

---

## Fase 3

### "claude: command not found"

```bash
brew install node
npm install -g @anthropic-ai/claude-code
```

---

### Docker Desktop no arranca

1. Cmd+Q en Docker Desktop
2. Restart Mac
3. Reabrir Docker Desktop
4. Si persiste: `brew uninstall --cask docker && brew install --cask docker`

---

### SSH a GitHub: "Permission denied (publickey)"

Tu llave pública no está en GitHub. Verifica:

```bash
cat ~/.ssh/id_ed25519.pub
```

Copia el output completo (empieza con `ssh-ed25519`). Pégalo en
[github.com/settings/keys](https://github.com/settings/keys).

Si ssh-agent no carga la llave automáticamente:

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

---

### Mis funciones zsh dejaron de funcionar

Symlink roto. Verificar:

```bash
ls -la ~/.zshrc
```

Debe ser symlink. Si no:

```bash
ln -sf ~/Projects/luca-dotfiles/zshrc ~/.zshrc
source ~/.zshrc
```

---

## General (cualquier fase)

### "command not found" para algo que ya instalaste

Solución universal:

1. Cmd+Q en iTerm2
2. Reabrir
3. Si aún falla: `source ~/.zshrc`
4. Si aún falla: `which <comando>` para ver si el binario existe
5. Si no existe: reinstalar con `brew reinstall <paquete>`

---

### Mi terminal se ve rara después de cambios

Restaurar configuración:

1. iTerm2 Preferences → General → Settings → Reset All Settings to Default
2. Re-aplicar Tokyo Night y MesloLGS NF
3. `source ~/.zshrc`

Si el zshrc está corrupto:

```bash
cd ~/Projects/luca-dotfiles
git checkout zshrc
source ~/.zshrc
```

---

### Mi repo `luca-dotfiles` se rompió

Reset al estado de GitHub:

```bash
cd ~/Projects/luca-dotfiles
git fetch origin
git reset --hard origin/main
```

Si todo está perdido:

```bash
mv ~/Projects/luca-dotfiles ~/Projects/luca-dotfiles-broken
gh repo clone tu-usuario/luca-dotfiles ~/Projects/luca-dotfiles
ln -sf ~/Projects/luca-dotfiles/zshrc ~/.zshrc
source ~/.zshrc
```

---

### "git push" pide usuario y password

GitHub deshabilitó autenticación HTTPS por password hace años. Configura
gh CLI:

```bash
gh auth setup-git
```

O cambia a SSH (Fase 3):

```bash
git remote set-url origin git@github.com:tu-usuario/luca-dotfiles.git
```

---

## Cuando nada funciona

Pasos en orden:

1. **Lee el mensaje de error completo.** No el resumen, el mensaje completo.
2. **Búscalo en Google literal.** Copy-paste el error.
3. **Pídele a Claude Code que ayude.** `cd` al directorio donde falló,
   `claude`, pégale el error y contexto.
4. **Pregunta a tu papá con contexto.** "Hice X, intenté Y, error Z, ya
   intenté A y B."
5. **Último recurso: reset.** Reinstalar es válido cuando el debugging
   supera 1 hora.

---

## Documenta tus propios errores

Este archivo es vivo. Cada vez que resuelvas algo nuevo, agrégalo:

```bash
cd ~/Projects/luca-dotfiles
nano docs/TROUBLESHOOTING.md
# Agregas tu error y solución
git add . && git commit -m "Add troubleshooting: <error>" && git push
```

En 6 meses, las soluciones documentadas aquí valen más que cualquier
tutorial. Es tu memoria externa.
