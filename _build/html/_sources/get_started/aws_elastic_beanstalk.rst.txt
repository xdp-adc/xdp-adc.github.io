XDP-ADC: Get Started with AWS Elastic Beanstalk
===============================================

Getting started with XDP-ADC is as simple as dropping our daemon into your service or stack. Once we’re in, XDP-ADC protects your system based on the configured security rules.

Below are instructions for installing the XDP-ADC Daemon in your staging or production environment as a Docker container in AWS Elastic Beanstalk.

To set up the XDP-ADC Daemon on AWS Elastic Beanstalk, you must first set up XDP-ADC and then you can:

1. Use Docker Compose, or
2. Use a Dockerfile, or
3. Use Dockerrun.aws.json (Alpha)

Set Up XDP-ADC
**************

You’ll need to be in our beta.

Create a project
****************

Create a project in our beta portal.


Generate API key
****************

Generate a XDP-ADC API key for the created project.


Docker Compose
**************

To install the XDP-ADC Agent, add the XDP-ADC Daemon as an additional service to your docker-compose.yaml file, as shown below. If you want to version pin the XDP-ADC CLI, replace :code:`xdpadc:latest` with a specific version.

.. code-block:: yaml
    :linenos:

      services:
      ...
      xdpadc:
        container_name: xdpadc
        image: public.ecr.aws/xdpadc/xdpadc:latest
       
        env_file:
          - .env

        entrypoint: /xdpadc --project <your project here>

This configures the XDP-ADC Daemon to monitor for all traffic on the host, and upload it to the project you created earlier.

The daemon will receive the API key as an environment variable, and the next section describes how to configure the values that are placed in the .env file through the Amazon web console.

Add the XDP-ADC API key as an environment property
**************************************************

In the AWS console, go the "configuration" section of the Elastic Beanstalk environment where you'll be deploying XDP-ADC.

Edit the "software" category, and add environment properties named :code:`XDPADC_API_KEY_ID` and :code:`XDPADC_API_KEY_SECRET`, using the values of the API key you created.

Deploy and Verify
*****************

Deploy the new version of your application as you normally would. The XDP-ADC daemon will automatically start the protection when data is sent to and from your application. 


Dockerfile
**********

You have two options if you are using a Dockerfile for Elastic Beanstalk:

1. Single Dockerfile
2. Multiple Dockerfiles

Single Dockerfile
*****************

If your application has only a single Dockerfile, use :code:`xdpadc` as a wrapper around your normal entry point.

To do this, add the following line to your Dockerfile, which will install the latest XDP-ADC Daemon:

.. code-block:: bash
    :linenos:

    bash -c "$(curl -L https://releases.xdpadc.com/scripts/install_xdpadc.sh)"

Next, change the :code:`CMD` directive in your Dockerfile to run the XDP-ADC CLI and start your previous entry point as a subprocess:

.. code-block:: bash
    :linenos:

    CMD ["/usr/local/bin/xdpadc", "--project", "<your project name>", \
     "-u", "root", "-c", "<your normal commnand line>"]

You may instead choose to run XDP-ADC as a background process, but this requires writing a script that will do so during container start, before launching your normal main process.

Then Add the XDP-ADC API key as an environment property to make the API key available to the XDP-ADC Daemon.


Multiple Dockerfiles
********************

If you are using multiple Dockerfiles for your application, download the XDP-ADC Daemon's Debian package by running the below command:


.. code-block:: bash
    :linenos:

    bash -c "$(curl -L https://releases.xdpadc.com/scripts/install_xdpadc.sh)"

Then copy the package into the Dockerfile for installation.

Next, change the :code:`CMD` directive in your Dockerfile to run the XDP-ADC CLI and start your previous entry point as a subprocess:

.. code-block:: bash
    :linenos:

    CMD ["/usr/local/bin/xdpadc", "--project", "<your project name>", \
     "-u", "root", "-c", "<your normal commnand line>"]

You may instead choose to run XDP-ADC as a background process, but this requires writing a script that will do so during container start, before launching your normal main process.

Then Add the XDP-ADC API key as an environment property to make the API key available to the XDP-ADC Daemon.

Add the XDP-ADC API key as an environment property
**************************************************

In the AWS console, go the "configuration" section of the Elastic Beanstalk environment where you'll be deploying XDP-ADC.

Edit the "software" category, and add environment properties named :code:`XDPADC_API_KEY_ID` and :code:`XDPADC_API_KEY_SECRET`, using the values of the API key you created.

Deploy and Verify
*****************

Deploy the new version of your application as you normally would. The XDP-ADC daemon will automatically start the protection when data is sent to and from your application. 

Create an Application with Dockerrun.aws.json
*********************************************

Note: This installation method is in Alpha. Please contact us if you run into any difficulty, and we’ll be happy to help.

:code:`Dockerrun.aws.json` is an AWS ECS task definition that allows the XDP-ADC Daemon to run as a separate container using host networking (on Linux clusters). It allows you to avoid editing your existing container. Add the following container definition to your configuration file:

.. code-block:: text
    :linenos:

    {
     "containerDefinitions" : [
     ...
       {
         "name": "xdpadc",
         "image": "public.ecr.aws/xdpadc/xdpadc:latest",
         "essential": false,
         "memory": 256,
         "networkMode": "host",
         "entrypoint": ["/xdpadc", "--project", "<your project here>"]
       }
     ]
     ...
    }

This will start an instance of the XDP-ADC Daemon on each host, and protect web apps from all the network traffic on that host.

Add the XDP-ADC API key as an environment property
**************************************************

In the AWS console, go the "configuration" section of the Elastic Beanstalk environment where you'll be deploying XDP-ADC.

Edit the "software" category, and add environment properties named :code:`XDPADC_API_KEY_ID` and :code:`XDPADC_API_KEY_SECRET`, using the values of the API key you created.


Deploy and Verify
*****************

Deploy the new version of your application as you normally would. The XDP-ADC daemon will automatically start the protection when data is sent to and from your application. 


.. toctree::
   :maxdepth: 2
   :caption: Contents:
