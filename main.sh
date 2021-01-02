main() {

    echo '==========================================='
    echo 'Welcome to BismillahSysprog'
    echo '==========================================='

    COLUMNS=12
    PS3='Choose device to reconfigure: '
    options=("Webcam" "Ethernet" "Exit Script")
    select opt in "${options[@]}"
    do
        case $opt in
            "Webcam")
                bash webcam.sh
		exit
                ;;
            "Ethernet")
                bash ethernet.sh
		exit
                ;;
            "Exit Script")
                echo 'Exiting Script'
                read -p 'Press [Enter] key to continue...'
                exit
                ;;
            *)
        esac
    done
}

main