# code-medic — Blog


## 2026-09-15 — grip verliert die Datei nach `mv`/Verschieben (404 Not Found)

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

## 2026-09-15 — Laborbuch im Browser ansehen mit `grip`

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

## 2026-09-15 — Mac-Crash, tmux-Sessions automatisch neu aufsetzen

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
