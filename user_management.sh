#!/bin/bash

meid=$(id -u)

function ctrl_c(){
  echo -e "\n[!] Closing script..."
  exit 1
}

# Ctrl C
trap ctrl_c INT

function helpPanel(){

  echo -e '[+] Welcome to Help Menu, here you can find main option for user management tool:'
  echo -e '[+] Add more users enter a)' 
  echo -e '[+] Delete users enter d)'
  echo -e '[+] Modify user parameters enter m)'
  
  while true; do
    read -p "Do you want more details? Enter a), d) or m) to display, enter s) to exit:" option

     case $option in
      
      a)
        
        echo -e '[+] a) option recomendation:'
        echo -e '\t [+] User should not exist on the system to be deleted.'
        echo -e '\t [+] Password musst be enter correctly.'
        echo -e '\t [+] Home path directory should have this structure '/home/username' to avoid issues and uid cannot be register on the system.'
        break
        ;;

      d)
        
         echo -e '[+] d) option recomendation:'
         echo -e '\t [+] User must exist on the system to be deleted.'
         echo -e '\t [+] Type the user correctly.'
         break
         ;;

      m)
         
         echo -e '[+] m) option recomendation:'
         echo -e '\t [+] gid: Please do not enter the same gid of current user and do not enter a gid that already exist on the system.'
         echo -e '\t [+] comment: The comment must be clear to avoid misundertending.'
         echo -e '\t [+] login: Login information must be unique. '  
         echo -e '\t [+] uid: Uid must be different of those registered on the system.'
         echo -e '\t [+] homepath: It is recomended the directory have this structure '/home/username' to avoid issues. ' 
         break
         ;;

      s)
        ctrl_c
        ;;

      *)

         echo " "
         echo "[!] Invalid option, please enter a), d), m) or s)."
         ;;

     esac


    

  done

}

function add_user(){

   while true; do

     read -p "Do you want to use default settings for the user? Please enter yes or no: " option
     read -p "Enter username: " username
     id $username > /dev/null 2>&1

     if [ $? -ne 0 ]; then 
       echo -e '[+] User is available.'

       if [ $option == "yes" ]; then
         useradd -m -s /bin/bash $username 
         passwd $username 
        
           
         if [ $? -ne 0 ]; then
           userdel -r $username > /dev/null 2>&1  
           groupdel $username  > /dev/null 2>&1
           echo -e '\n[!] There was an error related to the password. Please try again.\n'

         else
           echo -e '\n[+] User and password created succesfully'
           break

         fi

       elif [ $option == "no" ]; then
        echo -e "[+] Please enter uid and home path: "
        read -p "uid: " uid
        read -p "home path: " homepath
        useradd -u $uid -m -d $homepath -s /bin/bash $username 2> /dev/null
        
        if [ $? -eq 0 ]; then 
          passwd $username

          if [ $? -ne 0 ]; then
            echo -e '\n[!] There was an error related to the password. Please try again.\n'
            userdel -r $username

          else 
            echo -e '[+] User and password created succesfully.'
            break
          
          fi

        else 
          echo -e "[!] There was an error creating the user, remember that the parameters must be unique."
          break
        
        fi

       else
        echo -e "[!] Please enter a valid option, yes or no."

       fi

     else
        echo -e "[!] User already in the system, please try other name. " 
     
     fi
   done

}

function delete_user(){

     echo -e '[!] Use this option with caution, user will be permanently deleted from the system.'
     read -p "Enter username: " username
     userdel -r $username  2> /dev/null
    
     if [ $? -ne 0 ]; then
      echo -e '[!] User does not exits on the system.'

     else
      echo -e '[+] User was deleted.'

     fi

}

function mod_user(){
 
 declare -A actions
 actions["login"]="mod_login"
 actions["uid"]="mod_uid"
 actions["gid"]="mod_gid"
 actions["comment"]="mod_comment"
 actions["homepath"]="mod_homepath"


    function mod_login() {
      
      echo -e "[+] It is recommended that this value be changed last.\n"
      read -p "Enter new login for the user: " input
      usermod -l $input $username 2> /dev/null
   
      if [ $? -ne 0 ]; then
        echo -e '[!] Login value cannot be change. Please check help for recomendations.'  

      else
        echo -e "[+] Login value was changed to $input."
        
      fi 

      }

    function mod_uid(){
   
      read -p "Enter new uid for the user: " input
      usermod -u $input $username 2> /dev/null
   
      if [ $? -ne 0 ]; then
        echo -e '[!] Uid value cannot be change. Please check help for recomendations.'  

      else
        echo -e "[+] Uid value was changed to $input"

      fi


    }

 
    function mod_gid() {

      read -p "Enter new gid for the user: " input
      usermod -g $input $username 2> /dev/null
      
      if [ $? -ne 0 ]; then
        echo -e '[!] Gid value cannot be change. Please check help for recomendations.'  

      else
        echo -e "[+] Gid value was changed to $input"

      fi

    }

    function mod_comment(){

      read -p "Enter new comment for the user: " input
      usermod -c "$input" $username 2> /dev/null
   
      if [ $? -ne 0 ]; then
        echo -e '[!] Comment cannot be change. Please check help for recomendations.'  

      else
        echo -e "[+] Comment was changed to $input"

      fi


    } 

    function mod_homepath() {

      echo -e 'The homepath must follow this syntax: /home/path '
      read -p "Enter new homepath for the user: " input
      usermod -d $input $username 2> /dev/null
   
      if [ $? -ne 0 ]; then
        echo -e '[!] Homepath cannot be change. Please check help for recomendations.'  

      else
        echo -e "[+] Homepath was changed to $input"

      fi

    }


  while true; do
   
   read -p "Enter the user: " username
   id $username > /dev/null 2>&1

   if [ $? -eq 0 ]; then 
       echo -e "[+] User $check_username exist in the system."
       sleep 5
       echo -e '[+] Please enter parameter for change: '

       for option in ${!actions[@]}; do
         echo -e "- $option"
    
       done

       read -p 'Option: ' user_option

       for option in "${user_option}"; do

         if [[ -n ${actions[$user_option]} ]]; then
           ${actions[$user_option]}
           
           read -p '[+] Enter "yes" if you want to continue with modification or "no" if you want to exit: ' option

           if [ $option == "yes" ]; then
             continue

           elif [ $option == "no" ]; then
             echo -e "[!] Closing script."
             exit 0

           else
            echo -e "[!] Invalid option. Please enter yes or no"

           fi

         else
           echo -e '[!] Please enter a valid option.'

         fi

       done
   

   else
      echo -e '[!] This user does not exist.'

   fi
  done   


}

if [ $meid == 0 ]; then
  while true; do
      read -p "[+] Please enter a valid option, for help enter h): " option
    
      case $option in
      
        a)
        
          add_user
          break
          ;;

        d)
        
          delete_user
          break
          ;;

        m)

          mod_user
          break
          ;;

        h)

          helpPanel
          break
          ;;

        *)

          echo " "
          echo "[!] Invalid option, please enter h) for help!"
          ;;

      esac

  done

else 

  echo -e "[!] You must be superuser to execute this script!"
  exit 1

fi

