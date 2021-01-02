webcam() {
    PS3='Choose parameter to configure: '  
options=("Information" "Quirk" "Back")
    select opt in "${options[@]}"
    do
        case $opt in

            "Information")
       		header
		echo "The uvcvideo driver includes a table of device identifies with their associated quirks. If your device isn't listed and you suspect it might need one or more quirks, you can force them manually through the module quirks parameter. "
		echo
		
		echo "UVC_QUIRK_FIX_BANDWIDTH"
		echo "---0x00000080"
		echo "---Try to estimate the bandwidth required for uncompressed streams instead on relying on the value reported by the camera. See FAQ 7 for more information."
		echo
		
		echo "UVC_QUIRK_RESTRICT_FRAME_RATE"
		echo "---0x00000200"
		echo "---Ignore all frame intervals reported by the device but the first one. This quirk is used for a specific device that reports buggy frame intervals, making the image severely underexposed when selected."
		echo
		
		
		bash webcam.sh

                ;;
            "Quirk")
		q_tmp=0
		read -r -p "1. Set Fix Bandwidth (y/n)" op1
		read -r -p "2. Restrict Frame Rate (y/n)" op2
		if [[ "$op1" == "y" ]] 
		then
			q_tmp=$(( $q_tmp + 128 ))
		fi

		if [[ "$op2" = "y" ]] 
		then
			q_tmp=$(( $q_tmp + 512 ))
		fi


		sudo rmmod uvcvideo
		sudo modprobe -r uvcvideo
		sudo modprobe uvcvideo quirks=$q_tmp
		header

		bash main.sh
		

                ;;


            "Back")
		bash main.sh
                exit
                ;;
            *)
        esac
    done
}

header() {
	echo
	echo '=====DEVICE INFORMATION====='
	echo 'Current paremeter value :'
    	echo --- quirk : $(cat /sys/module/uvcvideo/parameters/quirks)    	
	echo '============================'
	echo

}

webcam
