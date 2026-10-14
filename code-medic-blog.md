# code-medic — Blog

<!-- Format neuer Einträge: "## 💊 JJJJ-MM-TT — Thema", neuester oben, Abschluss mit "---" -->

## 💊 2026-10-11 — bookdown: langsames Rendern, abgeschnittenes Menü, kaputte Listen

**1. Rendern dauerte ~30 min → `~/.Rprofile` lud tidyverse bei jedem R-Start**
- `~/.Rprofile` wird bei **jedem** R-Start automatisch ausgeführt. Stand dort `library(tidyverse)`,
  lud bookdown das komplette tidyverse für **jedes Kapitel** neu (eigene R-Sitzung pro Kapitel).
- Fix — nur laden, wenn ein Mensch an R sitzt (RStudio/Konsole), nicht bei Skripten:
  ```r
  if (interactive()) library(tidyverse)
  ```
- Prüfen: `Rscript -e 'cat("package:dplyr" %in% search())'` → `FALSE` = nicht geladen.
- Ergebnis: Rendern von **~30 min auf ~10 s**.
- Woher weiß R das? R merkt sich beim Start, *wie* es gestartet wurde: Konsole/RStudio (Mensch tippt
  Befehle ein) → `interactive()` = `TRUE`; `Rscript`, `R -e`, `R --file` (Befehle kommen aus Skript)
  → `FALSE`. Selbst testen: in RStudio `interactive()` eintippen → `TRUE`.

**2. Inhaltsverzeichnis links mit "…" abgeschnitten** → in `style.css`:
```css
.book .book-summary ul.summary li a,
.book .book-summary ul.summary li span {
  white-space: normal !important;   /* umbrechen statt abschneiden */
  text-overflow: clip !important;
}
```

**3. Breite Tabellen nicht seitlich scrollbar** (gitbook setzt `display: table`, dann wirkt `overflow` nicht):
```css
.book .book-body .page-wrapper .page-inner section.normal table {
  display: block !important;
  overflow-x: auto !important;
}
```

**4. Aufzählungen erscheinen als Fließtext "- a - b"** → pandoc braucht eine Leerzeile vor Listen.
Global abschalten in `_output.yml`:
```yaml
bookdown::gitbook:
  md_extensions: +lists_without_preceding_blankline
```

**Merksatz:** Nach CSS-/YAML-Änderung neu rendern **und** im Browser hart neu laden (`Cmd + Shift + R`),
sonst zeigt der Browser die alte, gecachte Version.

---

## 💊 2026-10-01 — Farbige Überschriften in grip (eigenes CSS)

**Problem:** grip rendert über die GitHub-API → GitHub entfernt jede Farbangabe im
Markdown (`<font color>`, `style=`). Farbe direkt in der `.md` geht also nicht.

**Lösung:** grip kann eigene Stylesheets einbinden (`STYLE_URLS`):
- `~/.grip/code-medic.css` — die Farben (Überschriften `h2` magenta mit Balken links, Titel `h1` violett).
- `~/.grip/settings.py` — liest die CSS-Datei beim grip-Start und hängt sie als `data:`-URL ein
  (CSS steckt direkt in der Adresse, kein eigener Server nötig).
- `!important` im CSS, weil GitHubs eigenes Stylesheet danach geladen wird und sonst gewinnt.

**Nach jeder CSS-Änderung grip neu starten** (Einstellungen werden nur beim Start gelesen):
```bash
ps aux | grep grip                     # PID des grip-Prozesses auf Port 8003 finden
kill <PID>
cd ~/github/codeNewbie && nohup ~/.local/bin/grip code-medic-blog.md 8003 > /dev/null 2>&1 &
```
- `nohup … &` = läuft im Hintergrund weiter, auch wenn das Terminal zugeht.
- `> /dev/null 2>&1` = Ausgabe + Fehler verwerfen (sonst entsteht `nohup.out`).

**Hinweis:** Gilt für *alle* grip-Instanzen nach deren Neustart — also auch das Laborbuch (Port 8002).

---

## 💊 2026-09-30 — Secrets aus dem Obsidian-Tagebuch entfernt & Telegram-Bot-Token rotiert

