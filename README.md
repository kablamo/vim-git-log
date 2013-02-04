vim-ribbon
==========

vim-ribbon is a Vim plugin that helps you read through the latest changes to a
git repository.  This plugin requires
[Fugitive](https://github.com/tpope/vim-fugitive).

How to use it
-------------

**First** mark your place with

    :RibbonSave

This will place a tag named __ribbon at origin/master.  Basically you are
bookmarking our current spot with a 'ribbon'.

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

You can view the side by side diff of any modified file by putting your cursor
on that line and typing 'd' (for diff).  To exit out of the diff and return to
the 'Ribbon' window, type 'q'.

**Finally**, after you have reviewed all the changes, mark your place again with:

    :RibbonSave


Pro tips
--------

The default colors used in vimdiff were created by insane clowns.  You might
like my colorscheme instead:

    ⚡ mkdir -p ~/.vim/colors/
    ⚡ wget https://github.com/kablamo/dotfiles/blob/master/links/.vim/colors/iijo.vim -O ~/tmp/iijo.vim
    ⚡ echo "colorscheme iijo" >> ~/.vimrc

How to use vimdiff:
 - To switch windows type `ctl-w l` and `ctl-w h`.  For more help see `:help window-move-cursor`.
 - To open and close folds type `zo` and `zo`.  For more help see `:help fold-commands`.

See also
--------

This script was inspired by
http://gitready.com/advanced/2011/10/21/ribbon-and-catchup-reading-new-commits.html

I also wrote [git-ribbon](https://github.com/kablamo/git-ribbon), a little Perl
script with pretty much the same purpose.
