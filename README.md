# d e t e r m i n a t i o n

Displays an encouraging message when things don't go as expected. Don't let your terminal let you give up!

![Determination](http://i.giphy.com/3oxRmh6RObIqfhF7ag.gif)

### Installation

```bash
$ stack install
```

### Suggested Usage

One thing I do often while working on a computer that fails a lot is compilation.

To build and register this project, I run one command:

```
$ stack install
```

but, when I need to make changes, compilation often fails for some reason or another.

For example, imagine I added this to `Determination.hs`:

```
someExtraThing :: Bool
someExtraThing = 1
```

```
$ stack install
determination-0.1.0.0: unregistering (local file changes: src/Determination.hs)
determination-0.1.0.0: build
Preprocessing library determination-0.1.0.0...
[1 of 1] Compiling Determination    ( src/Determination.hs, .stack-work/dist/x86_64-osx/Cabal-1.22.4.0/build/Determination.o )

/Users/Ben/determination/src/Determination.hs:55:18:
    No instance for (Num Bool) arising from the literal ‘1’
    In the expression: 1
    In an equation for ‘someExtraThing’: someExtraThing = 1

--  While building package determination-0.1.0.0 using:
      /Users/Ben/.stack/setup-exe-cache/x86_64-osx/setup-Simple-Cabal-1.22.4.0-ghc-7.10.2 --builddir=.stack-work/dist/x86_64-osx/Cabal-1.22.4.0 build lib:determination exe:determination --ghc-options " -ddump-hi -ddump-to-file"
    Process exited with code: ExitFailure 1
```

```
.----.     .--.     .----.    .-. .-.   .----.    .----.    .----.
{ {__      / {} \    | {}  \   |  `| |   | {_     { {__     { {__  
.-._} }   /  /\  \   |     /   | |\  |   | {__    .-._} }   .-._} }
`----'    `-'  `-'   `----'    `-' `-'   `----'   `----'    `----'
.----.   .-. .-.    .----.   .-. .-.   .----.    .----.            
| {_     |  `| |   { {__     | { } |   | {_     { {__              
| {__    | |\  |   .-._} }   | {_} |   | {__    .-._} }            
`----'   `-' `-'   `----'    `-----'   `----'   `----'             
```

Instead, let's wrap it with `determination` in a Makefile:

```
install:
  determination "stack install"
```

#### Special Thanks

To Toby Fox for undertale, which inspired this.