**Anlass:** Beim Durchsehen des Vault-Tagebuchs aufgefallen: Hermes-Telegram-Bot-Token
im Klartext, dazu Server-/NAS-Zugänge, Konto-Infos und Notizen über Dritte. Der Vault
liegt in `~/Documents` → wird über **iCloud** synchronisiert ("Schreibtisch & Dokumente"
aktiv) und soll später per Git zu GitHub/VPS → Token war damit nicht "nur auf dem Mac".

**Was wo passiert ist:**

| Ort | Was |
|---|---|
| `~/Documents/Obsidian Agents Vault/Agent-Vault/DIARY/` | Neuer Tagebuch-Ordner, eine Datei pro Monat (`07.2026.md`, `08.2026.md`, `09.2026.md`). Sensible Zeilen entfernt (07: 18, 08: 9, 09: 4 Zeilen). Beim Token (08-06) und eLogbuch-Link (09-02) steht ein Platzhalter. Außerdem in `09.2026.md`: doppelten 09-13-Block entfernt, `### 2026-09-02`-Überschrift repariert, Einträge 09-14/19/20 eingefügt. |
| `…/Agent-Vault/CLAUDE.md` | Neuer Abschnitt `## DIARY`: Dateischema, Format, Abgrenzung zu `Logbook.md`, Regel "keine Secrets". |
| `~/Desktop/DIARY-sensibel-2026-09-30.txt` | Die entfernten Zeilen, je mit Datei + Datum. Rechte `600` (nur eigener User lesbar). |
| `~/Desktop/DIARY-Backup-2026-09-30/` | Vollkopie von `DIARY/` **vor** dem Löschen (enthält alle Secrets!). |
| Telegram → @BotFather | `/revoke` → alter Token ungültig, neuer erzeugt (Bot-ID bleibt gleich). |
| VPS: `/docker/hermes-agent-5ta0/` | Projektordner von Hostingers Docker-Manager: `docker-compose.yml` + `.env`; `data/` = Hermes-Datenverzeichnis (im Container `/opt/data`), dort `config.yaml` (enthielt den Token **nicht**) und `logs/`. Neuer Token in die Env-Datei eingetragen (genaue Datei: ___). |
| VPS: Container `hermes-agent-5ta0-hermes-agent-1` | Neu erstellt, läuft stabil; Docker-Logs ohne Fehler/`401`. |

**Befehle auf dem VPS:**
```bash
cd /docker/hermes-agent-5ta0              # compose sucht docker-compose.yml im aktuellen Ordner
grep -rn "TELEGRAM" /docker/hermes-agent-5ta0/ 2>/dev/null   # Zeile mit dem Token finden (-r rekursiv, -n Zeilennr.)
docker compose up -d --force-recreate     # Container NEU erstellen → liest .env neu ein
docker ps                                  # läuft er? STATUS "Up …" = ok, "Restarting" = Absturz
docker logs --tail 50 hermes-agent-5ta0-hermes-agent-1 2>&1 | grep -i -e telegram -e 401 -e error
```

**Stolpersteine:**
- `docker compose restart` reicht **nicht** nach `.env`-Änderung — startet den alten
  Container mit alten Umgebungsvariablen neu. Nur `up -d --force-recreate` liest neu ein.
  Daten in `data/` bleiben erhalten (Bind-Mount, liegt außerhalb des Containers).
- `.env` ist versteckt (Punkt vorne) → nur mit `ls -la` sichtbar.
- `2>&1` vor der Pipe: viele Programme loggen auf stderr — ohne Umleitung rutscht das an `grep` vorbei.
- Befehle für den Server im **SSH-Terminal** (`root@srv…`) eingeben, nicht im Claude-Code-Chat (`❯`) — der läuft auf dem Mac.

