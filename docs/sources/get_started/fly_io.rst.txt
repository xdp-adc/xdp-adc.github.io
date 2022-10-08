XDP-ADC: Getting Started with Fly.io
====================================

Getting started with Linux with XDP-ADC is as easy as running a Linux daemon program in your VM or machine. Once the daemon program is up and running, XDP-ADC is protecting the system.

Below are instructions for installing the XDP-ADC daemon in your staging or production environment in Fly.io using a Dockerfile. You will need to be in our beta.

Create a project
****************

Do we have a project concept?


Generate API key
****************

As the question above?


Install Daemon in container
***************************

To install the XDP-ADC daemon using bash run the following:

.. code-block:: bash
    :linenos:

    bash -c "$(curl -L https://releases.xdpadc.com/scripts/install_xdpadc.sh)"


Run Daemon
**********

There are two options for running the XDP-ADC Daemon:

1. Modify the entry point in your Dockerfile, or
2. Via a script


Run with Dockerfile
*******************

Next, change your container's default command to the XDP-ADP daemon by adding the below to your Dockerfile. Use the project name you created earlier on the XDP-ADC console.

.. code-block:: Dockerfile
    :linenos:

    CMD ["/usr/local/bin/xdpadc", "--project", "<your project name>", \
     "-u", "root", "-c", "<your normal command line>"]


Run with script
***************

If your normal entry point is a script, you can run the XDP-ADC daemon as a background process. Run :code:`xdpadc --project <your_project_name>` in the background. 


Configure API key
*****************

The XDP-ADC Daemon needs to access the API Key you created earlier. The best way to set the API key is using a Secret, which is passed as an environment variable to the container.

From the command line, add new secrets called :code:`XDPADC_API_KEY_ID` and :code:`XDPADC_API_KEY_SECRET` with your key's values filled in:

.. code-block:: bash
    :linenos:

    flyctl secrets set XDPADC_API_KEY_ID=apk_xxxxxxx
    flyctl secrets set XDPADC_API_KEY_SECRET=xxxxxxxxxx

You will see a hashed version of the secret in your Fly.io activity log.


Launch Container
****************

After adding the XDP-ADC API key, use flyctl deploy (for an existing application) or flyctl launch (for a new one). This will build the new version of the container that contains the XDP-ADC Daemon, and deploy it to Fly.io as a new revision of your application.


Verify
******

You will be able to use the following command to check the logs of XDP-ADC daemon. Once you see ***XDP-ADC reports for duty...*** in the logs, it's running successfully.

.. code-block:: bash
    :linenos:

    xdpadc logs

.. toctree::
   :maxdepth: 2
   :caption: Contents:
