XDP-ADC: Getting Started with Docker
====================================

Getting started with XDP-ADC is as simple as dropping our daemon into your service or stack. Once we’re in, XDP-ADC protects your system based on the configured security rules. 

Below are instructions for installing the XDP-ADC daemon on a staging or production Docker container that has access to the public internet. You will need to be in our beta to use this.

Create a project
****************

Do we have a project concept?


Generate API key
****************

As the question above?

Attach Daemon
*************

To attach the XDP-ADC daemon to your Docker container, your container must a.) be connected to the public internet, and b.) be running. Then:

1. Start your service via :code:`docker run` or :code:`docker-compose`.
2. Locate the name of the container where the app, service, or API you want to monitor is running.
3. Start the XDP-ADC daemon and specify the container’s network stack with the command below:

.. code-block:: bash
    :linenos:

    docker run --rm --network container:your-container-name \
     -e XDPADC_API_KEY_ID=... \
     -e XDPADC_API_KEY_SECRET=... \
     xdp-adc/cli:latest \
     --project your-project-name

Verify
******

The XDP-ADC daemon should now see all data coming to the app or service running in the specified container, and protect you when suspicious packts are detected.

To make sure the XDP-ADC daemon is running correctly, you can always use the following command:

.. code-block:: bash
    :linenos:

    xdpadc logs

.. toctree::
   :maxdepth: 2
   :caption: Contents:
