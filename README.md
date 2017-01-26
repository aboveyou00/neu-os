Neu-OS
======

Overview
--------

An operating system developed for the x86-64 written priarily in C.
Developed as a side project at Neumont University.

Installation
------------

Currently, the source code is designed to compile using the Bochs emulator in an Ubuntu Linux environment.
Download the source:

```
git clone http://github.com/aboveyou00/neu-os.git
cd neu-os
```

Install the required development tools. This may take a while.

```
bash ./scripts/dev-tools.sh
```

Build the source code using these development tools:
```
bash ./scripts/build.sh
```

Launch the Bochs emulator:

```
bash ./scripts/start.sh
```
