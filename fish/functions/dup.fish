function dup
    set os_name (uname)

    switch $os_name
        case "Darwin"
            # macOS-specific commands
            brew upgrade
            brew upgrade wezterm@nightly
            brew install --cask font-monaspace-nerd-font

            npm update -g

            bun upgrade
            bun-update

            tldr --update

        case "Linux"
            if test -f /etc/os-release
                set distro_name (awk -F= '/^ID=/{gsub(/"/,""); print $2}' /etc/os-release)

                switch $distro_name
                    case "opensuse-tumbleweed"
                        sudo zypper ref
                        sudo zypper dup --allow-vendor-change

                    case "debian" "ubuntu"
                        sudo apt update
                        sudo apt full-upgrade
                        sudo apt autoremove --purge
                        sudo apt clean

                    case '*'
                        echo "This Linux distribution is not supported. Exiting."
                end
            else
                echo "Cannot determine Linux distribution. Exiting."
            end

        case '*'
            echo "Unsupported operating system: $os_name. Exiting."
    end

    if type -q bob
        bob use nightly
    end

    if type -q cargo
        rustup update

        if cargo help install-update > /dev/null 2>&1
            cargo install-update -a
        else
            echo "cargo install-update is not installed. Skipping."
        end
    end
end
