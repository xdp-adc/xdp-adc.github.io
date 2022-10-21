XDP-ADC: Getting Started with Linux-based virtual machines or bare-metal
========================================================================

Getting started with Linux with XDP-ADC is as easy as running a Linux daemon program in your VM or machine. Once the daemon program is up and running, XDP-ADC is protecting the system.

Below are instructions for installing the XDP-ADC daemon program in any Debian Linux environment. You’ll need to be in our beta to use this.

Installation Steps
******************

After joining our beta program, all you need to do is to use any of the commands below to install the Linux daemon program.

Using bash
**********

To install the XDP-ADC daemon using bash run the following:

.. code-block:: bash
    :linenos:

    bash -c "$(curl -L https://releases.xdpadc.com/scripts/install_xdpadc.sh)"

Using APT
*********

To install the daemon using APT, first add XDP-ADC Software’s apt repository by adding the following to the source list:

.. code-block:: bash
    :linenos:

    deb [arch=amd64] https://apt.releases.xdpadc.com/ stable main

Then add Aktia’s public key to APT’s trusted key list by running the following:

.. code-block:: bash
    :linenos:

    curl -f https://releases.xdpadc.com/keys/xdpadc-apt.public | sudo apt-key add -

Then run :code:`apt-get-update` or :code:`apt-get install xdpadc` to install the latest version of the XDP-ADC daemon.

Login
*****

To log in to XDP-ADC, run the following and enter your XDP-ADC API key ID and key secret when prompted:

.. code-block:: bash
    :linenos:

    xdpadc login

Start daemon
************

Then start the XDP-ADC daemon by running the below command.

.. code-block:: bash
    :linenos:

    sudo xdpadc apidump --project [your_project_name]

verify
******

You will be able to use the following command to check the logs of XDP-ADC daemon. Once you see ***XDP-ADC reports for duty...*** in the logs, it's running successfully.

.. code-block:: bash
    :linenos:

    xdpadc logs

Starting daemon on system boot
******************************

The APT package that you installed above has a systemd service file for integrating XDP-ADC daemon into systemd. To start the daemon on system boot:

- Edit :code:`/etc/default/xdpadc-daemon` to configure the service. This file should be self-explanatory. You will need to configure the API key and any command-line arguments for the CLI. An example is given below. The existing comments in the file are elided for brevity.

.. code-block:: bash
    :linenos:

    XDPADC_API_KEY_ID=apk_XXXXXXXXXXXXXXXXXXXXXX
    XDPADC_API_KEY_SECRET=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    PROJECT_NAME=my-project

- Once configured, have systemd read the new configuration:

.. code-block:: bash
    :linenos:

    sudo systemctl daemon-reload

- You can then start and enable the XDP-ADC daemon service in the usual manner: 

1. :code:`systemd start xdpadc` will start the XDP-ADC daemon running as a service.
2. :code:`systemd enable xdpadc` enables the service to start on boot.
3. :code:`systemd status xdpadc` checks the status of the service.
4. :code:`systemd restart xdpadc` restarts the service.

.. toctree::
   :maxdepth: 2
   :caption: Contents:
