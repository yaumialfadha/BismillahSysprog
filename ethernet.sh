ethernet() {
    PS3='Choose parameter to configure: '
    options=("Set to default" "Copybreak" "Back")
    select opt in "${options[@]}"
    do
        case $opt in

            "Set to default")
                modprobe e1000 copybreak=256
		echo 'Paremeter is being set to default'
		header
		read -p 'Press any key to continue'
		bash main.sh

                ;;
            "Copybreak")
		header
                set_cb
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
	echo '=====DEVICE INFORMATION====='
	echo 'Parameter default value :'
	echo '--- copybreak : 256'
	echo 'Current paremeter value :'
    	echo --- copybreak : $(cat /sys/module/e1000/parameters/copybreak)
    	echo '============================'

}
set_cb() {
	read -p 'Set Copybreak value: ' cb
	sudo -S modprobe -r e1000
	sudo -S modprobe e1000 copybreak=$cb
	header
	read -p 'Press any key to continue'
	bash main.sh
}

ethernet