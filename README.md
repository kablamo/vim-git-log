vim-git-log
==========

vim-git-log is a Vim plugin that helps browse your git log.  This plugin
requires [Fugitive](https://github.com/tpope/vim-fugitive).

GitLog
-------------

To open a new buffer which displays a list of the changes in your git repo:

    :GitLog

This plugin is basically a wrapper around `git log` so nearly any option or
argument that you can use with `git log` can be used here.  The exceptions are
--pretty and options that affect --pretty.  Here are some more examples:

View changes from the 'lib' directory instead of the repository root:

    :GitLog lib

View changes from a specifi author/committer:

    :GitLog --author Batman

View changes where the commit message matches a (PCRE) regular expression

    :GitLog --grep 'dinosaurs'

View changes for a date range

    :GitLog --since yesterday
    :GitLog --since '1 month 1 week 1 day 1 hour 1 second'
    :GitLog --since 2012-12-31
    :GitLog --until 2012-12-31 23:30:60
    :GitLog <since>..<until>


How to use the log browser
--------------------------

Running any of the above commands will open a window titled 'GitLog' that looks
like this and allows you to browse the git log:

    Eric Johnson 4 weeks ago 5ef0fb2
    Added daysPerYear.
    lib/Networth/Controller/Calculator.pm
    lib/Networth/Out/RealCost.pm
    root/html/calculator/realCost.tt

    Eric Johnson 5 weeks ago 9595fa0
    fix css margin class.
    root/css/networth.css
    root/css/style.less
    root/css/style.less.old
    root/html/calculator/realCost.tt
    root/html/fi.tt

    Eric Johnson 6 weeks ago ecf43db
    Css tweaks.
    root/html/calculator/realCost.tt

Here are some commands you can use in the browser:

   d     View the side by side diff of any file by putting your cursor on that
         line and typing `d` (for diff).

   <cr>  View the diffstat from `git show $revision` for that commit.

   n     Move your cursor to the first filename in the next commit.

   N     Move your cursor to the first filename in the previous commit.

   q     Quit.  Closes all the GitLog windows and buffers.


To quickly exit out of a side by side diff and return to the 'GitLog' window,
type `q`.


Ribbon
-------------

**First** mark your place with

    :RibbonSave

This will place a tag named __ribbon at origin/master.  Basically you are
bookmarking our current spot with a `ribbon`.

**Next**, use Fugitive to pull down the latest changes made by your fellow conspirators from the
remote repository.  

    :Git pull

To review those changes use the following command:

    :Ribbon

This will open a window titled 'Ribbon' that looks like this:

    Eric Johnson 6 weeks ago ecf43db
    Css tweaks.
    root/html/calculator/realCost.tt

    Eric Johnson 5 weeks ago 9595fa0
    fix css margin class.
    root/css/networth.css
    root/css/style.less
    root/css/style.less.old
    root/html/calculator/realCost.tt
    root/html/fi.tt

    Eric Johnson 4 weeks ago 5ef0fb2
    Added daysPerYear.
    lib/Networth/Controller/Calculator.pm
    lib/Networth/Out/RealCost.pm
    root/html/calculator/realCost.tt

See the section on *How to use the GitLog browser* for a complete list of all
the commands available to you. 

**Finally**, after you have reviewed all the changes, mark your place again with:

    :RibbonSave

Bonus tips
----------

The default colors used in vimdiff look like they were created by crazy clowns.
You might like my colorscheme instead:

    $ mkdir -p ~/.vim/colors/
    $ wget https://github.com/kablamo/dotfiles/raw/master/links/.vim/colors/iijo.vim -O ~/.vim/colors/iijo.vim
    $ echo "colorscheme iijo" >> ~/.vimrc

How to use vimdiff:
 - To switch windows type `ctl-w l` and `ctl-w h`.  For more help see `:help window-move-cursor`.
 - To open and close folds type `zo` and `zc`.  For more help see `:help fold-commands`.

See also
--------

This script was inspired by
http://gitready.com/advanced/2011/10/21/ribbon-and-catchup-reading-new-commits.html

I also wrote [git-ribbon](https://github.com/kablamo/git-ribbon), a little Perl
script that does pretty much the same thing but from the commandline.
