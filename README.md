# Build GnuCash in a Container

Build GnuCash with python bindings for data file manipulation.

## Build
* `docker build -t gnucash .`

## Run
* `docker run -it -v /your_gnucash_dir:/root/gnucash cliffchen/gnucash`

## Python scripts example
* See https://github.com/Gnucash/gnucash/tree/maint/bindings/python/example_scripts