**Offen:**
- [ ] Telegram-Test: Bot antwortet? (sonst `data/logs/*.log` nach `401` durchsuchen)
- [ ] `DIARY/` in Vault-`.gitignore`, **bevor** der Vault zu GitHub gepusht wird
- [ ] `08.2026.md` Zeilen 1–9 (09-14/19/20, jetzt doppelt) von Hand löschen
- [ ] Desktop-Datei + Backup-Ordner: Rest (Zugänge, Personen) in Passwort-Manager, dann löschen
- [x] Hermes-Port `0.0.0.0:<PORT>` ist öffentlich — geprüft: Web-Oberfläche verlangt Login
- [ ] Hermes nur noch per **HTTPS über Traefik** (Domain aus hPanel) nutzen — `IP:<PORT>` ist
  unverschlüsseltes `http://`, umgeht den Reverse Proxy. Danach in `docker-compose.yml`
  Port-Freigabe entfernen bzw. auf `127.0.0.1` binden (erst prüfen, dass HTTPS-Adresse klappt!)
- [ ] Optional: SSH-Login per Schlüssel statt Root-Passwort

**Konzepte (Krankenhaus-Analogie):**
- **IP** = Adresse des Hauses; **Hostname** (`srvXXXXXXX`) = Name des Hauses. `ssh root@<IP>` = als `root` zu dieser Adresse.
- **Port** = Zimmernummer (22 SSH, 443 HTTPS). `0.0.0.0:<PORT>->4860` = Außentür <PORT> führt zu Hermes' Zimmer 4860, `0.0.0.0` = jeder von der Straße darf rein.
- **HTTP** = Postkarte (jeder unterwegs liest mit), **HTTPS** = versiegelter Brief.
- **Zertifikat** = Dienstausweis des Servers, ausgestellt auf einen *Namen* (Domain), nicht auf IP:Port → deshalb auf `IP:<PORT>` kein HTTPS.
- **Forward Proxy** vertritt die Anfragenden (Stationssekretärin telefoniert für alle Ärzte);
  **Reverse Proxy** vertritt die Server (zentrale Pforte vor allen Stationen).
- **Traefik** (Container `traefik:latest` auf dem VPS) = Reverse Proxy: einziger Eingang (80/443),
  leitet nach Namen an den richtigen Container weiter, holt/erneuert Let's-Encrypt-Zertifikate
  automatisch (alle 90 Tage), leitet http → https um, erkennt neue Container über Docker-**Labels**.

**Prüfen, ob Hermes an Traefik hängt** (liefert die HTTPS-Adresse in `Host(...)`, leer = nicht angeschlossen):
```bash
docker inspect hermes-agent-5ta0-hermes-agent-1 --format '{{json .Config.Labels}}' | tr ',' '\n' | grep -i traefik
```

**Merksatz:** Secrets gehören in Config/`.env` und Passwort-Manager, nie in Notizen.
Nach einem Leck nicht die Kopien jagen, sondern das Secret **rotieren** — dann sind alle
alten Kopien wertlos.

---


## 💊 2026-09-30 — GitHub-Repo mit neuem Stand überschrieben (`git push --force`)

**Ziel:** Das lokale MedInfo-Buch (`~/Desktop/MedInfoExam/medinfo_exam_prep_book/`) ins
bestehende GitHub-Repo `GrigorijSchleifer/Medizinische-Informatik` bringen. Dort lag ein
alter Stand: 89 Commits, `bookdown-demo`-Reste, leere Platzhalter-Kapitel.

**Was passiert ist:**
1. Repo nach `~/github/Medizinische-Informatik` geklont (`git clone <URL>`).
2. Geplant war: alte Dateien mit `git rm` entfernen → Commit 1, Buch reinkopieren → Commit 2,
   dann normaler Push (Historie bleibt erhalten).
3. **Panne:** Beim Reinkopieren des Buch-Ordners wurde auch der versteckte `.git`-Ordner
   gelöscht/überschrieben → Ordner war kein Git-Repo mehr, keine Verbindung zu GitHub.
