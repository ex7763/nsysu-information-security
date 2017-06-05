#!/bin/bash

sbcl < sample.lisp
read
rm -f *Key *SIG_CHECK_FILE sig-* *.aes un_*.aes