## Welcome to my vim configs!

Ignore the [pluginstuff](pluginstuff.vim) file. It's outdated and (pretty sure) isn't doing anything.

Git will auto-ignore plugin/packer_compiled.lua because I told it to.

But first, a brief summary:

## The colorscheme

It's my own invention. Well, to be precise, I took some random poor soul's colors and added my own on top. None of the "good" "flashy" colorschemes look good to me. They all look like Doom Emacs, which is its own look, but they're trying too hard. If you are going with a medium gray background and assigning a light palette around that, you've already lost me. Not a single other colorscheme I've found for vim avoids this pitfall.

## The rebinds

Mostly common-sense things, the likes of which are recommended in vim beginner guides across the Web. In general, nvim is vim is vi is ex is ed, so it's basically perfect already. We're just using it wrong. Read [maps.vim](plugin/maps.vim) for what I actually do change.

## The lets and sets

Swapfiles are fake and gay. I am merely fake, so I prefer undofiles instead. Put them in a dir. Other than that, same deal as the rebinds. Look at [slets.vim](plugin/slets.vim) for specifics.

## The plugins

No.