4. Entscheidung: **frischer Neustart** statt erneut klonen:
   ```bash
   cd ~/github/Medizinische-Informatik
   git init                               # Ordner wieder zum (neuen, leeren) Git-Repo machen
   git add -A                             # alle Dateien vormerken (außer .gitignore-Ausschlüsse)
   git commit -m "Initial import: Prüfungsvorbereitungs-Buch (Module I–III gefüllt)"
   git remote add origin https://github.com/GrigorijSchleifer/Medizinische-Informatik.git
   git push --force -u origin main        # selbst ausgeführt (Claude war blockiert)
   ```
   `.gitignore` vorher ergänzt: `.claude/`, `.DS_Store`, `_book/`, `_bookdown_files/`, `*.rds`,
   `.Rproj.user/`, `.Rhistory`, `.RData`.
5. Geprüft am 2026-10-01: `git ls-remote origin` → `main` auf GitHub = lokaler Commit `dfaca36` ✅

**Begriffe:**
- **Commit** = Momentaufnahme, nur lokal in `.git`. **Push** = lokale Commits zu GitHub hochladen.
- "working tree clean" heißt *nichts Neues* zu committen, nicht "nichts committet".
- **Remote / `origin`** = gespeicherte Adresse des GitHub-Repos; `-u` merkt sie als Standard
  für künftige `git push`/`git pull`.

**Warum `--force`?** Die neue Historie (1 Commit) hat nichts mit den alten 89 Commits gemeinsam.
Ein normaler `git push` wird abgelehnt ("non-fast-forward / Updates were rejected"), weil Git
beide nicht zusammenführen kann. `--force` macht keinen Merge, sondern setzt `main` auf GitHub
einfach auf den neuen Commit → alte Historie auf `main` **unwiderruflich ersetzt**.
Vorher geprüft: kein Branch-Schutz auf `main`, keine offenen Pull Requests.

**Stolpersteine:**
- `.git` ist ein *versteckter* Ordner — beim Kopieren/Ersetzen ganzer Ordner (Finder, `cp -R`)
  geht er leicht mit verloren. Besser: nur die *Inhalte* in den geklonten Ordner kopieren.
- Claude Code blockiert `git push --force` und `rm` auch nach "ja" (nicht rückgängig zu machen)
  → solche Befehle selbst ausführen, z. B. mit `!` im Chat.
- Sicherere Variante für später: `git push --force-with-lease` — überschreibt nur, wenn auf
  GitHub seit dem letzten `fetch` niemand etwas Neues gepusht hat.

**Offen:**
- [ ] Branch `branch_test` existiert auf GitHub noch und zeigt auf die alte Historie
  (die alten Commits sind darüber weiter erreichbar). Behalten oder löschen?

**Merksatz:** `--force` = "GitHub, vergiss deinen Stand, nimm meinen." Nur benutzen, wenn man
sicher ist, dass auf dem Remote nichts mehr gebraucht wird.

---

## 💊 2026-09-15 — `find` mit `-maxdepth` gezielt einen Ordner suchen

**Ziel:** Einen Projektordner (z. B. `eScribe`) im Home-Verzeichnis finden,
ohne dass `find` ewig durch jeden Unterordner (inkl. `node_modules` etc.)
gräbt.

**Befehl:**
```bash
find ~ -maxdepth 3 -iname "*escribe*" 2>/dev/null
```

**Aufschlüsselung:**
- **`find ~`** — durchsucht rekursiv ab dem Home-Verzeichnis (`~`).
- **`-maxdepth 3`** — begrenzt die Suche auf max. 3 Ordner-Ebenen tief
  (Home = Ebene 0). Ohne das gräbt `find` durch *jeden* Unterordner
  überall — dauert lange und listet viel Unnötiges. `3` reicht meist, um
  Top-Level-Projektordner zu finden.
- **`-iname "*escribe*"`** — sucht Datei-/Ordnernamen, die `escribe`
  enthalten, case-**i**nsensitive (findet `eScribe`, `Escribe`,
  `ESCRIBE` etc.). Die Anführungszeichen verhindern, dass die Shell den
  `*` (Wildcard) selbst expandiert, bevor `find` ihn sieht — `find` soll
  das Muster selbst gegen jeden Dateinamen matchen, nicht die Shell vorab
  gegen Dateien im aktuellen Ordner.
