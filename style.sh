#!/bin/bash
cd /home/neural-style
start=$SECONDS

#============================================================
#=============NEURAL STYLE PARAMETERS========================
#============================================================
#These settings are to be played with; change the content 
#and style images, the image width, iterations, etc.
#You can find a full list of settings at 
#https://github.com/anishathalye/neural-style

python neural_style.py \
	--content $(pwd)/images/{YOUR CONTENT IMAGE HERE}.jpg \
	--styles $(pwd)/images/YOUR STYLE IMAGE HERE}.jpg \
	--output $(pwd)/output.jpg \
	--width 500 \
	--iterations 500 \
	--style-layer-weight-exp 1.0
#============================================================

duration=$(( SECONDS - start ))

#============================================================
#=============EMAIL NOTIFICATION SETTINGS====================
#============================================================
#fill in the following parameters as follows:
#	-dest: an email address to send the results to
#	-tag:  a name by which to identify this result
# ie, --dest email@email.com --tag ChicagoWave

python ocEmail.py --dest {YOUR EMAIL HERE} --tag {YOUR TAG HERE} --timer $duration
#============================================================

echo "email sent!"
sleep 1000000000