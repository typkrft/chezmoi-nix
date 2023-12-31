{ ... }: {
  programs.navi = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      finder = {
        command = "fzf";
      };
    
      cheats = {
        paths = [ 
          "~/.config/navi"
          "~/Library/Application Support/navi/cheats"
        ];
      };
    
      shell = {
        command = "zsh";
      };
    };
  };

  home.file."navi.cheat" = {
    enable = true;
    target = ".config/navi/navi.cheat";
    text = ''
      % macOS

      # macOS Service Actions
      sudo launchctl <action> <service>

      $ action: echo "stop\nstart\ndisable\nenable\nunload\nload"
      $ service: \ls /System/Library/LaunchDaemons

      % scp

      # Local -> Remote w/ Key Note: Spaces should be triple escaped eg: `Test\\\ Folder`
      scp -i <key> -F $HOME/.ssh/config <local_path> <server_name>:<remote_path>

      $ key: echo -e "test" |  \ls .ssh | sed -E -e 's/^[^id_]|^known.*|config|\..*$//g' -e 's/(.*)/\~\/\.ssh\/\1/g'| uniq | sed -E -e '/^$/d' -e '$ d' -e '1d'
      $ server_name: \ls .ssh | sed -E -e 's/^id\_|^known.*|config|\..*$//g' | uniq | sed -E -e '/^$/d'

      % ssh

      # create key
      ssh-keygen -t ed25519 -C "<comment>"

      $ comment: 

      # copy key to server 
      ssh-copy-id -i $HOME/.ssh/<key> <user>@<ip_or_hostname>

      $ key: \ls .ssh | grep '.pub'
      $ user: 

      % gnupg,security

      # Create GPG Key
      gpg --gen-key

      # Export GPG Private Key -- Print for Cold Storage and delete or store elsewhere
      gpg --export-secret-keys --armor <id_hash> > <key_name>.asc

      $ id_hash: gpg --list-secret-keys | grep -E '[[:alnum:]]{40}' | sed -E -e 's/ //g' | fzf --preview "gpg --list-key {}"

      # Export GPG Public Key 
      gpg --armor --export <key_email> > <key_name>.gpg

      # Import Public or Private Key
      gpg --import <gpg_key>

      $ gpg_key: \ls ~/*.gpg && \ls ~/*.asc

      # Delete Private keys
      gpg --delete-secret-keys <id_hash>

      $ id_hash: gpg --list-secret-keys | grep -E '[[:alnum:]]{40}' | sed -E -e 's/ //g' | fzf --preview "gpg --list-key {}"

      # Delete Public keys
      gpg --delete-keys <id_hash>

      $ id_hash: gpg --list-keys | grep -E '[[:alnum:]]{40}' | sed -E -e 's/ //g' | fzf --preview "gpg --list-key {}"

      % text processing

      # Remove whitespace from a string
      echo <string> | xargs | pbcopy

      # Count Words
      echo -e "<string>" | wc -w | sed 's/ //g'

      % git

      # Pull File/Folder from another branch
      git pull origin; git checkout <branch> -- <path>

      $ branch: git pull origin; git branch -r

      % gif

      # Convert Video to gif, Scale = 480, 720, 1080 etc
      ffmpeg -y -i <input_file> -filter_complex "fps=<frames_per_second>,scale=<scale>:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=<colors>[p];[s1][p]paletteuse=dither=bayer" <output_file>.gif

      $ scale: echo -e "360\n 380\n 720\n 1080"
      $ colors: echo -e "32\n 256"

      % Networking
      # Check ports (Individul or range -)
      nc -zcw10 <IP_HOSTNAME> <PORTs>

      % pdf

      # Donwload Webpage as PDF 
      curl --request POST 'https://demo.gotenberg.dev/forms/chromium/convert/url' --form 'url="<URL>"' -o <PDF_NAME>.pdf

      % hdd

      # Copy two Drives - Boot into live env if host hdd source - eg /dev/hda 
      sudo dd bs=4M conv=sync,noerror status=progress if=<SOURCE> of=<DESTINATION> 

      % docker

      # Dump container Contents
      sudo docker export <CONTAINER_NAME> > <FILE_NAME>.tar

      # Stop all Containers 
      sudo docker stop $(sudo docker container ls -q)

      % ansible
      # Boot Strap Fedora Cloud
      ansible-playbook ~/.dots/ansible/bootstrap/fedora_cloud/init.yml -e "{target: <ANSIBLE_TARGET>}" -e "{target_user: <REMOTE_HOST_USER>}" -i <PATH_TO_HOST_FILE>


      % Files
      # Check Directory size
      du -sh <Folder>

      $ Folder: /bin/ls 

      % TrueNAS
      # Rename Dataset ZFS list for the old names
      sudo zfs rename <old_name> <new_name>

      % Digital Certificates
      # List Ceritifcates
      pk12util -d sql:$HOME/.pki/nssdb -L

      # Rename Digital Certificate 
      certutil -d sql:$HOME/.pki/nssdb --rename -n <current_name> --new-n <new_name>

      # Import Personal Certificate
      pk12util -d sql:$HOME/.pki/nssdb -i <path_to_cert>

      # Create a New Database
      certutil -N -d sql:$HOME/.pki/nssdb -L --empty-password
    '';
  };
}