- **`2>/dev/null`** — leitet Fehlermeldungen (stderr, z. B. "Permission
  denied" bei gesperrten Systemordnern) ins Nichts um, damit nur Treffer
  angezeigt werden.

**Merksatz:** `-maxdepth N` ist der Hebel gegen ausufernde `find`-Suchen
im Home-Verzeichnis — ohne ihn wird's langsam und die Trefferliste
unübersichtlich.

---

## 💊 2026-09-15 — Claude Code: Session-ID finden & `claude resume` verstehen

**Ziel:** Nach dem Mac-Crash herausfinden, welche Claude-Code-Session
gerade läuft, und verstehen, was `claude resume` genau wiederherstellt.

**Session-ID anzeigen:**
```bash
# Innerhalb einer laufenden Claude-Code-Session: zeigt u. a. die
# aktuelle Session-ID an
/status

# Im Terminal, außerhalb: listet alle vorhandenen Sessions mit
# ID und Zeitstempel der letzten Nachricht zur Auswahl auf
claude --resume
```

**Was `claude resume` wiederherstellt und was nicht:**
- Der komplette Gesprächsverlauf (Transkript) der gewählten Session wird
  weitergeladen — Claude "erinnert" sich an alles, was vorher besprochen
  wurde.
- Das **Primary working directory** (der Arbeitsordner, in dem Claude
  Datei-/Shell-Befehle ausführt) wird dabei **nicht** aus der alten Session
  übernommen. Es wird beim Start neu gesetzt — und zwar auf den Ordner,
  in dem man `claude resume` gerade im Terminal ausführt.
- Sprich: Führt man `claude resume` in einem anderen Ordner aus als beim
  letzten Mal, "wandert" die Session dorthin, auch wenn der Gesprächsinhalt
  noch auf den alten Ordner Bezug nimmt.

**Merksatz:** `claude resume` = alter Gesprächsinhalt + neuer,
aktueller Arbeitsordner (der vom Terminal beim Start). Um sicherzugehen,
welche Session man wiederaufnimmt, `claude --resume` (ohne Session bereits
gewählt) nutzen — zeigt Liste mit Zeitstempeln zum Abgleich mit dem
tatsächlichen letzten Nutzungszeitpunkt vor dem Crash.

---

## 💊 2026-09-15 — grip verliert die Datei nach `mv`/Verschieben (404 Not Found)

**Symptom:** Blog-Datei nach `~/github/codeNewbie` verschoben. Server auf
Port 8003 lief weiter, zeigte aber `404 Not Found` im Browser.

**Ursache:** `grip <Datei> <Port>` merkt sich beim Start nur den **Pfad**
zur Datei, nicht deren Inhalt. Wird die Datei danach verschoben oder
umbenannt (z. B. mit `mv` oder im Finder), existiert unter dem alten Pfad
nichts mehr — der Server kann die Datei nicht mehr finden und liefert 404,
obwohl der Prozess selbst noch normal läuft. Bestätigt mit `ls` (alter Pfad:
"No such file or directory") und `curl` (Server antwortet, aber mit 404).

**Lösung — alten Prozess beenden und am neuen Ort neu starten:**
```bash
# 1. Laufenden Prozess finden (Spalte 2 = Process-ID/PID)
ps aux | grep grip

# 2. Alten Prozess mit seiner PID beenden
kill 17545

# 3. Kurz warten, bis der Port wirklich wieder frei ist,
#    bevor ein neuer Prozess denselben Port belegt
sleep 1

# 4. pipx installiert Programme nach ~/.local/bin — dieser Ordner ist nicht
#    automatisch im PATH, ohne diesen Schritt meldet die Shell
#    "grip: command not found"
export PATH="$PATH:$HOME/.local/bin"

# 5. In den Ordner wechseln, in dem die Datei jetzt tatsächlich liegt
cd ~/github/codeNewbie

# 6. grip neu starten: <Dateiname> <Port> — jetzt mit korrektem, aktuellem Pfad
grip code-medic-blog.md 8003

# 7. Prüfen, ob es klappt (in einem zweiten Terminal, da grip blockiert):
#    -o /dev/null verwirft die Antwort, -w gibt nur den HTTP-Statuscode aus
#    (200 = erfolgreich, 404 = nicht gefunden)
curl -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1:8003
```

**Merksatz:** Läuft eine Datei über einen lokalen Server (egal ob `grip`,
`python3 -m http.server` o. ä.) und wird die Datei währenddessen verschoben
oder umbenannt — Server killen und am neuen Pfad neu starten. Der Prozess
merkt eine Verschiebung nicht von selbst.

---

## 💊 2026-09-15 — Laborbuch im Browser ansehen mit `grip`

**Ziel:** Eine `.md`-Datei (z. B. ein Laborbuch) im Browser lesbar (mit Formatierung) über `http://127.0.0.1:PORT`.

**Werkzeug:** `grip` ("GitHub Readme Instant Preview") — rendert Markdown optisch wie auf GitHub und startet einen kleinen lokalen Webserver

**Sicherheitshinweis:** `grip` schickt den Markdown-Text an die GitHub-API zum Rendern — er läuft zwar *lokal als
Server*

**Schritt 1 — Versuch mit `pip3` direkt (gescheitert):**
```
pip3 install --user grip
```
**Fehler:** Homebrew-Python verweigert das mit der Meldung "externally
managed environment" (PEP 668). Wenn Python über
Homebrew installiert ist, verwaltet Homebrew selbst, welche Pakete installiert
sind — ein direktes `pip install` könnte das durcheinanderbringen und z. B.
andere über Homebrew installierte Tools kaputt machen. Deshalb blockiert
`pip3`

**Schritt 2 — sauberer Weg über `pipx` (erfolgreich):**
```
brew install pipx
pipx install grip
```
**Warum das funktioniert:** `pipx` installiert jede Kommandozeilen-Anwendung
(wie `grip`) in ihrer **eigenen, isolierten** kleinen Python-Umgebung — von Homebrew selbst empfohlene Weg für Python-*Anwendungen*
Nebeneffekt: `brew install pipx` hat dabei automatisch ()Python-Version (3.14.7) mitinstalliert/aktualisiert)

