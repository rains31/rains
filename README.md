## About

This is my personal vimrc that anyone can get it.

## Quick start

1. Get it:

     ```
     git clone https://github.com/icocoa/icocoa-vimrc.git
     ```
     It takes `vim vundle` with `git submodule`, if you want to use it:

     ```
     git submodule init
     git submodule update
     ```

2. Configure it:

    ```
    cp -a vimrc/.vim vimrc/.vimrc ~/
    ```
    before this, please backup your own data.

3. Update it:

    ```
    cd repo_dir
    git submodule foreach git pull origin master
    git submodule update
    ```
