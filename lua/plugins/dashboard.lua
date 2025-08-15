local ascii_art = require('noahhan.ascii_art')

math.randomseed(os.time())

local garfield_quotes = {
    "I'm not overweight. I'm undertall.",
    "Diet is 'die' with a 't'.",
    "Love me, feed me, never leave me.",
    "I'll rise, but I won't shine.",
    "If you are patient… and wait long enough… Nothing will happen!",
    "I hate Mondays.",
    "I love lasagna!",
    "Show me a good mouser, and I'll show you a cat with bad breath.",
}

local random_index = math.random(#garfield_quotes)
print(garfield_quotes[random_index])
return {
    { 
        'nvim-tree/nvim-web-devicons' 
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup { 
                theme = 'doom',
                config = {
                    header = ascii_art.neogarf,
                    center = {
                        {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Lasagna Enter',
                        action = ':cd ~/github_projects | Ex',
                        },
                        {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Lasagna Rat',
                        action = ':cd ~/github_projects/rat_2.0 | Ex',
                        },
                        -- {
                        -- icon = ' ',
                        -- icon_hl = 'Title',
                        -- desc = 'Lasagna Spimbot',
                        -- action = ':cd ~/cs233/spimbot | Ex',
                        -- },
                        {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Lasagna Config',
                        action = ':cd ~/.config/nvim | Ex',
                        },
                        {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Lasagna Find',
                        action = ':cd ~/github_projects | Telescope find_files'
                        },
                        {
                        icon = ' ',
                        icon_hl = 'Title',
                        desc = 'Lasagna Quit',
                        action = ':q',
                        },
                    },
                   footer = { garfield_quotes[random_index] },
                },
            }
        end,
        dependencies = { {'nvim-tree/nvim-web-devicons'}}
    }
}
