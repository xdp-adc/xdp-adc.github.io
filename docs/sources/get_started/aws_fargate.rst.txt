XDP-ADC: Get Started with AWS Fargate
=====================================

Getting started with XDP-ADC is as simple as dropping our daemon into your service or stack. Once we’re in, XDP-ADC protects your system based on the configured security rules.

Below are instructions for installing the XDP-ADC Daemon in your staging or production environment in Amazon Fargate. To use XDP-ADC, you’ll need to be in our beta.

You will be configuring Fargate to run the XDP-ADC Daemon as a sidecar in each container you deploy. To set up the XDP-ADC Daemon you will:

1. Create an XDP-ADC Project
2. Generate an API key for the XDP-ADC Daemon
3. Add the XDP-ADC Daemon to your task definition
4. Launch your updated task definition
5. Verify that the XDP-ADC Daemon is working

Create a project
****************

Do we have a project concept?


Generate API key
****************

As the question above?


Add to task definition
**********************

Within the containerDefinitions section of your task, add a new section containing the XDP-ADC Docker image as shown below.

Fill in the workspace name and the API key that you created earlier.

Specify a logConfiguration section in order to see the output from the XDP-ADC Daemon. Use the destination where you store your application logs, or store them separately.

.. code-block:: text
    :linenos:

    ...
	"containerDefinitions": [
	  ...
	  {
	        "name": "xdpadc",
	        "image": "public.ecr.aws/xdpadc/xdpadc:latest",
	        "entryPoint": ["/xdpadc", "--project", "{project name}"],
	        "environment" : [
	             { "name" : "XDPADC_API_KEY_ID", "value" : "{key id}" },
	             { "name" : "XDPADC_API_KEY_SECRET", "value" : "{key secret}" }
	         ]
	    }
	]


The XDP-ADC token can also be stored in an AWS Secret instead.

If you edit the task definition from the console, the settings look like the following, though please note that the entry point is comma-separated on the console :code:`/xdpadc,--project,{project_name}`.

Launch task definition
**********************

Once the task definition is saved, update your service as you ordinarily would. The XDP-ADC Agent will automatically start protecting your services.

verify
******

You will be able to use the following command to check the logs of XDP-ADC daemon. Once you see ***XDP-ADC reports for duty...*** in the logs, it's running successfully.

.. code-block:: bash
    :linenos:

    xdpadc logs
