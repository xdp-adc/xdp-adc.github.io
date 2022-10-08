XDP-ADC: Get Started with Azure Web Apps
========================================

Getting started with XDP-ADC is as simple as dropping our daemon into your service or stack. Once we’re in, XDP-ADC protects your system based on the configured security rules.

Below are instructions for installing the XDP-ADC in your staging or production environment in Azure App Service. To use XDP-ADC, you’ll need to be in our beta.

You will be setting up the XDP-ADC Daemon to run within your custom Linux container. To set up the XDP-ADC Daemon you will:

1. Create an XDP-ADC Project
2. Generate an API key for the XDP-ADC Daemon
3. Install the XDP-ADC Daemon in your container
4. Run the XDP-ADC Daemon
5. Configure your XDP-ADC API key in the App Service configuration
6. Launch the new container
7. Verify that the XDP-ADC Daemon is working

Create a project
****************

Do we have a project concept?


Generate API key
****************

As the question above?


Install Daemon in container
***************************

Install the XDP-ADC Daemon during your container build process by running the install script below, adding it to your Dockerfile, or manually downloading the Debian package from our repository.

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

Next, change your container's default command to the XDP-ADC Daemon by adding the below to your Dockerfile. Use the project name you created earlier on the XDP-ADC console.

.. code-block:: bash
    :linenos:

    CMD ["/usr/local/bin/xdpadc", "--project", "<your project name>", \
     "-u", "root", "-c", "<your normal commnand line>"]


Run with script
***************

If your normal entry point is a script, you can run the XDP-ADC as a background process. Run :code:`xdpadc --project <your_project_name>` in the background. 

Configure API key
*****************

The XDP-ADC Daemon needs to access the API Key you created earlier. The best way to set the API key is by an environment variable passed in to the container. 

In the Azure web interface, you can configure the environment variables by navigating to Settings > Configuration > Application settings. Add new application settings named :code:`XDPADC_API_KEY_ID` and :code:`XDPADC_API_KEY_SECRET` and enter your API key ID and key secret. These values will be securely added to the environment variables in the container.

Launch Container
****************

After adding the XDP-ADC API key, build your new container, add it to your normal repository, and restart your application in Azure App Service. This will cause Azure to pull the new version of the container, and the Akita Agent will start sending data.

Verify
******

The XDP-ADC daemon should now see all data coming to the app or service running in the specified container, and protect you when suspicious packts are detected.

To make sure the XDP-ADC daemon is running correctly, you can always use the following command:

.. code-block:: bash
    :linenos:

    xdpadc logs
