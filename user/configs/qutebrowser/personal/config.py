from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer

config:ConfigAPI = config
c:ConfigContainer = c

config.load_autoconfig(False)

# searchengines
c.url.searchengines = {
        "DEFAULT": "https://duckduckgo.com/?q={}",
        "!go": "https://google.com/?q={}",
        "!yt": "https://www.youtube.com/results?search_query={}",
        }

base_url = "https://duckduckgo.com/"
c.url.default_page = base_url
c.url.start_pages = [base_url]

# downloads folder
c.downloads.location.directory = "/home/juselara/downloads"

# colors

# everforest medium
t = {
        "fg": "#d3c6aa",
        "red": "#e67e80",
        "orange": "#e69875",
        "yellow": "#dbbc7f",
        "green": "#a7c080",
        "aqua": "#83c092",
        "blue": "#7fbbb3",
        "purple": "#d699b6",
        "grey0": "#7a8478",
        "grey1": "#859289",
        "grey2": "#9da9a0",
        "statusline1": "#a7c080",
        "statusline2": "#d3c6aa",
        "statusline3": "#e67e80",
        "bg_dim": "#232a2e",
        "bg0": "#2d353b",
        "bg1": "#343f44",
        "bg2": "#3d484d",
        "bg3": "#475258",
        "bg4": "#4f585e",
        "bg5": "#56635f",
        "bg_visual": "#543a48",
        "bg_red": "#514045",
        "bg_green": "#425047",
        "bg_blue": "#3a515d",
        "bg_yellow": "#4d4c43",
        }

c.colors.webpage.bg = t["bg0"]

c.colors.keyhint.fg = t["fg"]
c.colors.keyhint.suffix.fg = t["red"]

c.colors.messages.error.bg = t["bg_red"]
c.colors.messages.error.fg = t["fg"]
c.colors.messages.info.bg = t["bg_blue"]
c.colors.messages.info.fg = t["fg"]
c.colors.messages.warning.bg = t["bg_yellow"]
c.colors.messages.warning.fg = t["fg"]

c.colors.prompts.bg = t["bg0"]
c.colors.prompts.fg = t["fg"]

c.colors.completion.category.bg = t["bg0"]
c.colors.completion.category.fg = t["fg"]
c.colors.completion.fg = t["fg"]
c.colors.completion.even.bg = t["bg0"]
c.colors.completion.odd.bg = t["bg1"]
c.colors.completion.match.fg = t["red"]
c.colors.completion.item.selected.fg = t["fg"]
c.colors.completion.item.selected.bg = t["bg_yellow"]
c.colors.completion.item.selected.border.top = t["bg_yellow"]
c.colors.completion.item.selected.border.bottom = t["bg_yellow"]

c.colors.completion.scrollbar.bg = t["bg_dim"]
c.colors.completion.scrollbar.fg = t["fg"]

c.colors.hints.bg = t["bg0"]
c.colors.hints.fg = t["fg"]
c.colors.hints.match.fg = t["red"]
c.hints.border = "0px solid black"

c.colors.statusbar.normal.fg = t["fg"]
c.colors.statusbar.normal.bg = t["bg3"]

c.colors.statusbar.insert.fg = t["bg0"]
c.colors.statusbar.insert.bg = t["statusline1"]

c.colors.statusbar.command.fg = t["fg"]
c.colors.statusbar.command.bg = t["bg0"]

c.colors.statusbar.url.error.fg = t["orange"]
c.colors.statusbar.url.fg = t["fg"]
c.colors.statusbar.url.hover.fg = t["blue"]
c.colors.statusbar.url.success.http.fg = t["green"]
c.colors.statusbar.url.success.https.fg = t["green"]

c.colors.tabs.bar.bg = t["bg_dim"]
c.colors.tabs.even.bg = t["bg0"]
c.colors.tabs.odd.bg = t["bg0"]
c.colors.tabs.even.fg = t["fg"]
c.colors.tabs.odd.fg = t["fg"]
c.colors.tabs.selected.even.bg = t["bg2"]
c.colors.tabs.selected.odd.bg = t["bg2"]
c.colors.tabs.selected.even.fg = t["fg"]
c.colors.tabs.selected.odd.fg = t["fg"]
c.colors.tabs.indicator.start = t["blue"]
c.colors.tabs.indicator.stop = t["green"]
c.colors.tabs.indicator.error = t["red"]

# permissions
c.content.autoplay = True 

# custom hints
c.hints.chars = "htnsueoai"
c.hints.find_implementation = "javascript"

# fonts
c.fonts.default_family = "monospace regular"
c.fonts.completion.category = "bold default_family"
c.fonts.completion.entry = "12pt default_family"
c.fonts.debug_console = "12pt default_family"
c.fonts.downloads = "12pt default_family"
c.fonts.hints = "bold 12pt default_family"
c.fonts.keyhint = "12pt default_family"
c.fonts.messages.error = "12pt default_family"
c.fonts.messages.info = "12pt default_family"
c.fonts.messages.warning = "12pt default_family"
c.fonts.prompts = "12pt default_family"
c.fonts.statusbar = "12pt default_family"

# editor
c.editor.command = ["alacritty", "-e", "nvim", "{}"]

# binds
config.bind(",v", "hint links spawn mpv {hint-url}")