**Ergebnis:** `grip` Version 4.6.2 installiert unter `~/.local/bin/grip`.

**Schritt 3 — Test:**
```
grip Laborbuch.md 8002
```
Startet einen lokalen Server auf `http://127.0.0.1:8002` (bzw. `localhost:8002`).
`curl` bestätigte `HTTP 200 OK`, Prozess lief stabil im Hintergrund.
**Ergebnis: erfolgreich.**

**Merksatz:** Server im Terminal mit `Strg+C` beenden, wenn nicht mehr
gebraucht — `grip` läuft, solange der Terminal-Prozess offen ist.

---

## 💊 2026-09-15 — Mac-Crash, tmux-Sessions automatisch neu aufsetzen

**Anlass:** Mac ist abgestürzt, alle laufenden `tmux`-Sessions und ihre
Panes/Namen waren danach weg und mussten von Hand neu angelegt werden.

**Lösung:** Setup-Script `~/bin/tmux-sessions.sh` gebaut. Kurz erklärt, was
es macht (Anfänger-Ebene):
- `tmux new-session -d -s NAME` — legt eine neue Session mit dem Namen `NAME`
  an, `-d` = im Hintergrund (nicht sofort reinspringen).
- `tmux split-window -h` / `-v` — teilt das aktuelle Fenster horizontal/
  vertikal in ein weiteres Pane.
- `tmux select-layout tiled` — ordnet alle Panes gleichmäßig gekachelt an.
- `tmux has-session` — prüft, ob eine Session mit dem Namen schon läuft,
  damit das Script nichts doppelt anlegt.

**Ergebnis:** Beim Ausführen von `~/bin/tmux-sessions.sh` werden automatisch
zwei Sessions angelegt — `eScribe` und `MedInfo`, jeweils mit 3 Panes im
`tiled`-Layout — falls sie nicht schon laufen, und man wird danach direkt
angehängt (Standard: `eScribe`, alternativ `./tmux-sessions.sh MedInfo`).
Vermeidet künftig das manuelle Neuaufsetzen nach einem Crash oder Neustart.

---
