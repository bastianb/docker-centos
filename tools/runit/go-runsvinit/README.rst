Run sv services script
======================

source: https://github.com/peterbourgon/runsvinit

Run sv services using a bootstrap script to handle Signals when exiting docker containers with runit.
Take care of starting and shutting down gracefully services and zombies.

Build
-----
Requires go1.4

Install gvm (go version manager)
+++++++++++++++++++++++++++++++
1. Clone the Repo and Add to User Directory
    .. code:: bash

        # Install gvm in ~/.gvm
        bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

2. Open Your ~/.bashrc and Source the GVM Directory if not done
    .. code:: bash

        [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

3. Source gvm
    .. code:: bash

        source "~/.gvm/scripts/gvm"
        # or
        source ~/.bashrc

4. Check to Make Sure that GVM is Installed or install missing packages
    .. code:: bash

        gvm version

5. Install Go (Golang)
    .. code:: bash

        gvm listall
        gvm install go1.4.3

6. Tell GVM Which Version of Go to Use
    .. code:: bash

        gvm use go1.4.3

7. Verify Go Is Installed Correctly
    .. code:: bash

        go version

8. Installing Go 1.5 Might Take an Additional Step

    source: http://www.hostingadvice.com/how-to/install-golang-on-ubuntu/

    .. code:: bash

        gvm install go1.4
        gvm use go1.4
        export GOROOT_BOOTSTRAP=$GOROOT
        gvm install go1.5

Build the runsvinit
+++++++++++++++++++

.. code:: bash

    cd <root>/docker-centos/tools/runintgo-runsvinit/
    GOPATH=$(pwd)
    go install runsvinit
    # executable will be in ./bin/
