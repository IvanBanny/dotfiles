# Kitty configuration

Requires kitty 0.48.2+, Ubuntu Sans Mono, and less.

Reload with Ctrl+Shift+F5. History limits apply to new panes.

## Shortcuts

| Shortcut | Action |
| --- | --- |
| Ctrl+Shift+O / E | Split top/bottom / side by side |
| Ctrl+Shift+A or Enter | Split along the best-fitting axis |
| Alt+H/J/K/L | Focus left/down/up/right |
| Ctrl+Tab / Ctrl+Shift+Tab | Next/previous pane |
| Ctrl+Shift+H/J/K/L | Make active pane narrower/shorter/taller/wider |
| Ctrl+Alt+0 | Reset pane sizes |
| Alt+Shift+H/J/K/L | Move pane left/down/up/right |
| Ctrl+Alt+R / Ctrl+Alt+Shift+R | Rotate current split / rotate back |
| Ctrl+Shift+X or Z | Maximize pane / restore splits |
| Alt+E | Searchable command palette, including layout actions |
| Ctrl+Shift+Space | Cycle splits, stack, tall, grid layouts |
| Ctrl+Shift+T | New tab in current directory |
| Ctrl+PageUp / PageDown | Previous/next tab |
| Ctrl+Shift+PageUp / PageDown | Move tab left/right |
| Alt+1 through Alt+9 | Select tab by number |
| Ctrl+Alt+A | Rename tab |
| Ctrl+Shift+I | New OS window in current directory |
| Ctrl+Shift+W | Close pane, confirming if a program is running |
| Ctrl+Shift+Q | Close OS window, confirming if programs are running |
| F11 | Fullscreen |
| Ctrl+Plus / Minus / 0 | Increase/decrease/reset font size |
| Ctrl+Shift+C / V | Copy/paste |
| Ctrl+Shift+F | Search scrollback |
| Ctrl+Alt+H | Browse scrollback |
| Ctrl+Alt+G | Browse last command's output |
| Ctrl+Alt+Up / Down | Previous/next command prompt |
| Shift+PageUp / PageDown | Scroll by a page |
| Ctrl+Shift+Home / End | Start/end of interactive history |
| Ctrl+Alt+U | Select a visible URL by its keyboard hint |
| Ctrl+Shift+P, then F / W / L | Insert a visible path / word / line |
| Ctrl+Shift+R | Reset terminal state |
| Ctrl+Shift+G | Clear screen, preserving history |
| Ctrl+Shift+F2 / F5 / F6 | Edit / reload / inspect configuration |

Pager: `/` searches, `n`/`N` repeat, `q` returns to the shell. Search is
case-insensitive unless the pattern contains uppercase letters.

History: 100,000 scrollable lines and 256 MB of pager history per pane. Older
output is available in the pager only. Closing a pane discards its history.

For SSH hosts missing kitty's terminfo, use `kitten ssh user@host`.
