## About

This is my personal vimrc that anyone can get it.

## Quick start

1. Get it:

     ```
     git clone https://github.com/icocoa/icocoa-vimrc.git vimrc
     ```
     It takes `vim vundle` with `git submodule`, if you want to use it:

     ```
     git submodule init
     git submodule update
     ```
     Or, maybe you would love to do it all by one step:
     ```
     git clone https://github.com/icocoa/icocoa-vimrc.git vimrc --recursive
     ```

2. Configure it:

    ```
    cp -a vimrc/.vim vimrc/.vimrc ~/
    ```
    before this, please backup your own data, then install bundles:
    ```
    vim +BundleInstall +qall
    ```

3. Update it:

    ```
    cd vimrc
    git submodule update
    ```
