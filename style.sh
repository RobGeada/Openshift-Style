#!/bin/bash
cd /home/neural-style
start=$SECONDS

#run neural_style
python neural_style.py \
	--content $(pwd)/images/chicago.jpg \
	--styles $(pwd)/images/wave.jpg \
	--output $(pwd)/output.jpg \
	--width 50 \
	--iterations 50 \
	--style-layer-weight-exp 2.0

duration=$(( SECONDS - start ))
python ocEmail.py --dest rob@geada.net --tag chicago --timer $duration
echo "email sent!"
sleep 1000000000