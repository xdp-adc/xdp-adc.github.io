XDP-ADC: Get Started with AWS ECS
=================================

Getting started with XDP-ADC is as simple as dropping our daemon into your service or stack. Once we’re in, XDP-ADC protects your system based on the configured security rules. 

Below are instructions for installing the XDP-ADC Daemon in your staging or production environment in Amazon Elastic Container Service (ECS).

You will be attaching the XDP-ADC Daemon to the host network, and you can run the agent alongside your existing ECS containers. To set up the XDP-ADC Daemon you will:

1. Meet the prerequisites
2. Create an XDP-ADC Project
3. Generate an API key for the XDP-ADC Daemon
4. Write a Docker Compose file for the XDP-ADC Daemon
5. Write an ECS configuration file for the XDP-ADC Daemon
6. Create a new ECS project to launch the XDP-ADC Daemon
7. Verify that the XDP-ADC Daemon is working

Once you’ve successfully set up the XDP-ADC Daemon, you can proceed to scale up your deployment.


Prerequisites
*************

- You’ll need to be in our beta.
- You must have a Linux cluster in ECS for XDP-ADC to work. 
- You must have access to the host network. The XDP-ADC Daemon will be installed there.

Create a project
****************

Create a project in our beta portal.


Generate API key
****************

Generate a XDP-ADC API key for the created project.


Write Docker Compose file
*************************

Create a Docker Compose file to define an XDP-ADC Daemon that captures on a continuous basis. We suggest naming it xdpadc-compose.yaml.

You will need your API key and API key secret from the previous step, as well as the Project name you created.

For production use, add a logging section in the definition to capture logs.

If you want to version pin the XDP-ADC Daemon, replace :code:`xdpadc:latest` with a specific version.

.. code-block:: yaml
    :linenos:

        version: '3'
		services:
		  xdpadc:
		    image: public.ecr.aws/xdpadc/xdpadc:latest
		    environment:
		      - XDPADC_API_KEY_ID=apk_XXXXXXXXXX
		      - XDPADC_API_KEY_SECRET=XXXXXXXXXX
		    entrypoint: /xdpadc --project my-project-name

The example configuration uses our public ECR repository to avoid rate-limiting problems pulling from Docker Hub.

Write an ECS Configuration File
*******************************

You will need to create a new ECS configuration file called xdpadc-params.yaml. It should look like:

.. code-block:: yaml
    :linenos:

        version: 1
		task_definition:
		  ecs_network_mode: host
		run_params:
		  task_placement:
		    constraints:
		      - type: distinctInstance

The settings cause the XDP-ADC Daemon to monitor all traffic on the host, and ensure that only one XDP-ADC container is run per host.


Create New ECS Project
**********************

Once the configuration file is in place, turn the XDP-ADC Daemon on with the following command:

.. code-block:: bash
    :linenos:

    ecs-cli compose -p xdpadc-protect -f xdpadc-compose.yaml --ecs-params xdpadc-params.yaml service up  --cluster-config <mycluster>

This creates a new project named :code:`xdpadc-protect` and configures a service based on the previous two YAML files. The service is initialized with a desired container count of 1.

verify
******

You can verify that the container has started with :code:`ecs-cli ps`, or view its log output if you configured a logging section in the UI.

Scaling up
**********

Once you have verified that traffic is successfully being captured, you can scale up to more capture Agents using the following command:

.. code-block:: bash
    :linenos:

    ecs-cli compose -p xdpadc-capture service scale NNN

