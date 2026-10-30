# codeNewbie

A physician learning the languages and tools of software development, to understand engineers' work, collaborate as an equal, and help shape safer clinical software. These are the pearls I collect along the way

<!-- Neuer Eintrag: unter den passenden Monat als "### TT.MM.JJJJ" (neueste oben);
     neuer Monat: "## Monat JJJJ" anlegen und in der Tabelle verlinken. -->

| Jahr | Jan | Feb | Mär | Apr | Mai | Jun | Jul | Aug | Sep | Okt | Nov | Dez |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **2026** |  | [2](#februar-2026) |  |  |  |  |  |  |  | [7](#oktober-2026) |  |  |
| **2025** | [5](#januar-2025) |  |  |  |  |  |  |  |  |  |  |  |
| **2024** |  | [4](#februar-2024) | [8](#märz-2024) | [2](#april-2024) | [3](#mai-2024) | [3](#juni-2024) | [3](#juli-2024) | [8](#august-2024) | [3](#september-2024) | [3](#oktober-2024) | [1](#november-2024) | [2](#dezember-2024) |
| **2023** |  | [14](#februar-2023) |  |  |  |  |  |  | [1](#september-2023) | [5](#oktober-2023) |  |  |

<sub>Zahl = Anzahl Einträge im Monat, Klick springt hin.</sub>

---

## Oktober 2026

### 29.10.2026

tmux: `Ctrl-a` then `p` → jump to the **previous window** (not pane)

**When it matters:** you have several tmux windows (tabs in the status bar at the bottom) and
want to go back one. Works in any terminal (plain Terminal.app too), not only in iTerm.

```bash
# Ctrl-a   the prefix: "next key is a tmux command" (my ~/.tmux.conf: set -g prefix C-a;
#          tmux default would be Ctrl-b)
# p        previous-window   (n = next-window, 0-9 = window by number)
# release Ctrl-a first, THEN press p (two steps, not all at once)
```

- **Window vs. pane:** a window = a whole tab; a pane = a split *inside* one window.
  Panes: `Ctrl-a` + arrow key, `Ctrl-a o` (next pane), or my `Ctrl-h/j/k/l` (no prefix).
- **Why it works everywhere:** tmux reads `~/.tmux.conf` itself when it starts, no matter which
  terminal app it runs in. The terminal only passes the keys through.
- Only works *inside* tmux (start it with `tmux`). Outside, `Ctrl-a` just moves the cursor to the
  start of the line.

Git: delete a branch on GitHub (remote) → `git push origin --delete <branch>`

**When it matters:** a pull request is merged, but its branch (e.g. a `claude/…` branch from
Claude in the cloud) still lies around on GitHub. The merged changes are safe in `main`, the
branch is just clutter.

```bash
git push origin --delete claude/was-siehst-du-hk3hir
# git push    send something to the remote repo
# origin      name of the remote = the GitHub repo (see: git remote -v)
# --delete    don't upload commits, instead REMOVE the branch there
# claude/...  name of the branch on GitHub (the "/" is just part of the name)
```

- Only the branch *on GitHub* is gone. A local copy (if any) stays → `git branch -d <branch>`
  (`-d` refuses if not merged yet, `-D` forces it).
- The commits are not lost if they were merged — they live on in `main`.
- Check first: `git branch -r` (lists remote branches); after deleting, others clean up their
  stale list with `git fetch --prune`.

Git + Vim: keep Vim's `.swp` files out of commits → `*.swp` in `.gitignore`

**When it matters:** while a file is open in Vim, Vim keeps a swap file next to it
(`notes.md` → `.notes.md.swp`, crash backup of your unsaved edits). Every edit changes it, so
`git status` lists it, and `git add .` / `git add -A` would put it into the commit — clutter
that means nothing to anyone else.

```bash
echo '*.swp' >> .gitignore   # >> = APPEND a line (a single > would overwrite the whole file!)
# *.swp   glob: every file ending in .swp, in every folder of the repo
#         (the leading dot of .notes.md.swp doesn't matter, * matches it too)
```

- From now on Git ignores new swap files: `git add .` skips them, even when Vim creates them again.
- **Catch:** `.gitignore` only works for files Git does NOT track yet. A `.swp` that was
  committed before stays tracked (shows up as `M` = modified) → remove it from Git once:

```bash
git rm --cached .notes.md.swp   # --cached = remove from Git only, the file on disk stays
git commit -m "Stop tracking Vim swap file, ignore *.swp"
```

- Check: `git check-ignore -v .notes.md.swp` → prints which `.gitignore` line matches
  (no output = not ignored).

### 27.10.2026

Vim: file was changed by someone else (another program, Claude, git pull) → `:e!`

**When it matters:** you have a file open in Vim, and meanwhile another program changes it on
disk. Vim still shows the OLD version from its memory (buffer). If you now save with `:w`, you
overwrite the other changes with your old version. A leftover `.<file>.swp` (swap file) next to
the file is the hint that Vim still has it open somewhere.

```vim
:e!     " e = edit (reload the file from disk), ! = throw away my unsaved changes in Vim
        " -> buffer now shows what is really on disk; nothing is written
:e      " same without ! -> refuses if you have unsaved changes (safe check first)
```

Vim often warns itself: `W11: Warning: File "x" has changed since editing started` →
answer `L` (Load File) does the same as `:e!`.

Vim: why is everything suddenly light/cream-colored? → set `background` explicitly

**When it matters:** many color schemes (e.g. my favorite `retrobox`) have a light AND a dark
variant. Without `set background=…` Vim *guesses* by asking the terminal for its background
color — and sometimes guesses "light".

```vim
" in ~/.vimrc -- ORDER matters: background first, then the color scheme
set background=dark   " force the dark variant, don't let Vim guess
colorscheme retrobox  " the scheme reads 'background' while it loads
```

```vim
:set background=dark          " try it live, nothing saved (back: :set background=light)
:verbose set background?      " ? = show current value; verbose = which file/line set it last
                              " no "Last set from ~/.vimrc" line -> Vim guessed it itself
```

Free the terminal while a server is running: `Ctrl+Z` + `bg`

**When it matters:** a server like `python3 -m http.server <PORT>` blocks the terminal and
floods it with request logs (`"GET /index.html HTTP/1.1" 200 -`), so you can't type anything.

```bash
# Ctrl+Z   -> "[1] + 22775 suspended ..."   STOPS (pauses) the job -- server no longer answers!
bg         # resume job in the BACKGROUND -> server runs again, prompt is free
jobs       # list background jobs of THIS terminal: [1] + running python3 -m http.server ...
fg         # bring it back to the foreground (then Ctrl+C to quit it)
kill %1    # stop job number 1 directly (%1 = job number from `jobs`, not the PID)
```

Careful:
- `Ctrl+Z` alone = paused, not backgrounded → browser just keeps loading. Always follow with `bg`.
- After `bg` the log lines still pop up in the terminal. To silence them, start it like this instead:
  ```bash
  python3 -m http.server <PORT> --bind 127.0.0.1 > /dev/null 2>&1 &
  # >  /dev/null   throw away normal output (stdout)
  # 2>&1           send error output (stderr, where http.server writes its logs) to the same place
  # &              start directly in the background (no Ctrl+Z needed)
  ```
- Jobs belong to the terminal: close the tab → the server usually dies too.
  Lost track of it? → find it with `lsof` (see next entry) and `kill <PID>`.

Which program is blocking a port? (`OSError: [Errno 48] Address already in use`)

**When it matters:** you start a local server (e.g. `python3 -m http.server <PORT>`) and get
`Address already in use` → an old server (often from an earlier session / another terminal tab)
is still running on that port.

```bash
lsof -nP -iTCP -sTCP:LISTEN          # ALL ports where a server is waiting ("listening")
lsof -nP -iTCP:<PORT> -sTCP:LISTEN   # only this one port
# lsof          "list open files" -- on macOS network connections count as files too
# -n            show IP addresses as numbers (no name lookup -> faster)
# -P            show ports as numbers (8001), not service names
# -iTCP         only TCP network connections (-iTCP:<PORT> = only that port)
# -sTCP:LISTEN  only connections in state LISTEN = servers waiting for requests

# Output (read: COMMAND, PID, NAME):
# COMMAND  PID    ... NAME
# Python   16813  ... TCP 127.0.0.1:<PORT> (LISTEN)
#   127.0.0.1:<PORT>  reachable only from this Mac (good)
#   *:<PORT>          reachable from the whole network!

lsof -a -p <PID> -d cwd   # which folder was that server started from?
# -p <PID>   only this process      -d cwd   only its "current working directory"
# -a         combine the filters with AND (default is OR -> far too much output)
```

Then either:
- **reuse it**: if it serves the right folder, just open `http://127.0.0.1:<PORT>` (reload with `Cmd+Shift+R`)
- **stop it**: `kill <PID>`, check with `lsof -nP -iTCP:<PORT> -sTCP:LISTEN; echo $?` (`1` = nothing found = port free)
- **avoid it**: just use another port

### 22.10.2026

Vim: see where the cursor is when jumping between search matches with `n`/`N`

```vim
" in ~/.vimrc
set cursorline   " highlight the whole line the cursor is on
set hlsearch     " highlight ALL matches of the last search (/pattern); clear with :noh
set incsearch    " jump to the first match while still typing /pattern
```

Try it without editing the file: `:set cursorline` (undo: `:set nocursorline`).
Line too faint in your color scheme? `highlight CursorLine cterm=NONE ctermbg=238` (cterm=NONE removes the underline, 238 = gray from the 256-color palette).
My full, commented `.vimrc`: [VIM/.vimrc](VIM/.vimrc)

### 21.10.2026

Python: print a variable from a script as readable JSON, straight from the terminal

```bash
python3 -c 'import json, test_modell as t; print(json.dumps(t.SCHEMA, indent=2, ensure_ascii=False))'
# python3 -c '...'         run a short piece of Python without creating a file
# import test_modell as t  load test_modell.py (from the current folder), short name t
# t.SCHEMA                 the variable SCHEMA defined in that file (here: a dict)
# json.dumps(...)          turn it into JSON text
#   indent=2               line breaks + 2-space indentation -> readable
#   ensure_ascii=False     keep umlauts (ä, ö, ü) instead of ä
```

Careful:
- `import` runs the whole file top to bottom. Safe only if the script's main code sits under `if __name__ == "__main__":`, otherwise it starts running.
- `import` also rewrites `__pycache__/test_modell.cpython-XY.pyc` → don't rely on that cache file as an "old version" backup.

Vim: text yanked with `y` goes straight to the Mac clipboard (`Cmd+V` in any app)

```vim
" in ~/.vimrc
set clipboard=unnamed
" Vim's default register (the "unnamed" one) = Mac clipboard
" y (yank/copy) -> paste anywhere with Cmd+V; Cmd+C in another app -> paste in Vim with p
" Careful: d / x (delete) also land there and overwrite the clipboard
" without this setting: address the Mac register explicitly with "*y and "*p
```

Requirement: Vim built with `+clipboard` (check: `vim --version | grep clipboard`).
My full, commented `.vimrc`: [VIM/.vimrc](VIM/.vimrc)

### 20.10.2026

`cd -`: zurueck in den Ordner, aus dem man gekommen ist

```bash
cd -
# springt ins vorherige Verzeichnis und gibt dessen Pfad aus
# nochmal cd -  -> wieder hin = pendeln zwischen den letzten zwei Ordnern

# Woher weiss die Shell das?
echo $OLDPWD      # Variable mit dem letzten Ordner; cd - = cd "$OLDPWD"

# Verwandte
cd                # (ohne Argument) = cd ~ -> Home-Verzeichnis
cd ..             # eine Ebene nach oben
git switch -      # gleiches Prinzip in Git: zurueck zum vorherigen Branch

# Mehr als einen Schritt zurueck (zsh)
setopt AUTO_PUSHD # in ~/.zshrc: zsh merkt sich jeden cd-Schritt
dirs -v           # Liste: 0 = hier, 1 = davor, 2 = davor ...
cd -2             # zwei Schritte zurueck
```

### 16.10.2026

grep: alle Markdown-Ueberschriften einer Ebene auflisten (= Inhaltsverzeichnis einer `.Rmd`/`.md`)

```bash
grep '^## ' 09-*.Rmd 10-*.Rmd
# = "Zeig mir aus beiden Dateien alle Zeilen, die mit '## ' beginnen"
#   -> die Kapitelueberschriften (im MedInfo-Buch: die Curriculum-Punkte)

# grep        Zeile fuer Zeile lesen, nur passende Zeilen ausgeben
# '...'       einfache Anfuehrungszeichen = Shell, Finger weg: Muster kommt 1:1 bei grep an
#             (ohne: # am Wortanfang = Kommentar -> Rest ignoriert; Leerzeichen am Ende verschluckt)
#             "..." waere anders: darin ersetzt die Shell Variablen wie $f
# ^           Regex-ANKER "Zeilenanfang" (kein Zeichen, sondern eine Position); Gegenstueck: $ = Zeilenende
#             '^## ' trifft "## Titel", aber NICHT "Text mit ## mittendrin"
# ##          zwei echte Rauten = Markdown-Ueberschrift Ebene 2 (# Kapitel, ## Abschnitt, ### Unterpunkt)
# Leerzeichen Absicht: nur GENAU Ebene 2 -> "### Unterpunkt" faellt raus (nach ## kommt # statt Leerzeichen)
# 09-*.Rmd    GLOB: die SHELL (nicht grep) ersetzt das vorher durch den echten Dateinamen
#             * = beliebig viele beliebige Zeichen -> langen Namen nicht tippen
# >1 Datei    grep schreibt "dateiname:" vor jeden Treffer

# Ausgabe
# 09-modul-ix-....Rmd:## Anwendungssysteme in der Forschung
# 10-modul-x-....Rmd:## Fernbehandlung

# Varianten
grep -n '^## ' datei.md     # -n = mit Zeilennummer (zum Hinspringen: vim +123 datei.md)
grep -c '^## ' *.Rmd        # -c = nur ANZAHL Ueberschriften pro Datei
grep '^#\{1,3\} ' datei.md  # Ebene 1 bis 3 (\{1,3\} = 1- bis 3-mal das Zeichen davor)

# ACHTUNG: * hat zwei Bedeutungen
#   Glob  (Shell, Dateinamen): *  = beliebig viel
#   Regex (grep, Inhalt):      *  = Zeichen DAVOR 0-mal oder oefter;  .* = beliebig viel
```

vim: aktuelle Zeile in die Mac-Zwischenablage kopieren (danach mit `Cmd-V` ueberall einfuegen)

```vim
" aktuelle Zeile kopieren
:.w !pbcopy

" .        = Bereich "aktuelle Zeile" (steht VOR dem w: erst welche Zeilen, dann was tun)
" w        = write, aber nicht in eine Datei ...
" !pbcopy  = ... sondern per Pipe an pbcopy (macOS: Eingabe -> Zwischenablage)
" Datei wird dabei NICHT gespeichert

" Varianten
:w !pbcopy          " ganze Datei
:5,10w !pbcopy      " Zeilen 5-10
" V (Zeilen markieren) > : > vim ergaenzt :'<,'> > w !pbcopy   -> markierte Zeilen

" ACHTUNG
" Leerzeichen vor ! ist Pflicht: :w!pbcopy = force write in eine DATEI namens pbcopy
" :w. statt :.w -> schreibt in eine Datei namens "." (Fehler)
" kopiert immer ganze Zeilen
```

Claude Code: `/clear` und das Kontextfenster

```text
Kontextfenster = alles, was Claude bei JEDER Antwort "vor Augen" hat:
                 CLAUDE.md + gesamter bisheriger Chatverlauf + Tool-Ausgaben (Dateien, Befehle)

Problem bei langen Sessions:
  - jede Nachricht schickt den kompletten Verlauf mit -> langsamer, teurer
  - fruehe Details geraten aus dem Blick, alte Themen "stoeren" neue -> Antwortqualitaet sinkt
  - wird es zu voll, fasst Claude Code automatisch zusammen (auto-compact) -> Feinheiten gehen verloren

/clear      Verlauf leeren, CLAUDE.md wird neu geladen = frische Session, ohne Claude zu beenden
/compact    Verlauf selbst zusammenfassen lassen, Session laeuft weiter (wenn man mitten drin ist)
/context    zeigt, wie voll das Kontextfenster gerade ist
exit        Claude beenden; Session bleibt gespeichert -> claude --resume (oder /resume) holt sie zurueck

Faustregel:
  - Aufgabe/Lernblock fertig oder Themenwechsel  -> /clear
  - mitten in einer Aufgabe, aber schon sehr lang -> /compact
  - alles Wichtige (Regeln, Stand, To-dos) vorher in die CLAUDE.md schreiben lassen,
    dann geht durch /clear nichts verloren
```

### 14.10.2026

Zwischen tmux-Panes mit `Alt-h/j/k/l` springen statt `Ctrl-A` + Pfeiltaste

```bash
# 1. Datei oeffnen
vim ~/.tmux.conf

# 2. einfuegen (-n = kein Ctrl-A noetig, M- = Alt/Option)
bind -n C-h select-pane -L
bind -n C-j select-pane -D
bind -n C-k select-pane -U
bind -n C-l select-pane -R

# 3. speichern: :wq > Enter

# 4. in laufende Session laden
tmux source-file ~/.tmux.conf

# 5. testen: Alt-j / Alt-k
# kommen Sonderzeichen (∆ º) statt Sprung -> Terminal schickt kein Meta:
```

[↑ Übersicht](#codenewbie)

---

## Februar 2026

### 17.02.2026

```bash
# R versions on Mac OS
# https://support.posit.co/hc/en-us/articles/200486138-Changing-R-versions-for-the-RStudio-Desktop-IDE
ls -l /Library/Frameworks/R.framework/Versions/

```

### 11.02.2026

```R
# first the new then the old (multiple possible)
mtcars %>%
    rename(newname = oldname, newname = oldname)
```

[↑ Übersicht](#codenewbie)

---

## Januar 2025

### 30.01.2025

```R
# showing coefficients and stuff of a model in a nice way
model %>% tidy()
```

### 29.01.2025

```R
# nice way to chqnge color aesthetic and do it for a log normal distributed data
 scale_color_gradient2(low = "blue",
                          high = "red",
                          midpoint = log10(median(maryland_bridges$avg_daily_traffic)),
                          trans = "log10",
                          labels = comma_format()) +
```

### 28.01.2025

```R
# replacing NA with something else
maryland_bridges %>%
    replace_na(list(responsibility = "Other")u)
```

### 27.01.2025

```R
# you can mutate things inside count
baltimore_bridges %>%
    count(decade = 10 * (yr_built %/% 10))
```

```R
# showing correlation inside a column
# id: persons id
# value: here type of food
# what food types are correlated with other food types

library(widyr)

food_gathered %>%
    pairwise_cor(value, id, sort = TRUE)
```

### 01.01.2025

```R
# removes value entries that are in c()
df %>%
  filter(!value %in% c("None", "Other (please specify)"))
```

[↑ Übersicht](#codenewbie)

---

## Dezember 2024

### 29.12.2024

```R
# removes any number inside "name"
df %>%
   mutate(name = str_remove(name, "\\d+"))
```

### 10.12.2024

```R
# filter every second year
filter(year %% 2 == 0)
```

[↑ Übersicht](#codenewbie)

---

## November 2024

### 16.11.2024

```R
# filter only years like 1980, 1990 ...
filter(year %% 10 == 0)
```

[↑ Übersicht](#codenewbie)

---

## Oktober 2024

### 22.10.2024

```R
# THE WORLD
malaria_spread %>%
    inner_join(maps::iso3166 %>%
                   # do we keep only mapname here
                   select(a3, mapname), by = c(code = "a3")) %>%
    # this will keep all regions
    # keeps all observations in y
    right_join(world, by = c(mapname = "region")) %>%
    ggplot(aes(long, lat, group = group, fill = Y2015)) +
    geom_polygon() +
    ltheme_void()
```

```R
# dispay the datasets contained in a package
data(package = "datasets")
```

### 20.10.2024

```R
# selecting inside a join and keep only columns that are needed
malaria_spread %>%
    inner_join(maps::iso3166 %>%
                   select(a3, mapname), by = c(code = "a3"))
```

```R
# not sure what this is but some geography sugar
tibble::as.tibble(map_data("world"))
```

### 13.10.2024

```R
# remove only a specified file
for (fl in list.files(getwd(), recursive = TRUE)) {
    if (grepl(pattern = ".icloud", x = fl) == TRUE) {
      file.remove(fl)
    }
}
```

[↑ Übersicht](#codenewbie)

---

## September 2024

### 26.09.2024

#### Get the decade of a year

```R
kenya_pr %>%
    # %/% truncates the last digit
    mutate(decade = 10 * (year_start %/% 10))
```

### 11.09.2024

```R
malaria_in_process %>%
    # grabbing 6 unique countries
    filter(country %in% sample(unique(country), 6))

# ggplot2::map_data("world") %>% tibble() %>% filter(region == "Kenya")
kenya_pr %>%
    # %/% truncates the last digit
    mutate(decade = 10 * (year_start %/% 10)) %>%
    # niiiice! This will show the highest pr´s on top of the graph
    # this will arrange from lowest to highest and plot highest last
    arrange(pr) %>%
    ggplot(aes(longitude, latitude, colour = pr)) +
    geom_point() +
    borders("world", regions = "Kenya") +
    scale_color_gradient2(low = "blue",
                          high = "red",
                          midpoint = .5,
                          labels = percent_format()) +
    facet_wrap(~ decade) +
    theme_void() +
    coord_map() +
    # changes the name of the legend
    labs(color = "Prevalence")
```

### 03.09.2024

Change all numeric values in a dataframe to NA if they are equal to -9999

```R
us_wind <- us_wind %>%
    mutate_if(is.numeric, ~ ifelse(. == -9999, NA, .))
```

[↑ Übersicht](#codenewbie)

---

## August 2024

### 29.08.2024

To the color aesthetic and see the 6 lumped categories we need some R magic. Without arranging the data, the Other category would be on top and will overlay the other categories in the plot.

```R
us_wind %>%
    filter(!t_state %in% c("AK", "HI", "GU", "PR")) %>%
    # FALSE comes before TRUE (in this case Other is on top)
    # fct_lumped data needs to be arranged so that TRUE comes on the top of the table
    mutate(p_name = fct_lump(p_name, 6)) %>%
    arrange(p_name != "Other") %>%
    filter(xlong < 100) %>%
    ggplot(aes(xlong, ylat, color = p_name)) +
    borders("state") +
    geom_point() +
    coord_map() +
    theme_void()
```

### 27.08.2024

Not useful but interesting. How many times a package was downloaded from CRAN in the last week

```R
cranlogs::cran_downloads(packages = "tidyverse", when = "last-week")
```

### 22.08.2024

Displaying time on the x axis [TidyTuesday](https://www.youtube.com/watch?v=nms9F-XubJU&list=PL19ev-r1GBwkuyiwnxoHTRC8TTqP8OEi8&index=79) (minute 40:00)

```R
# gap was produced by the line
# mutate(gap = datetime - lag(datetime))
# lag in seconds between downloads
r_downloads_gaps %>%
    count(country, gap) %>%
    # filter(country == "United States") %>%
    ggplot(aes(gap)) +
    geom_histogram() +
    # clear bimodal log normal distribution
    # scale_x_log10()
    scale_x_log10(breaks = 60 ^ (0:4),
                  labels = c("Second", "Minute", "Hour", "2.5 Days", "120 Days"))
```

### 18.08.2024

Another [TidyTuesday](https://www.youtube.com/watch?v=nms9F-XubJU&list=PL19ev-r1GBwkuyiwnxoHTRC8TTqP8OEi8&index=79) pearl (minute 9:00)

```R
# this is a biggy!
# cool way to display weekdays
# not sure what group argument does but without it doesnt work
# AAAAAND mutate things inside group_by method is really cool
r_downloads_year %>%
    count(date) %>%
    # there will be a lot data for every weekday
    group_by(weekday = wday(date, label = TRUE)) %>%
    mutate(average = mean(n)) %>%
    ggplot(aes(weekday, average)) +
    geom_line(group = 1) +
    expand_limits(y = 0)
```

### 17.08.2024

One lm smooth line for all genres vs. separate lm line for every group

```R
# one line
movie_profit %>%
    filter(release_date >= "1990-01-01",
           profit_ratio >= .01) %>%
    ggplot(aes(release_date, profit_ratio)) +
    geom_point(aes(color = genre)) +
    geom_smooth(method = "lm", group = 1) +
    geom_text(aes(label = movie), vjust = 1, hjust = 1, check_overlap = TRUE) +
    scale_y_log10(labels = function(x) paste0(x, "X"), breaks = c(.1, 1, 10, 100))

# many lines
movie_profit %>%
    filter(release_date >= "1990-01-01",
           profit_ratio >= .01) %>%
    ggplot(aes(release_date, profit_ratio)) +
    geom_point(aes(color = genre)) +
    geom_smooth(method = "lm") +
    geom_text(aes(label = movie), vjust = 1, hjust = 1, check_overlap = TRUE) +
    scale_y_log10(labels = function(x) paste0(x, "X"), breaks = c(.1, 1, 10, 100))
```

### 07.08.2024

Converting a random year to a corresponding decade

```R
yrs <- tribble(~year,
        1234,
        1345,
        1235,
        1344,
        1899)

# first we divide the year by 10 and floor it
# this way we get rid of the year and keep the integer of the decade
# by multiplying by 10 we get the decade
yrs_decade <- yrs %>%
    mutate(decade = 10 * floor(year/10))
```

### 04.08.2024

```R
# reversing the order of rows
# row_number() should be used inside mutate, filter or some other dplyr verb (I forgot which one)
# otherwise it returns numbers I don´t understand
arrange(desc(row_number()))
```

### 03.08.2024 (Updates 05. + 06.08.)

This [video](https://www.youtube.com/watch?v=T13gDBXarj0&t=265s) is the best example of merging and pulling that I have seen so far.

I am stuck again while trying to move a cloned repository that I found on the internet (a copy of a book coded in bookdown) to a repository I created on Github. First of all I deleted the remotes that came with the cloned repository (didn`t know that remotes need to be deleted) and added new remote "pointer" that where the url of my new repository.

```bash
# shows the remotes
git remote -v
```
I created a new branch `brach_test` with the `git branch branch_test` command. And checked out into it with `git checkout brach_test`. I pushed the branch with `git push branch_test` but needed to set the remote as upstream, with `git push --set-upstream origin branch_test`. Not entirely sure why I needed to do this and not but ok let´s where this will go.

UPDATE (05.08.24)

I don´t thing the steps above are helful. I decided to clone my own new [repository](https://github.com/GrigorijSchleifer/Medizinische-Informatik) and edits its remotes with this command.

```bash
# here I add to my local repository an additional remote poiter and give it a short name `book`
git remote add book https://github.com/rstudio/bookdown-demo.git

# now we see two remotes in my local repository
git remote -v

# book	https://github.com/rstudio/bookdown-demo.git (fetch)
# book	https://github.com/rstudio/bookdown-demo.git (push)
# origin	https://github.com/GrigorijSchleifer/Medizinische-Informatik.git (fetch)
# origin	https://github.com/GrigorijSchleifer/Medizinische-Informatik.git (push)
```

Next, I fetched the content from the bookdown-demo to my local repository.

```bash
# the pointer to the remote of the bookdown-demo is named book
# this brings content, branches, commits from this repository to my local ropositors
git fetch book
```

The next step that solved the headache was to merge the bookdown-demo on main. Or the other way around (main from my own repository on the tip of book/main). I am still confused what the correct order of `git merge` should be. And another important step was to allow the merge of unrelated histories. I think I know what the meaning of this flag is. Becaus my own, and freshly created repository is unrelated to the bookdown-demo repo, the histories are absolutely unrelated and git´s default behaviour is to prevent the merge of unrelated histories. The command I used is:

```bash
# because we have different conten in README there is a conflict
git merge main book/main --allow-unrelated-histories

# Auto-merging README.md
# CONFLICT (add/add): Merge conflict in README.md
# Recorded preimage for 'README.md'
# Automatic merge failed; fix conflicts and then commit the result.
```

```bash
# NOT CLEAR
git commit -m "fatal: You have not concluded your merge (MERGE_HEAD exists)"
# Recorded preimage for 'README.md'
# [main 3af470e] fatal: You have not concluded your merge (MERGE_HEAD exists)

# NOT CLEAR
git merge main book --allow-unrelated-histories
# merge: book - not something we can merge
```

[↑ Übersicht](#codenewbie)

---

## Juli 2024

### 29.07.2024

This code creates two plots: one with a normal y-axis and another with a logarithmic y-axis. The logarithmic scale helps to better visualize the exponential relationship by compressing the y-axis.

```R
# Create data frame with exponential relationship
df_exp <- data.frame(
    normal = c(1:100),
    exp = exp(1:100)
)
```

```R
# Plot with normal y-axis
df_exp %>%
    ggplot(aes(normal, exp)) +
    geom_point()
```
![image](https://github.com/user-attachments/assets/876521d4-7064-4cc9-b36e-d094256c2169)

```R
# Plot with logarithmic y-axis
df_exp %>%
    ggplot(aes(normal, exp)) +
    geom_point() +
    scale_y_log10()
```
![image](https://github.com/user-attachments/assets/f576b80b-9a6a-44c1-8bfc-fdfd2a94f17f)

### 13.07.2024

First encounter of the pipe operator behaving weirdly (something with left and right)

```R
major_processed |>
  select(Major, Total, ShareWomen, Sample_size, Median) %>%
  lm(Median ~ ShareWomen, data = ., weights = Sample_size)
```

<a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/R">R</a>

```R
# facet_grid() forms a matrix of panels defined by row and column faceting variables. It is most useful when you have two discrete variables,
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(drv ~ cyl)
  ```

### 12.07.2024

```R
# This vignette summarises the various formats that grid drawing functions take. Most of this information is available scattered throughout the R documentation. This appendix brings it all together in one place.
vignette("ggplot2-specs")
````

[↑ Übersicht](#codenewbie)

---

## Juni 2024

### 30.06.2024

When you specify a color within aes(), ggplot2 interprets it as a mapping to a variable in the data, not a fixed color. Since there is no variable named "blue", ggplot2 defaults to a standard color (pink).

```R
# will not work
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy, color = "blue"))

# will not work
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = "blue"))

# will work
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue")

# will work
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy), color = "blue")

# will work
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue")
```

Shows all current libraries on my machine

```R
# https://rstudio.github.io/renv/articles/renv.html

.libPaths()

# list all packages in libraries on my machine
lapply(.libPaths(), list.files)

# which repositories are currently set up in your session
getOption("repos")

# will create a snapshot of all packages and their versions
renv::snapshot()
# if called later, it will restore all packages from the last snapshot
# this way you can share a script and all packages will be the same
renv::restore()
```

### 26.06.2024

<a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/R">R</a>

Error messages in German in RStudio ... nice and useless :)

```R
Sys.setenv(LANGUAGE = "de")
```

### 01.06.2024

<a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/R">R</a>

Columns that contain spaces are breaking R's usual rules for variable names; they're non-syntactic names. To refer to these variables, you need to surround them with backticks, `

[↑ Übersicht](#codenewbie)

---

## Mai 2024

### 17.05.2024

<a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/Regex">Regex</a>

```R
Regular expression "(.)(.)" is used to split the column names into two parts:

The first part "(.)" captures the first character of the column name into a group. The second part "(.)" captures the second character of the column name into another group.

So, for example, if the column name is "x1", the first group "(.)" will capture "x", and the second group "(.)" will capture "1".
```

### 04.05.2024

```R
# Load built-in datasets and show what is available
data()
```

```R
# move new column before existing column 1
mutate(new_column = x - y, .before = 1)

# move new column before specified column by name
mutate(new_column = x - y, .before = soneColumnName)

# Example
nycflights13::flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1,
    .keep = "used"
  )
```

### 02.05.2024

```R
# modulo: result is the remainder 1
7 %% 2

# regular division: result is 3.5
7 / 2

# integer division: result is 3
7 %/% 2
```

<a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/R">R</a>

If you see X1-Xn in the table output, it means that the header rows are not recognized as header columns.`

```
     X1    X2    X3
  <dbl> <dbl> <dbl>
1     1     2     3
2     4     5     6
```

If you want to fix this, you can use the `col_names` argument set to TRUE. The output will be a data frame with the column names as the first row.

```
# A tibble: 1 × 3
    `1`   `2`   `3`
  <dbl> <dbl> <dbl>
1     4     5     6
```

#### read_csv vs read_csv2

read_csv2() reads semicolon-separated files. These use ; instead of , to separate fields and are common in countries that use , as the decimal marker.

#### read_delim()

For reading a file delimited with |, use read_delim() with argument delim = "|"

[↑ Übersicht](#codenewbie)

---

## April 2024

### 21.04.2024

```R
# returns the directory (all parts) of a file path, but not the file name
dirname(file.path("","p1","p2","p3", "filename"))
# "/p1/p2/p3"

# returns the base (last part) of a file path
basename(file.path("","p1","p2","p3", "filename"))
# "filename"
```

### 20.04.2024

Quit R inside the terminal

```bash
quit()
```

[↑ Übersicht](#codenewbie)

---

## März 2024

### 31.03.2024

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/EMACS">EMACS</a>

I want to install DOOM Emacs but can't do it because it requires Emacs version 27 or above. My problem is that I can't upgrade my version of Emacs. Now I am trying to delete Emacs from my server and install a newer version from source (for the first time in my life).

```bash
sudo apt remove emacs
```

Installation of Emacs 28 from source

1: Dependencies (needed for installation)

```bash
sudo apt-get install build-essential texinfo libx11-dev li bxpm-dev libjpeg-dev libpng-dev libgif-dev libtiff-dev libgtk2.0-dev libncurses-dev automake autoconf
```

2: Download and extract source code

```bash
wget https://ftp.gnu.org/gnu/emacs/emacs-28.1.tar.xz
```

3: Compile and install

```bash
cd emacs-28.1
./configure
make
sudo make install
```

4: Doom needs a more recent version of Git. Installed Git from source using the tutorial from this [link](https://www.digitalocean.com/community/tutorials/how-to-install-git-on-debian-10)

### 24.03.2024

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/EMACS">EMACS</a>

#### Step 1

```console
# Install Emacs
sudo apt install emacs
```

#### Step 2

Create `.config` file inside your home directory. Inside `.config` create a `emacs` directory and inside that create an `init.el` file.

#### Step 3

In the `init.el` file add the following:

```elisp
# telling the system that the config file will be config.org and not init.el
# config.org will be an org document containing emacs configuration blocks

(org-babel-load-file
  (expand-file-name
  "config.org"                                                                              │
  user-emacs-directory))
```
#### Step 4

Create a `config.org` file in `~/.config/emacs` location (same as the config.el)

`control x` and `control s`: saving
`control x` and `control f`: finding files

### 20.03.2024

Finding my Macs processor architecture

```console
uname -m
```

Other options are

```
-a  -- print all basic information
-m  -- print hardware class
-n  -- print network node hostname
-p  -- print processor type
-r  -- print operating system release level
-s  -- print name of the operating system
-v  -- print detailed operating system version
```

Showing all postgres processes running on my machine

```console
ps aux | grep postgres
```

Finding the postgresql.conf file

```console
cd /usr/local/var/postgres
```

Restarting postgresql

```console
brew services restart postgresql@14
```

Loading postgresql

```console
brew services load postgresql@14
```

Showing configuration of plist

```console
cat ~/Library/LaunchAgents/homebrew.mxcl.postgresql@14.plist
```

### 19.03.2024

```sql
CREATE TABLE transactions (
  id INTEGER,
  recipient_id INTEGER,
  sender_id INTEGER,
  note TEXT,
  amount INTEGER
);
```
* Rename table, rename column, add column

```sql
ALTER TABLE people
RENAME TO users;

ALTER TABLE users
RENAME COLUMN handle TO username;

ALTER TABLE users
ADD COLUMN password TEXT;

ALTER TABLE transactions
  ADD COLUMN was_successful BOOLEAN;

ALTER TABLE transactions
ADD COLUMN transaction_type TEXT;
```

### 09.03.2024

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/VIM">VIM</a>

* Jumping from method to method. `[m` jump to the method above.  `]m` jump to the method below.

### 05.03.2024

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/Git">GIT</a>

* Git stores folders as trees and files as blobs (binary large object: object type used to store the contents of each file in a repository plus the SHA-1 computed hash). `git ls-tree <commit hash>` shows that.
* A blob represents file contents without metadata.
* There are three kinds of objects in git (commits, trees and blobs). All of them are stored in gits object datadase.
* A commit is a snapshot of the project with a SHA1 hash ID
* A branch is a reference to a commits ID !!!
* Check this amazing Git [tutorial](https://www.youtube.com/watch?v=RxHJdapz2p0) for more ...

<br>

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/2d6fe441-b521-445c-928e-d4dfd3f815c5">

### 04.03.2024

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/Git">GIT</a>

* `git commit -avm "message"` nice way to skip the staging area (`a` flag includes all changed files), include (the `v` flag) the code differences in a commit and add a message (`m` flag)
* `git rm --cached <filename>` will remove a specified file from the staging area and move it bacj to the working area
* `git log -p -2` shows the difference (`-p` the patch output) introduced in each commit and limits the number of log entries displayed (`-2` flag)

### 01.03.2024

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/VIM">VIM</a>

* `ctrl r` Redo Changes. The redo feature is the oposite of undo (allows you to reverse the previous action)

<br>

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/TMUX">TMUX</a>

Sourcing the ~/.tmux.conf file requires a different command compared to other dotfiles (configuration files with a leading dot in their names).

```bash
tmux source-file ~/.tmux.conf
```

TMUX basic commands (MAC)

* `ctrl a` or `ctrl t` prefix (needed for all command to follow)

* `ctrl b` + `shift %` splitting panes left and right
* `ctrl b` + `shift "` splitting panes top and down
* `ctrl b` + `arrow keys` navigating between panes down
* `ctrl d` close a pane or type `exit`
* `ctrl b` + `c` creating a new window (window contains pains)
* `ctrl b`+ `n` switch to the next window
* `ctrl b`+ `p` switch to the previous window
* `ctrl b`+ `o` switch between panes
* `ctrl b`+ `d` detach from a session (everything will still run in the background)

* `tmux ls` List the currently running sessions
* `tmux attach -t <sessionNumber>` attacht to a specific session number (presented by `tmux ls`¡¡¡)
* `tmux new -s <sessionName>` attacht to a specific session
* `tmux rename-session -t 0 <sessionName>` rename a session using its number

[↑ Übersicht](#codenewbie)

---

## Februar 2024

### 29.02.2024

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/blob/main/Terminal">TERMINAL</a>

Terminal Keybindings

* `ctrl a` moves the cursor at the beginning of the line
* `ctrl e` moves the cursor at the end of the line
* `ctrl b` moves the cursor to the left
* `ctrl f` moves the cursor to the right

<br><br>

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/tree/main/JAVA">JAVA</a>

In Java, directly printing an array with System.out.println() will not print the contents of the array but will print its hashcode instead. To print the contents of the array, you need to use `Arrays.toString()` method from the `java.util.Arrays` class.

```java
System.out.println(Arrays.toString(array));
```

<br><br>

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/blob/main/Terminal">TERMINAL</a>

SSH learning session and some bulletpoints for me to remember.

* SSH connection is implemented using a client-server model
* remote machine must be running a piece of software called an SSH daemon
* The user’s computer must have an SSH client
* passwords (less secure and not recommended) or SSH keys, which are very secure
* always setting up SSH key-based authentication for most configurations
* user must have an SSH key pair locally.
* public key must be copied to `~/.ssh/authorized_keys` on remote server

### 28.02.2024

> <a href="https://github.com/GrigorijSchleifer/codeNewbie/blob/main/Terminal">TERMINAL</a>

`ctrl a` moves the curser to the end of the line and `ctrl e` moves it  to the beginning of the line.

<br><br>

> MAC

Reverse delete. Or some other name for deleting stuff to the right of the cursor. By typing `cntr d` ... baaaam!

<br><br>

> GIT

The `.gitignore` file contains names of folders and other files that Git ignores. These files are not automatically added to the staging area or included in commits. However, entries starting with an exclamation mark ("!") are an exception. These files will be included in a commit even though they are inside a folder that is otherwise ignored.

```bash
# file in out/ are excluded except `**/src/main/**/out/` and `**/src/test/**/out/`
out/
!**/src/main/**/out/
!**/src/test/**/out/
```

### 26.02.2024

> VIM

This one is amazing! Enter the command mode by pressing `:` and use `up` or `down` keys to see your old commands. This will save me so much time!!!

> Terminal

Amazing way to use the last command. Just type `!!` and hit `tab` or `enter`. Even better if you like to use the command befor your last entry just type `!-2`. Or `!-4` and so on. Cool right!

### 25.02.2024

> IntelliJ

* Typing `/**` + then pressing `Enter` above a method signature will create Javadoc stubs
* 'live templates' to generate several types of code snippets. `fori` for a for loop. Similar to `sout` for the print statement.

> VSCode

Adding code snippets. Handy!

```bash
# open command palette
shift option P
```

<br><br>

Paste *configure user snippets*. Amazing video [HERE](https://www.youtube.com/watch?v=TGh2NpCIDlc)

<br><br>

<img width="812" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/176a7f82-f6e6-48e0-b2ad-4e26212dfe26">

[↑ Übersicht](#codenewbie)

---

## Oktober 2023

### 19.10.2023

#### VS Code: CodeSnap - a nice extension to visualize code snippets
#### After installation just highlight your code, right click and there you have it!

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/03085d7f-4f56-41d3-bc52-b75e7dc029a1">

### 17.10.2023

#### Terminal > Homebrew: I didn't know that homebrew doesn't automatically uninstall old packages, so you'll need to do it yourself.

```command line
brew cleanup
```

### 12.10.2023

#### iTerm: Customizing terminal prompt (PS1) with emojis to add a touch of personalization

<br>

```code
I use agnoster theme for my iTerm2 terminal and settings to that theme can be found at this location ~/.oh-my-zsh/themes/agnoster.zsh-theme

My goal was to get rid of the user and hostname display and replace it with some fancy emojis.
```

Before that the settings looked like this.

<img width="1013" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/9a171b16-9851-4908-81e6-229749c60b4a">

After the edit:

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/a0276f75-ac23-4481-944e-8942df89f561">

<br>

```code
Don't forget to include the source ~/.oh-my-zsh/themes/agnoster.zsh-theme command in your .zshrc. Otherwise, after the terminal session is closed, your changes will disappear.
```

### 02.10.2023

#### Fastest way to insert google docstrins so far. Install autoDocstring extension for vsCode. Press `cmd-shift-2` below your funcition definition

<img width="777" alt="image" src="https://github.com/GrigorijSchleifer/codeNewbie/assets/36699154/9ea7eb10-e568-4e2a-b5df-345d4c4c1aa4">

### 01.10.2023

RStudio: Switching between the console and the code editor without using your mouse (Mac)

```command line
ctrl 1 (for code editor)
ctrl 2 (for console)
```

[↑ Übersicht](#codenewbie)

---

## September 2023

### 26.09.2023

#### **Jupyter notebook:** *Revamping Escape in Google Colab: A Vim-tastic Adventure!*

```txt
# press : to switch to command mode then type
:imap kj <Esc>
```

[↑ Übersicht](#codenewbie)

---

## Februar 2023

### 27.02.2023

<details>
  <summary>Restart terminal session</summary>

<br>

```
Sometimes I would like to terminate my zsh session. To do so, just type:
```

<br>

</details>

### 26.02.2023

<details>
  <summary>Declaring environment variables</summary>

<br>

```
Environment variables are useful, even for me. Often I need to check the home directory (HOME) or the shell
that is actually running (SHELL) and being able to modify this environment variables is important.
```

<br>

```console
# this will change the default list of options for the less command
declare -x LESS="-iqM"
```

</details>

### 24.02.2023

<details>
  <summary>Quots do matter in bash</summary>

<br>

```
Hey, this is a cool one. I thougut that double quotes and single quote can be used interchangeably in bash but no! BASH does not expand variables inside single quotes ... what a nice pearl!
```

<br>

<img width="653" alt="image" src="https://user-images.githubusercontent.com/36699154/221005253-1e96958e-1c12-43cc-9908-da73207d321e.png">

</details>

### 21.02.2023

<details>
  <summary>Stopwords</summary>

<br>

```
This is a link to a page with a collection of stopwords for 40 different languages.
```

<br>

[Stopwords](https://www.ranks.nl/stopwords/)

</details>

### 20.02.2023

<details>
  <summary>Display avalable functions in iterm (zsh) </summary>
<br>

```
Hey, what is cookin ... I am adding some more functions to my bash. A neat new way to display all avalable function inside terminal is:
```

```console
declare -f
```

```
This command will show a huge amount of functions and if you would like to limit the output to only one terminal page than pipe the output
of declare into less
```

```console
declare -f | less
```

```
You can move to the next matched pattern by pressing the n key or move back to the previous match by pressing the N (shift+n) key.
```
</details>

<details>
  <summary> Get the newest ruby version (Jekyll static webpage installation)</summary>
<br>

```
I want a static webpage where I write about coding and collect my thougts. But, somehow I was not able to get Jekyll installd. And this was because of my ruby environment on Mac. I spent almost a day figuring out why I was not able to install the bundler gem (not sure yet what gem and bundler are) and found this amazing tutorial:
```
<br>

[The fastest and easiest way to install Ruby on a Mac in 2023](https://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/#configure-your-shell)

</details>

### 16.02.2023

#### Showing PATH like a pro

```
Hey, what's up fellas. I'm trying to install Jekyll for running my own technical blog for doctors, but unfortunately
I'm not able to update Ruby ... somehow I am stuck on an older version and don't know why I get a bunch of errors ...
So while I'm trying to stay calm instead of throwing my Mac out of the OR, I found this little snippet that shows my PATH
in a nice, concise way. Check it out ... and  yes, my PATH <br> is messed up ... the next ToDo is already planned ...
see you later ... and as always ... sorry for my gebrochen english
```

[Link to a similar but more sophisticated tutorial](https://chriswarrick.com/blog/2018/09/04/python-virtual-environments/)

```console
echo $PATH | sed 's/:/\n/g' | uniq -c
```
<img width="592" alt="image" src="https://user-images.githubusercontent.com/36699154/219898860-c4a478fe-f788-4419-956c-d2b80a389d97.png">

#### Bringing virtualenv to the next level

```
I am still new to virtual environment world but I already know that you must use virtual environments for your project
to separatte stuff ... so I was wondering where I should create all my environments ... I know I have only a few but it
turns out you should store the env's in ~ (your homne directory) ... oh Meister I hope it is true ...
```
```console
# step I
mkdir ~/virtualenvs
# step 2
python -m virtualenv venv_name
# step 3
source venv_name/bin/activate
```
```
But the coolest thing ever ... you can save time by adding a function to your .zshrc and just use the funciton name plus the name of the environment to activate it ... niiiice
```
```bash
# add this to your .zshrc or .bashrc

export WORKON_HOME=~/virtualenvs # this is where you will store all your environments

 function workon {
     source "$WORKON_HOME/$1/bin/activate"
 }
```

```console
# to activate a environment just type
workon env_name
```

### 14.02.2023

```bash
!!
```

### 13.02.2023

```
Reverse search for terminal commands you have typed so far
```

```bash
ctrl r
# by pressing this again next command will be displayed
# by the way the same command in vim is used to redo the last change :)
```

### 10.02.2023

```
Finding manuals to a certain terminal command by keyword lookup
```

```bash
$ man -k 'keyword'

# when command is found and manual is open use /MANUALSECTION to open up this explicit section
```

### 07.02.2023

```bash
>> Run shell session as root
```

```bash
# -s flag tells sudo to run shell as root
sudo -s
```
<br>

```console
# Installing venv on Debian (like my remote server) or Ubuntu
sudo apt-get install python3-venv
```

```bash
# command to intall and upgrade the "pip" package manager to the latest version only for the current user
# -m: This option is used to run a module (pip in this case) as a script
# !!! Only ever use your system package manager to upgrade the system pip !!!
python3 -m pip install --user --upgrade pip

# installing virtualenv
python3 -m pip install --user virtualenv

# creating virtual environment for jekyll static web page development
python3 -m virtualenv jekyll_env
```

### 04.02.2023

<details>
  <summary>Create a user on remote server and grand superuser privileges</summary>
<br>

```bash
# following this tutorial
# https://linuxize.com/post/how-to-add-user-to-sudoers-in-ubuntu/

# create a new user
createuser name_of_user

# Adding user to the sudoers group (root). This will avoid having to log out of our normal user and log back in as the root account.
# This will give or user superuser or root privileges allow our normal user to run commands with administrative privileges by putting the word sudo before the command.
# To add these privileges to our new user, we need to add the user to the sudo group.
usermod -aG sudo name_of_user

# see where linux stores the passwords
vim ect/passwd
```
<br>
</details>

### 03.02.2023

```code
hostnamectl
```

```bash
# Show information about the host (server)
  Static hostname: vps40009.alfahosting-vps.de
         Icon name: computer-container
           Chassis: container
        Machine ID: ***
           Boot ID: ***
    Virtualization: openvz
  Operating System: Debian GNU/Linux 10 (buster)
            Kernel: Linux 4.19.0
      Architecture: x86-64

```

```code
SSH configuration on my blink app
```

```
Victor Geislinger - Setting up SSH keys for GitHub - Video

# -t ed25519 is the newest type of encryption that will be used to generate the key
# the key will be stored in ~/.ssh/id_ed25519 (default location)
# https://www.ssh.com/academy/ssh/keygen (nice tutorial)
ssh-keygen -t ed25519 -C your-git-mail

# starting the ssh agent
# Here we let computers ssh agent know about the key (like a wallet thes stores the key)
eval "$(ssh-agent -s)"

# adding private key to the ssh agent (like putting the id into the wallet)
touch ~/.ssh/config

# adding that file to ssh
ssh-add ~/.ssh/id_ed25519

# showing the public key that will be added to githubs
cat ~/.ssh/id_ed25519.pub

# check if authentication was successful
# Hi GrigorijSchleifer! You've successfully authenticated, but GitHub does not provide shell access.
ssh -T git@github.com
```

```console
ssh -T git@github.com
```

### 02.02.2023

####  Amazing and easy to use ressource to generate README profile for github

https://rahuldkjain.github.io/gh-profile-readme-generator/

#### Holy cow! This code when placed in vscodes settings.json will let you move lines vertically in normal mode
#### I searched for this for soo long ...

```json
 "vim.normalModeKeyBindingsNonRecursive": [
    {
        "before": ["J"],
        "commands": ["editor.action.moveLinesDownAction"]
    }, // moveLineDown
    {
        "before": ["K"],
        "commands": ["editor.action.moveLinesUpAction"]
    } // moveLineUp
],
```

### 01.02.2023

```console
lazygit "commit message"
```

[↑ Übersicht](#codenewbie)
