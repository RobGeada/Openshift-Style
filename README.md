# Openshift-Style

This is a containerization of Anish Athalye's [Neural-Style implementation](https://github.com/anishathalye/neural-style) to allow for easy deployment to OpenShift clusters. See this [slide deck](https://docs.google.com/a/redhat.com/presentation/d/1xvOtt2dJET_0PI4oYtB6AjsAIjrzZ9zLdQyAfwuTNlU/edit?usp=sharing) for a high-level overview.

## Prerequisites
* Docker
* OpenShift (the oc command must be in your path)

## Setup
1. Clone this repo into any directory
2. Make sure the Docker daemon is running
3. Make sure you are logged in to your OpenShift cluster via `oc login`

## Usage
1. Place your desired style and content images into `/images`, if necessary
2. Modify style.sh as necessary (see "Using style.sh" below)
3. Run `make build tag={YOUR TAG HERE}`. The tag will serve as the Docker tag and OpenShift pod name for this run, so choose something descriptive. If the rgeada/style:base image has not yet been pulled to your system, this command will pull it automatically, which may take a while.
4. Wait for the pod to deploy on OpenShift. The first time you deploy a style pod to your cluster may take a little while; the image is pretty large and takes a while to deploy. It's possible that the deployment pod will auto-terminate if it doesn't deploy within ten minutes, if this happens, simply redeploy via the OpenShift web interface. Once a style pod has been successfully deployed to OpenShift, however, subsequent pods should deploy much, much faster.
5. Wait for Neural-Style to finish! You can check on its progress in the style pod logs. Once it has finished, you will receive an email containing the generated image.
6. Run `make clean tag={YOUR TAG HERE}`. The tag here should be the same tag used when building; this will clear the pods from OpenShift as well as remove the style:{tag} image from your local system. The style:base image will remain until you decide to delete it; I wouldn't make you re-pull it every time!

## Using style.sh
The Neural Style run within the style pod is controlled by the parameters found in  `style.sh`. In `style.sh`, there are two sections to be modified before each run:

#### NEURAL STYLE PARAMETERS:
---
There are four main parameters here:
* Content: This is the name of your content image within `/images`, ie, `$(pwd)/images/chicago.jpg`
* Style: This is the name of your style image  within `/images`, ie, `$(pwd)/images/wave.jpg`
* Width: This is the output width of your generated image. The height will be automatically set according to aspect ratio of the content image.
* Iterations: The number of iterations to train the net over

All other parameters are detailed [here](https://github.com/anishathalye/neural-style).

#### EMAIL NOTIFICATION SETTINGS:
---
Here we adjust the settings sent to [`ocEmail.py`](https://github.com/RobGeada/openshift_style/blob/master/ocEmail.py), a Python script I wrote to send images via email programmatically. I use it here to automatically send the generated images from OpenShift to a specified address once Neural-Style has finished. If you'd rather `rsh` into the pod once it has finished to recover the generated image, then just comment out the line `python ocEmail.py ...` in style.sh.

There are two parameters here:
* Dest: This is the email address to send the generated image to.
* Tag: This identifies the image being sent, so it helps if it matches the tag used in your `build` command
